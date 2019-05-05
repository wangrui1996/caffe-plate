import os

import caffe

from caffe import layers as L
from caffe import params as P

from caffe.proto import caffe_pb2

def WarpctcNetBody(net, data_layer, time_step, num_classes):
#  lstm_kwargs = {
 #   'weight_filler': dict(type='xavier'),
  #  'bias_filler': dict(type='constant', value=0)}

  kwargs = {
    'param': [dict(lr_mult=1, decay_mult=1), dict(lr_mult=2, decay_mult=0)],
    'weight_filler': dict(type='xavier'),
    'bias_filler': dict(type='constant', value=0)}

#  assert from_layer in net.keys()  # 48 x 48

  recurrent_param = {
    'num_output': 100,
    'weight_filler': dict(type='xavier'),
    'bias_filler': dict(type='constant', value=0)
  }
  net.indicator = L.ContinuationIndicator(time_step=time_step, batch_size=512)
  net.permuted_data = L.Permute(data_layer, order=[3, 0, 1, 2])
  net.lstm1 = L.LSTM(net.permuted_data, net.indicator, recurrent_param=recurrent_param)
  net.lstm2 = L.LSTM(net.lstm1, net.indicator, recurrent_param=recurrent_param)
  net.fc1 = L.InnerProduct(net.lstm2, num_output=num_classes+1, axis=2, **kwargs)


  return net
