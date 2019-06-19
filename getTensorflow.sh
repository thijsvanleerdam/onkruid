
apt-get update && yes | apt-get upgrade
mkdir -p /tensorflow/models
apt-get install -y git wget build-essential
pip install --upgrade pip
pip install tensorflow

apt-get install -y protobuf-compiler python-pil python-lxml python-tk && \
    pip install Cython && \
    pip install contextlib2 && \
    pip install jupyter && \
    pip install matplotlib

git clone https://github.com/tensorflow/models.git /tensorflow/models

pip install git+https://github.com/philferriere/cocoapi.git#subdirectory=PythonAPI

cd /tensorflow/models/research && \
curl -L -o protobuf.zip https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip \
    && unzip protobuf.zip \
    && ./bin/protoc object_detection/protos/*.proto --python_out=. \
    && echo "export PYTHONPATH=$PYTHONPATH:/tensorflow/models/research/:/tensorflow/models/research/slim" | tee -a ~/.bashrc \
    && python setup.py install
