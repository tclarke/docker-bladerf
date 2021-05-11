ARG ARCH=
FROM tclarke/gnuradio:${ARCH}

RUN mkdir -p /src
WORKDIR /src

RUN apt-get -y remove libbladerf-dev libbladerf1

RUN git clone https://github.com/Nuand/bladeRF.git && \
    cd bladeRF && \
    git checkout 2021.03 && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr ../ && \
    make -j3 install

RUN git clone https://github.com/osmocom/gr-osmosdr.git && \
    mkdir gr-osmosdr/build && \
    cd gr-osmosdr/build && \
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr ../ && \
    make -j3 install

RUN rm -rf bladeRF gr-osmosdr && mkdir /bladeRF-images && cd /bladeRF-images && \
    wget https://www.nuand.com/fpga/hostedxA4-latest.rbf && \
    wget https://www.nuand.com/fpga/hostedxA9-latest.rbf && \
    wget https://www.nuand.com/fpga/hostedx40-latest.rbf && \
    wget https://www.nuand.com/fpga/hostedx115-latest.rbf
