FROM gnuradio

RUN mkdir -p /src
WORKDIR /src

RUN git clone https://github.com/Nuand/bladeRF.git && \
    mkdir bladeRF/build && \
    cd bladeRF/build && \
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
    wget https://www.nuand.com/fpga/hostedx115-latest.rbf && \
    wget https://www.nuand.com/fpga/wlanxA9-latest.rbf && \
    wget https://www.nuand.com/fpga/adsbxA4.rbf && \
    wget https://www.nuand.com/fpga/adsbxA9.rbf && \
    wget https://www.nuand.com/fpga/adsbx40.rbf && \
    wget https://www.nuand.com/fpga/adsbx115.rbf 

