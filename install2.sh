echo "compiling protoc"
cd object_detection && protoc object_detection/protos/*.proto --python_out=.

echo "python stuff"
export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

echo "testing the object detection library"
python object_detection/builders/model_builder_test.py
