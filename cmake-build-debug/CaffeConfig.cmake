# Config file for the Caffe package.
#
# Note:
#   Caffe and this config file depends on opencv,
#   so put `find_package(OpenCV)` before searching Caffe
#   via `find_package(Caffe)`. All other lib/includes
#   dependencies are hard coded in the file
#
# After successful configuration the following variables
# will be defined:
#
#   Caffe_INCLUDE_DIRS - Caffe include directories
#   Caffe_LIBRARIES    - libraries to link against
#   Caffe_DEFINITIONS  - a list of definitions to pass to compiler
#
#   Caffe_HAVE_CUDA    - signals about CUDA support
#   Caffe_HAVE_CUDNN   - signals about cuDNN support


# OpenCV dependency (optional)

if(ON)
  if(NOT OpenCV_FOUND)
    set(Caffe_OpenCV_CONFIG_PATH "/home/rui/libs/opencv-3.4/opencv-3.4/build")
    if(Caffe_OpenCV_CONFIG_PATH)
      get_filename_component(Caffe_OpenCV_CONFIG_PATH ${Caffe_OpenCV_CONFIG_PATH} ABSOLUTE)

      if(EXISTS ${Caffe_OpenCV_CONFIG_PATH} AND NOT TARGET opencv_core)
        message(STATUS "Caffe: using OpenCV config from ${Caffe_OpenCV_CONFIG_PATH}")
        include(${Caffe_OpenCV_CONFIG_PATH}/OpenCVModules.cmake)
      endif()

    else()
      find_package(OpenCV REQUIRED)
    endif()
    unset(Caffe_OpenCV_CONFIG_PATH)
  endif()
endif()

# Compute paths
get_filename_component(Caffe_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
set(Caffe_INCLUDE_DIRS "/home/rui/repos/warpctc-caffe/src;/usr/include;/home/rui/repos/warpctc-caffe/cmake-build-debug/include;/usr/include/hdf5/serial;/usr/local/cuda/include;/home/rui/libs/opencv-3.4/opencv-3.4/build;/home/rui/libs/opencv-3.4/opencv-3.4/include;/home/rui/libs/opencv-3.4/opencv-3.4/include/opencv;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudev/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/core/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudaarithm/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/flann/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/hdf/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/imgproc/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/ml/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/phase_unwrapping/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/plot/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/reg/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/surface_matching/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/video/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudabgsegm/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudafilters/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudaimgproc/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudawarping/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/dnn/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/freetype/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/fuzzy/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/hfs/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/img_hash/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/imgcodecs/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/photo/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/shape/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/videoio/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/xphoto/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/highgui/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/ts/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/bioinspired/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/dnn_objdetect/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/features2d/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/line_descriptor/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/saliency/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/text/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/calib3d/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/ccalib/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudafeatures2d/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudastereo/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/datasets/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/objdetect/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/rgbd/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/stereo/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/structured_light/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/tracking/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/xfeatures2d/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/ximgproc/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/xobjdetect/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/aruco/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/bgsegm/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudalegacy/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudaobjdetect/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/cudaoptflow/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/dpm/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/face/include;/home/rui/libs/opencv-3.4/opencv_contrib-3.4/modules/optflow/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/stitching/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/superres/include;/home/rui/libs/opencv-3.4/opencv-3.4/modules/videostab/include;/usr/include/x86_64-linux-gnu;/home/rui/repos/warpctc-caffe/include;/home/rui/repos/warpctc-caffe/build/include")



# Our library dependencies
if(NOT TARGET caffe AND NOT caffe_BINARY_DIR)
  include("${Caffe_CMAKE_DIR}/CaffeTargets.cmake")
endif()

# List of IMPORTED libs created by CaffeTargets.cmake
set(Caffe_LIBRARIES caffe)

# Definitions
set(Caffe_DEFINITIONS "-DUSE_OPENCV;-DUSE_LMDB;-DUSE_LEVELDB")

# Cuda support variables
set(Caffe_CPU_ONLY OFF)
set(Caffe_HAVE_CUDA TRUE)
set(Caffe_HAVE_CUDNN TRUE)
