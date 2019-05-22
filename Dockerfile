FROM tensorflow/tensorflow:latest-gpu

RUN apt-get update && yes | apt-get upgrade
RUN mkdir -p /tensorflow/models
RUN apt-get install -y git python-pip wget
RUN pip install --upgrade pip
RUN pip install tensorflow
RUN pip install tensorflow-gpu
RUN apt-get install -y protobuf-compiler python-pil python-lxml
RUN pip install jupyter
RUN pip install matplotlib
RUN git clone https://github.com/tensorflow/models.git /tensorflow/models

WORKDIR /tensorflow/models/research

RUN curl -L -o protobuf.zip https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip \
    && unzip protobuf.zip \
    && ./bin/protoc object_detection/protos/*.proto --python_out=.

# Install pycocoapi
RUN git clone --depth 1 https://github.com/cocodataset/cocoapi.git && \
    cd cocoapi/PythonAPI && \
    make -j8 && \
    cp -r pycocotools /tensorflow/models/research && \
    cd ../../ && \
    rm -rf cocoapi

RUN echo "export PYTHONPATH=$PYTHONPATH:/tensorflow/models/research/:/tensorflow/models/research/slim" | tee -a ~/.bashrc

RUN python setup.py install

WORKDIR /tensorflow/models/research/object_detection

RUN wget http://projectsaturnus.area36.nl/trainingdata.tar.xz \
     && tar -xf trainingdata.tar.xz

RUN mv -v legacy/train.py .

#CMD ["jupyter", "notebook"]