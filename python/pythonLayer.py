import caffe

import numpy as np
from PIL import Image
import scipy.io
import cv2
import random
from multiprocessing import Pool

class DataLayer(caffe.Layer):
    """
    Load (input image, label image) pairs from SIFT Flow
    one-at-a-time while reshaping the net to preserve dimensions.

    This data layer has three tops:

    1. the data, pre-processed
    2. the semantic labels 0-32 and void 255
    3. the geometric labels 0-2 and void 255

    Use this to feed data to a fully convolutional network.
    """

    def setup(self, bottom, top):
        """
        Setup data layer according to parameters:

        - siftflow_dir: path to SIFT Flow dir
        - split: train / val / test
        - randomize: load in random order (default: True)
        - seed: seed for randomization (default: None / current time)

        for semantic segmentation of object and geometric classes.

        example: params = dict(siftflow_dir="/path/to/siftflow", split="val")
        """
        # config
        params = eval(self.param_str)
        self.label_txt = params['label_txt']
        self.batch_size = params['batch_size']
        self.height = int(params['height'])
        self.width = int(params['width'])
        self.mean = np.array((114.578, 115.294, 108.353), dtype=np.float32)
        self.random = params.get('randomize', True)
        self.seed = params.get('seed', None)
        # expand ratio
        self.expand_ratio = float(params['expand_ratio'])
        self.cuting_ratio = float(params['cutting_ratio'])
        self.prob = float(params['prob'])
        self.train = params['train']
        # three tops: data, semantic, geometric
        if len(top) != 2:
            raise Exception("Need to define three tops: data, semantic label, and geometric label.")
        # data layers have no bottoms
        if len(bottom) != 0:
            raise Exception("Do not define a bottom.")

        # load indices for images and labels
        self.indices = open(self.label_txt, 'r').read().splitlines()
        random.shuffle(self.indices)
        self.idx = 0

        # make eval deterministic
#        if 'train' not in self.split:
#            self.random = False

        # randomization: seed and pick
#        if self.random:
#            random.seed(self.seed)
#            self.idx_list = random.randint(0, len(self.indices)-1)

    def reshape(self, bottom, top):
        # load image + label image pair
#        self.data = self.load_image(self.indices[self.idx])
#        self.label = self.load_label(self.indices[self.idx])
        # reshape tops to fit (leading 1 is for batch dimension)
        top[0].reshape(self.batch_size, 3, self.height, self.width)
        top[1].reshape(self.batch_size, 1)

    def in_idx(self):
        if self.idx >= len(self.indices):
            if self.random:
                random.seed(self.seed)
                self.idx_list = [i for i in range(len(self.indices))]
                random.shuffle(self.idx_list)
            self.idx = 0
            return self.idx
        self.idx = self.idx + 1
        return self.idx - 1
    def getindices(self):
        return self.indices[self.in_idx()]



    def forward(self, bottom, top):
        # assign output
        for i in range(self.batch_size):
            label_line = self.getindices()
            img_path = label_line.split(" ")[0]
            label = label_line.split(" ")[-1]
            top[0].data[i, :, :, :] = self.load_image(img_path)
            top[1].data[i, 0] = label


    def backward(self, top, propagate_down, bottom):
        pass

    def load_image(self, idx):
        """
        Load input image and preprocess for Caffe:
        - cast to float
        - switch channels RGB -> BGR
        - subtract mean
        - transpose to channel x height x width order
        """
        img = cv2.imread(idx)
        if random.random() > self.prob and self.train:
            img_h, img_w, _ = img.shape
            if random.random() > self.prob * 0.5:
                img_expand_h, img_expand_w = int(img_h * (1 + random.random()*(self.expand_ratio - 1))), int(img_w * (1+random.random()* (self.expand_ratio-1)))
                img_new = np.zeros([img_expand_h, img_expand_w, 3], np.uint8)
#                print img_h, img_w
#                print img_expand_h, img_expand_w
                start_x = random.randint(0, img_expand_w - img_w)
                start_y = random.randint(0, img_expand_h - img_h)
                img_new[start_y: (start_y+img_h), start_x:(start_x + img_w),: ] = img
                img = img_new
                img_h = img_expand_h
                img_w = img_expand_w
            if random.random() > self.prob * 0.5:
                img_cuting_h = int(img_h*(1-random.random()*self.cuting_ratio ))
                img_cuting_w = int(img_w*(1-random.random()*self.cuting_ratio))
                start_x = random.randint(0, img_w - img_cuting_w)
                start_y = random.randint(0, img_h - img_cuting_h)
                img = img[start_y:(start_y + img_cuting_h), start_x:(start_x + img_cuting_w), :]
            alpha = 1.0 + (random.random() - 0.5)
            beta = int((random.random() - 0.5) * 70)
            img = cv2.addWeighted(img, alpha, img, 0, beta)
#            img -= self.mean
        img = cv2.imread(idx)
        img = cv2.resize(img, (self.width, self.height))
#        cv2.imshow("demo", img)
#        cv2.waitKey(0)
        in_ = img.transpose((2,0,1)).copy()
        return in_


class WarpctcDataLayer(caffe.Layer):
    """
    Load (input image, label image) pairs from SIFT Flow
    one-at-a-time while reshaping the net to preserve dimensions.

    This data layer has three tops:

    1. the data, pre-processed
    2. the semantic labels 0-32 and void 255
    3. the geometric labels 0-2 and void 255

    Use this to feed data to a fully convolutional network.
    """

    def setup(self, bottom, top):
        """
        Setup data layer according to parameters:

        - siftflow_dir: path to SIFT Flow dir
        - split: train / val / test
        - randomize: load in random order (default: True)
        - seed: seed for randomization (default: None / current time)

        for semantic segmentation of object and geometric classes.

        example: params = dict(siftflow_dir="/path/to/siftflow", split="val")
        """
        # config
        params = eval(self.param_str)
        self.label_txt = params['label_txt']
        self.batch_size = params['batch_size']
        self.height = int(params['height'])
        self.width = int(params['width'])
        self.random = params.get('randomize', True)
        self.seed = params.get('seed', None)
        # expand ratio
        # three tops: data, semantic, geometric
        if len(top) != 2:
            raise Exception("Need to define two tops: data, and geometric label.")
        # data layers have no bottoms
        if len(bottom) != 0:
            raise Exception("Do not define a bottom.")

        # load indices for images and labels
        self.indices = open(self.label_txt, 'r').read().splitlines()
        random.shuffle(self.indices)
        self.idx = 0

        # make eval deterministic
    #        if 'train' not in self.split:
    #            self.random = False

    # randomization: seed and pick
    #        if self.random:
    #            random.seed(self.seed)
    #            self.idx_list = random.randint(0, len(self.indices)-1)

    def reshape(self, bottom, top):
        # load image + label image pair
        #        self.data = self.load_image(self.indices[self.idx])
        #        self.label = self.load_label(self.indices[self.idx])
        # reshape tops to fit (leading 1 is for batch dimension)
        top[0].reshape(self.batch_size, 3, self.height, self.width)
        top[1].reshape(self.batch_size, 5)

    def in_idx(self):
        if self.idx >= len(self.indices):
            if self.random:
                random.seed(self.seed)
                self.idx_list = [i for i in range(len(self.indices))]
                random.shuffle(self.idx_list)
            self.idx = 0
            return self.idx
        self.idx = self.idx + 1
        return self.idx - 1
    def getindices(self):
        return self.indices[self.in_idx()]



    def forward(self, bottom, top):
        for i in range(self.batch_size):
            for j in range(5):
                top[1].data[i,j] = int(10)
        # assign output
        for i in range(self.batch_size):
            label_line = self.getindices()
     #       print i, label_line
            img_path = label_line.split(" ")[0]
            label = label_line.split(" ")[-1]
            top[0].data[i, :, :, :] = self.load_image(img_path)
            for j in range(len(label)):
                top[1].data[i, j] = int(label[j])
   #         cv2.waitKey(0)
  #      exit(1)






    def backward(self, top, propagate_down, bottom):
        pass

    def load_image(self, idx):
        """
        Load input image and preprocess for Caffe:
        - cast to float
        - switch channels RGB -> BGR
        - subtract mean
        - transpose to channel x height x width order
        """
        img = caffe.io.load_image(idx)
        img = caffe.io.resize(img, (self.height, self.width, 3))
        #        cv2.imshow("demo", img)
#      cv2.waitKey(0)
        in_ = np.transpose(img, (2,0,1))
        return in_


