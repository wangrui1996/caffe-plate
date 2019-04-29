cd /home/rui/repos/warpctc-caffe
./build/tools/caffe train \
--solver="models/oilupload/people_attribe/solver.prototxt" \
--weights="models/oilupload/people_attribe/oilupload_people_attribe_iter_31511.caffemodel" \
--gpu 0 2>&1 | tee jobs/oilupload/people_attribe/oilupload_people_attribe.log
