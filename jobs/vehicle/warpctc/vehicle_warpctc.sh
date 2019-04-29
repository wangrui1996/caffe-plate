cd /home/rui/repos/warpctc-caffe
./build/tools/caffe train \
--solver="models/vehicle/warpctc/solver.prototxt" \
--gpu 0 2>&1 | tee jobs/vehicle/warpctc/vehicle_warpctc.log
