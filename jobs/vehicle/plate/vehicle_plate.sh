cd /home/rui/repos/warpctc-caffe
./build/tools/caffe train \
--solver="models/vehicle/plate/solver.prototxt" \
--weights="models/vehicle/plate/vehicle_plate_iter_5060.caffemodel" \
--gpu 0 2>&1 | tee jobs/vehicle/plate/vehicle_plate.log
