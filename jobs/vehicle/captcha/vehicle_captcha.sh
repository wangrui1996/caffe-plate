cd /home/rui/repos/warpctc-caffe
./build/tools/caffe train \
--solver="models/vehicle/captcha/solver.prototxt" \
--weights="models/vehicle/captcha/vehicle_captcha_iter_150127.caffemodel" \
--gpu 0 2>&1 | tee jobs/vehicle/captcha/vehicle_captcha.log
