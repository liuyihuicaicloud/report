export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim
export PETS_DATASET_PATH=/clever/input/datasets/vgg-synthtext/pets_dataset2
export MODEL_CONFIG=faster_rcnn_resnet101_pets.config
cp object_detection/data/pet_label_map.pbtxt $PETS_DATASET_PATH
protoc object_detection/protos/*.proto --python_out=.
cp object_detection/samples/configs/$MODEL_CONFIG $PETS_DATASET_PATH
sed -i "s!PATH_TO_BE_CONFIGURED!$PETS_DATASET_PATH!g" $PETS_DATASET_PATH'/'$MODEL_CONFIG
sed -i "s!batch_size: 24!batch_size: 12!g" $PETS_DATASET_PATH'/'$MODEL_CONFIG
sed -i "s!num_steps: 200000!num_steps: 100!g" $PETS_DATASET_PATH'/'$MODEL_CONFIG
#sed -i "s!from_detection_checkpoint: true!from_detection_checkpoint: false!g" $PETS_DATASET_PATH'/'$MODEL_CONFIG
#sed -i "s!load_all_detection_checkpoint_vars: true!load_all_detection_checkpoint_vars: false!g" $PETS_DATASET_PATH'/'$MODEL_CONFIG
python object_detection/legacy/train.py \
	--pipeline_config_path=$PETS_DATASET_PATH'/'$MODEL_CONFIG \
    	--train_dir=$PETS_DATASET_PATH'/ssd_model' \
    	--logtostderr --worker_replicas=1 --num_clones=1
