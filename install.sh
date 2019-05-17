#!/usr/bin/env bash

echo "starting install script"
echo "========================="
echo "installing drivers"
add-apt-repository ppa:graphics-drivers/ppa 
apt update
apt-get -y install nvidia-375

echo "installing cuda"
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.0.130-1_amd64.deb
apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
apt-get update
apt-get -y install cuda

echo "exporting path"
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64\${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

echo "installing cudnn"
wget http://projectsaturnus.area36.nl/cudnn-10.0-linux-x64-v7.5.1.10.tgz
tar -xzvf cudnn-10.0-linux-x64-v7.5.1.10.tgz
cp cuda/include/cudnn.h /usr/local/cuda/include
cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

echo "installing tensorflow"
apt-get -y install libcupti-dev
yes | pip install tensorflow-gpu

echo "getting the testscript and running it"
wget https://raw.githubusercontent.com/NelusTheNerd/symmetrical-octo-happiness/master/tensorflowtest.py
python tensorflowtest.py
