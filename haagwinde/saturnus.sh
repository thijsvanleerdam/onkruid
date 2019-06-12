apt-get update

apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get -y install docker-ce docker-ce-cli containerd.io

apt-get -y install nvidia-docker2
pkill -SIGHUP dockerd

docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi

docker run --runtime=nvidia -it tensorflow/tensorflow:latest-gpu \
   python -c "import tensorflow as tf; tf.enable_eager_execution(); print(tf.reduce_sum(tf.random_normal([1000, 1000])))"

mkdir -p training

wget https://raw.githubusercontent.com/NelusTheNerd/symmetrical-octo-happiness/master/haagwinde/Dockerfile

docker build -t trainer .

docker run --runtime=nvidia -v ~/training:/tensorflow/models/research/object_detection/training -it trainer /bin/bash

