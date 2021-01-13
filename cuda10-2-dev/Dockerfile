ARG balena_tag

FROM balenalib/jetson-nano-ubuntu:$balena_tag as stage1

## ------------------------------------------------------------------------------------------
## CUDA

ENV DEBIAN_FRONTEND noninteractive
ENV CUDA_VERSION 10.2

ARG CUDA_TOOLKIT="cuda-repo-l4t-10-2-local-10.2.89"
ARG CUDA_TOOLKIT_PKG="${CUDA_TOOLKIT}_1.0-1_arm64.deb"

COPY ./nvidia/$CUDA_TOOLKIT_PKG .

ENV CUDA_HOME=/usr/local/cuda-${CUDA_VERSION}
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${CUDA_HOME}/lib64
ENV PATH=$PATH:${CUDA_HOME}/bin

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    dpkg --force-all -i ${CUDA_TOOLKIT_PKG} && \
    rm ${CUDA_TOOLKIT_PKG} && \
    apt-key add var/cuda-repo-*-local*/*.pub && \
    apt-get update && \
    apt-get install -y --allow-downgrades cuda-toolkit-10-2 libgomp1 libfreeimage-dev libopenmpi-dev openmpi-bin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* || true && \
    rm -rf ${CUDA_HOME}/doc || true && \
    rm -rf ${CUDA_HOME}/samples || true


## ------------------------------------------------------------------------------------------
## CUDNN

ENV CUDNN_VERSION 8.0.0.145
ENV CUDNN_PKG_VERSION=${CUDNN_VERSION}-1
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

COPY ./nvidia/libcudnn8_${CUDNN_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/libcudnn8-dev_${CUDNN_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .

RUN dpkg -i libcudnn8_${CUDNN_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i libcudnn8-dev_${CUDNN_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm libcudnn8_${CUDNN_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm libcudnn8-dev_${CUDNN_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm -rf ${CUDA_HOME}/doc || true && \
    rm -rf ${CUDA_HOME}/samples || true


## ------------------------------------------------------------------------------------------
## FINAL STAGE

COPY ./nvidia/nvidia_drivers.tbz2 .
COPY ./nvidia/config.tbz2 .
COPY ./nvidia/nvgstapps.tbz2 .

RUN \
    apt-get update && apt-get install -y lbzip2 pkg-config git wget && \
    tar xjf nvidia_drivers.tbz2 -C / && \
    tar xjf config.tbz2 -C / --exclude=etc/hosts --exclude=etc/hostname && \
    tar xjf nvgstapps.tbz2 -C / && \
    echo "/usr/lib/aarch64-linux-gnu/tegra" > /etc/ld.so.conf.d/nvidia-tegra.conf && \
    echo "/usr/lib/aarch64-linux-gnu/tegra-egl" > /etc/ld.so.conf.d/nvidia-tegra-egl.conf && \
    echo "${CUDA_HOME}/targets/aarch64-linux/lib" > /etc/ld.so.conf.d/cuda-10-2.conf && \
    ldconfig && \
    rm -rf *.tbz2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* || true
