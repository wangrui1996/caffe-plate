from __future__ import print_function
import caffe
from google.protobuf import text_format
from caffe import layers as L
from caffe import params as P
from caffe.proto import caffe_pb2
from caffe.model_libs import PlateNetBody

def check_if_exist(path):
  return os.path.exists(path)

def make_if_not_exist(path):
  if not os.path.exists(path):
    os.makedirs(path)

import math
import os
import shutil
import stat
import subprocess
import sys

### Modify the following parameters accordingly ###
# The directory which contains the caffe code.
# We assume you are running the script at the CAFFE_ROOT.
caffe_root = os.getcwd()
# Modify the job name if you want.
job_name = "vehicle"

dataset_name = "plate"
# Set true if you want to start training right after generating all files.
run_soon = True
# Set true if you want to load from most recently saved snapshot.
# Otherwise, we will load from the pretrain_model defined below.
resume_training = True

#
copy_model = True

# If true, Remove old model files.
remove_old_models = False

train_txt = "data/{}/trainval.txt".format(dataset_name)
test_txt = "data/{}/test.txt".format(dataset_name)

# Specify the batch sampler.
blank_label = 10
resize_width = 80
resize_height = 30
expand_ratio = 1.1
cutting_ratio = 0.3
prob = 2.0
batch_size = 512
resize = "{}x{}".format(resize_width, resize_height)
params_str = {
  'label_txt': train_txt,
  'batch_size': batch_size,
  'height': resize_height,
  'width': resize_width,
  }


#params_str = "{\'label_txt\': \'{}\', \'batch_size\': ""{}, \'height\': {}, \'width\': {}, \'expand_ratio\': 1.1, \'cutting_ratio\': 0.3, \'prob\': 0.7,   \'train\': True,}".format(train_txt, batch_size, resize_height, resize_width)

# If true, use batch norm for all newly added layers.
# Currently only the non batch norm version has been tested.
use_batchnorm = False
lr_mult = 0.1
# Use different initial learning rate.
base_lr =  0.0001



# The name of the model. Modify it if you want.
model_name = "{}_{}".format(job_name, dataset_name)

# Directory which stores the model .prototxt file.
save_dir = "models/{}/{}".format(job_name, dataset_name)
# Directory which stores the snapshot of models.
snapshot_dir = "models/{}/{}".format(job_name, dataset_name)
# Directory which stores the job script and log file.
job_dir = "jobs/{}/{}".format(job_name, dataset_name)

# model definition files.
train_net_file = "{}/train.prototxt".format(save_dir)
test_net_file = "{}/test.prototxt".format(save_dir)
deploy_net_file = "{}/deploy.prototxt".format(save_dir)
solver_file = "{}/solver.prototxt".format(save_dir)
# snapshot prefix.
snapshot_prefix = "{}/{}".format(snapshot_dir, model_name)
# job script path.
job_file = "{}/{}.sh".format(job_dir, model_name)



num_classes = 33
neg_pos_ratio = 3.
loc_weight = (neg_pos_ratio + 1.) / 4.

# parameters for generating priors.
# minimum dimension of input image

# Solver parameters.
# Defining which GPUs to use.
gpus = "0"
gpulist = gpus.split(",")
num_gpus = len(gpulist)

# Divide the mini-batch to different GPUs.

accum_batch_size = 32
iter_size = accum_batch_size / batch_size
solver_mode = P.Solver.CPU
device_id = 0
batch_size_per_device = batch_size
if num_gpus > 0:
  batch_size_per_device = int(math.ceil(float(batch_size) / num_gpus))
  iter_size = int(math.ceil(float(accum_batch_size) / (batch_size_per_device * num_gpus)))
  solver_mode = P.Solver.GPU
  device_id = int(gpulist[0])


# Evaluate on whole test set.
num_test_image = 100
test_batch_size = 64
# Ideally test_batch_size should be divisible by num_test_image,
# otherwise mAP will be slightly off the true value.
test_iter = int(math.ceil(float(num_test_image) / test_batch_size))

solver_param = {
    # Train parameters


    'base_lr': base_lr,
  'stepsize': 25000,
    'weight_decay': 0.0005,
    'lr_policy': "step",
    'gamma': 0.1,
    'momentum': 0.9,
    'max_iter': 1200000,
    'snapshot': 25000,
    'display': 50,
    'solver_mode': solver_mode,
    'device_id': device_id,
    'test_iter': [test_iter],
    'test_interval': 500,
    'clip_gradients' : 5000

    }
### Hopefully you don't need to change the following ###
# Check file.
check_if_exist(train_txt)
check_if_exist(test_txt)
#check_if_exist(pretrain_model)
make_if_not_exist(save_dir)
make_if_not_exist(job_dir)
make_if_not_exist(snapshot_dir)

### Hopefully you don't need to change the following ###
# Check file.

# Create train net.
net = caffe.NetSpec()

params_str['train'] = True
params_str['label_txt'] = train_txt
net.data, net.label = L.Python(name="data", ntop=2, python_param={
  'module': "pythonLayer",
  'layer':  "PlateDataLayer",
  'param_str': str(params_str)
})
body_layer = PlateNetBody(net, net.data, resize_width, num_classes)
ctc_kwargs = {
  'loss_weight': [1.0]
}
net.ctc_loss = L.CtcLoss(body_layer.fc1, net.label, blank_label=blank_label, alphabet_size=num_classes+1, time_step=resize_width, **ctc_kwargs)
with open(train_net_file, 'w') as f:
  print('name: "{}_train"'.format(model_name), file=f)
  print(net.to_proto(), file=f)
shutil.copy(train_net_file, job_dir)




# Create test net
net = caffe.NetSpec()

params_str['train'] = False
params_str['label_txt'] = test_txt
net.data, net.label = L.Python(name="data", ntop=2, python_param={
  'module': "pythonLayer",
  'layer':  "PlateDataLayer",
  'param_str': str(params_str)
})

body_layer = PlateNetBody(net, net.data, resize_width, num_classes)
ctc_kwargs = {
  'loss_weight': [1.0]
}
net.ctc_loss = L.CtcLoss(body_layer.fc1, net.label, blank_label=blank_label, alphabet_size=num_classes+1, time_step=resize_width, **ctc_kwargs)
net.premuted_fc = L.Permute(body_layer.fc1, order=[1,0,2])
net.accuracy = L.LabelsequenceAccuracy(net.premuted_fc, net.label, blank_label=blank_label)

with open(test_net_file, 'w') as f:
    print('name: "{}_test"'.format(model_name), file=f)
    print(net.to_proto(), file=f)
shutil.copy(test_net_file, job_dir)

# Create deploy net.
# Remove the first and last layer from test net.
deploy_net = net
with open(deploy_net_file, 'w') as f:
    net_param = deploy_net.to_proto()
    # Remove the first (AnnotatedData) and last (DetectionEvaluate) layer from test net.
    del net_param.layer[0]
    del net_param.layer[-1]
    net_param.name = '{}_deploy'.format(model_name)
    net_param.input.extend(['data'])
    net_param.input_shape.extend([
        caffe_pb2.BlobShape(dim=[1, 3, resize_height, resize_width])])
    print(net_param, file=f)
shutil.copy(deploy_net_file, job_dir)

# Create solver.
solver = caffe_pb2.SolverParameter(
        train_net=train_net_file,
        test_net=[test_net_file],
        snapshot_prefix=snapshot_prefix,
        **solver_param)

with open(solver_file, 'w') as f:
    print(solver, file=f)
shutil.copy(solver_file, job_dir)

max_iter = 0
# Find most recent snapshot.
for file in os.listdir(snapshot_dir):
  if file.endswith(".solverstate"):
    basename = os.path.splitext(file)[0]
    print(basename)
    iter = int(basename.split("{}_iter_".format(model_name))[1])
    if iter > max_iter:
      max_iter = iter

train_src_param = ''

if resume_training:
  if max_iter > 0:
    train_src_param = '--snapshot="{}_iter_{}.solverstate" \\\n'.format(snapshot_prefix, max_iter)

if copy_model:
  if max_iter > 0:
    train_src_param = '--weights="{}_iter_{}.caffemodel" \\\n'.format(snapshot_prefix, max_iter)
#train_src_param = ""

if remove_old_models:
  # Remove any snapshots smaller than max_iter.
  for file in os.listdir(snapshot_dir):
    if file.endswith(".solverstate"):
      basename = os.path.splitext(file)[0]
      iter = int(basename.split("{}_iter_".format(model_name))[1])
      if max_iter > iter:
        os.remove("{}/{}".format(snapshot_dir, file))
    if file.endswith(".caffemodel"):
      basename = os.path.splitext(file)[0]
      iter = int(basename.split("{}_iter_".format(model_name))[1])
      if max_iter > iter:
        os.remove("{}/{}".format(snapshot_dir, file))

# Create job file.
with open(job_file, 'w') as f:
  f.write('cd {}\n'.format(caffe_root))
  f.write('./build/tools/caffe train \\\n')
  f.write('--solver="{}" \\\n'.format(solver_file))
  f.write(train_src_param)
  if solver_param['solver_mode'] == P.Solver.GPU:
    f.write('--gpu {} 2>&1 | tee {}/{}.log\n'.format(gpus, job_dir, model_name))
  else:
    f.write('2>&1 | tee {}/{}.log\n'.format(job_dir, model_name))

# Copy the python script to job_dir.
py_file = os.path.abspath(__file__)
shutil.copy(py_file, job_dir)
# Run the job.
os.chmod(job_file, stat.S_IRWXU)
if run_soon:
  subprocess.call(job_file, shell=True)