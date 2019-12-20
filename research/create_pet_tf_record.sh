export PETS_DATASET_PATH=/clever/input/datasets/vgg-synthtext/pets_dataset1
export MODEL_PATH=/clever/input/datasets/vgg-synthtext/pets_dataset/models/ssd_mobilenet_v1_coco_2018_01_28
export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim
protoc object_detection/protos/*.proto --python_out=.
rm -rf $PETS_DATASET_PATH
mkdir $PETS_DATASET_PATH
python object_detection/dataset_tools/create_pet_tf_record.py \
    --label_map_path=object_detection/data/pet_label_map.pbtxt \
    --data_dir=/clever/input/datasets/vgg-synthtext/pets_dataset \
    --output_dir=$PETS_DATASET_PATH
cp -r $MODEL_PATH/model.ckpt* $PETS_DATASET_PATH/

