ARG prev_entry
FROM $prev_entry

## ------------------------------------------------------------------------------------------
## NVINFER

ENV INF_VERSION 7.1.0
ENV INF_PKG_VERSION=${INF_VERSION}-1
LABEL com.nvidia.inf.version="${INF_VERSION}"

COPY ./nvidia/libnvinfer-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/libnvinfer7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/libnvinfer-bin_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/libnvinfer-doc_${INF_VERSION}-1+cuda${CUDA_VERSION}_all.deb .
COPY ./nvidia/libnvinfer-plugin7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/libnvinfer-plugin-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/libnvinfer-samples_${INF_VERSION}-1+cuda${CUDA_VERSION}_all.deb .
COPY ./nvidia/libnvonnxparsers7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/libnvonnxparsers-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/libnvparsers7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/libnvparsers-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .

RUN dpkg -i libnvinfer7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i libnvinfer-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i libnvinfer-plugin7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i libnvinfer-plugin-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i libnvinfer-doc_${INF_VERSION}-1+cuda${CUDA_VERSION}_all.deb && \
    dpkg -i libnvonnxparsers7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i libnvonnxparsers-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i libnvparsers7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i libnvparsers-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i libnvinfer-bin_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i libnvinfer-samples_${INF_VERSION}-1+cuda${CUDA_VERSION}_all.deb && \
    rm libnvinfer-bin_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm libnvinfer-plugin7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm libnvinfer-plugin-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm libnvinfer-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm libnvinfer-doc_${INF_VERSION}-1+cuda${CUDA_VERSION}_all.deb && \
    rm libnvinfer-samples_${INF_VERSION}-1+cuda${CUDA_VERSION}_all.deb && \
    rm libnvonnxparsers7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm libnvonnxparsers-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm libnvparsers7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm libnvparsers-dev_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm libnvinfer7_${INF_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm -rf ${CUDA_HOME}/doc || true && \
    rm -rf ${CUDA_HOME}/samples || true && \
    rm /usr/lib/aarch64-linux-gnu/libnv*.a || true

## ------------------------------------------------------------------------------------------
## TENSORRT

ENV TRT_VERSION 7.1.0
ENV TRT_VERSION_EXT 7.1.0.16
ENV TRT_PKG_VERSION=${INF_VERSION}-1
LABEL com.nvidia.inf.version="${INF_VERSION}"

COPY ./nvidia/graphsurgeon-tf_${TRT_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/tensorrt_${TRT_VERSION_EXT}-1+cuda${CUDA_VERSION}_arm64.deb .
COPY ./nvidia/uff-converter-tf_${TRT_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb .

RUN dpkg -i graphsurgeon-tf_${TRT_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i tensorrt_${TRT_VERSION_EXT}-1+cuda${CUDA_VERSION}_arm64.deb && \
    dpkg -i uff-converter-tf_${TRT_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm graphsurgeon-tf_${TRT_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm tensorrt_${TRT_VERSION_EXT}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm uff-converter-tf_${TRT_VERSION}-1+cuda${CUDA_VERSION}_arm64.deb && \
    rm -rf ${CUDA_HOME}/doc || true && \
    rm -rf ${CUDA_HOME}/samples || true


## ------------------------------------------------------------------------------------------
## DEEPSTREAM

ENV DS_VERSION 5.0_5.0.0
LABEL com.nvidia.ds.version="${DS_VERSION}"

COPY ./nvidia/deepstream-$DS_VERSION-1_arm64.deb .

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    jq \
    vim \
    libssl1.0.0 \
    libgstreamer1.0-0 \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    libgstrtspserver-1.0-0 \
    libgstrtspserver-1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libjansson4 \
    libjson-glib-1.0-0 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN dpkg -i deepstream-$DS_VERSION-1_arm64.deb && \
    rm deepstream-$DS_VERSION-1_arm64.deb && \
    rm -rf ${CUDA_HOME}/doc || true && \
    rm -rf ${CUDA_HOME}/samples || true && \
    rm  ${CUDA_HOME}/targets/aarch64-linux/lib/*.a || true && \
    rm /usr/lib/aarch64-linux-gnu/libcu*.a || true && \
    rm /usr/lib/aarch64-linux-gnu/libnv*.a || true && \
    rm -rf /opt/nvidia/deepstream/deepstream-5.0/samples || true && \
    rm -rf /var/local/opendatacam/nvidia || true && \
    rm /etc/alternatives/*_stlib || true

COPY ./nvidia/libvisionworks-repo_1.6.0.501_arm64.deb .

RUN dpkg -i libvisionworks-repo_1.6.0.501_arm64.deb && \
    apt-get update && \
    apt-get install -y --no-install-recommends libvisionworks libvisionworks-dev && \
    rm libvisionworks-repo_1.6.0.501_arm64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
