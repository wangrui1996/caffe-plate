cd /home/rui/repos/warpctc-caffe
./build/tools/caffe train \
--solver="models/vehicle/plate/solver.prototxt" \
--gpu 0 2>&1 | tee jobs/vehicle/plate/vehicle_plate.log
