ARG prev_entry
FROM $prev_entry

## ------------------------------------------------------------------------------------------
## OpenCV

ENV OPENCV_VERSION 4.3.0
LABEL com.nvidia.opencv.version="${OPENCV_VERSION}"

#Required for libjasper-dev
RUN echo "deb http://ports.ubuntu.com/ubuntu-ports/ xenial-security main restricted" | sudo tee -a /etc/apt/sources.list

#INSTALL OPENCV dependencies
RUN apt update && apt purge *libopencv* && apt install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
    libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev \
    python2.7-dev python3.6-dev python-dev python-numpy python3-numpy \
    libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev \
    libv4l-dev v4l-utils qv4l2 v4l2ucp liblapacke-dev \
    curl unzip && \
    rm -rf /var/lib/apt/lists/*

#GET OPENCV sources
WORKDIR /usr/local/src
RUN curl -L https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip -o opencv-${OPENCV_VERSION}.zip && \
    curl -L https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip -o opencv_contrib-${OPENCV_VERSION}.zip && \
    unzip opencv-${OPENCV_VERSION}.zip && \
    unzip opencv_contrib-${OPENCV_VERSION}.zip && \
    rm -rf opencv*.zip

#INSTALL OPENCV
RUN export CUDA_PATH=/usr/local/cuda-10.2 && \
    export CUDA_ARCH_PATH=$CUDA_PATH/targets/aarch64-linux && \
    export CUDA_BIN_PATH=$CUDA_PATH/bin && \
    export CUDA_LIB_PATH=$CUDA_ARCH_PATH/lib && \
    export CUDA_INC_PATH=$CUDA_ARCH_PATH/include && \
    export PATH=$CUDA_BIN_PATH:$PATH && \
    cd opencv-${OPENCV_VERSION}/ && mkdir release && cd release/ && \
    cmake -D OPENCV_GENERATE_PKGCONFIG=ON -D OPENCV_PC_FILE_NAME=opencv.pc -D WITH_CUDA=ON -D WITH_CUDNN=ON -D CUDNN_VERSION='8.0' -D OPENCV_DNN_CUDA=ON -D ENABLE_FAST_MATH=ON -D CUDA_FAST_MATH=ON -D CUDA_ARCH_BIN="5.3" -D CUDA_ARCH_PTX="" -D WITH_CUBLAS=ON -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib-${OPENCV_VERSION}/modules -D WITH_GSTREAMER=ON -D WITH_LIBV4L=ON -D BUILD_opencv_python2=ON -D BUILD_opencv_python3=ON -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. && \
    make -j4 && \
    make install && \
    cp unix-install/opencv.pc /usr/local/lib/pkgconfig && \
    ldconfig
