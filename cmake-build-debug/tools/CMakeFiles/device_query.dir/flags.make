# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.13

# compile CXX with /usr/bin/c++
CXX_FLAGS =  -fPIC -Wall -Wno-sign-compare -Wno-uninitialized -g  

CXX_DEFINES = -DCAFFE_VERSION=1.0.0-rc4 -DGTEST_USE_OWN_TR1_TUPLE -DUSE_CUDNN -DUSE_LEVELDB -DUSE_LMDB -DUSE_OPENCV -DWITH_PYTHON_LAYER

CXX_INCLUDES = -I/home/rui/repos/warpctc-caffe/src -I/home/rui/repos/warpctc-caffe/cmake-build-debug/include -I/home/rui/repos/warpctc-caffe/include -I/home/rui/repos/warpctc-caffe/cmake-build-debug -isystem /usr/include/hdf5/serial -isystem /usr/local/cuda/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/build -isystem /home/rui/libs/opencv-3.4/opencv-3.4/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/include/opencv -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudev/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/core/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudaarithm/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/flann/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/hdf/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/imgproc/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/ml/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/phase_unwrapping/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/plot/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/reg/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/surface_matching/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/video/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudabgsegm/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudafilters/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudaimgproc/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudawarping/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/dnn/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/freetype/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/fuzzy/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/hfs/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/img_hash/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/imgcodecs/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/photo/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/shape/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/videoio/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/xphoto/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/highgui/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/ts/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/bioinspired/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/dnn_objdetect/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/features2d/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/line_descriptor/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/saliency/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/text/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/calib3d/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/ccalib/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudafeatures2d/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudastereo/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/datasets/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/objdetect/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/rgbd/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/stereo/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/structured_light/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/tracking/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/xfeatures2d/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/ximgproc/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/xobjdetect/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/aruco/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/bgsegm/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudalegacy/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudaobjdetect/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/cudaoptflow/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/dpm/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/face/include -isystem /home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/optflow/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/stitching/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/superres/include -isystem /home/rui/libs/opencv-3.4/opencv-3.4/modules/videostab/include -isystem /usr/include/x86_64-linux-gnu -isystem /usr/include/python2.7 -isystem /home/rui/.local/lib/python2.7/site-packages/numpy/core/include 

