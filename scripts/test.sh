#!/usr/bin/env bash
set -e

# Default Training Parameters
DATA_ROOTPATH="D:/HACI/MMchallenge/NEUQdata"
TRAIN_MODEL="D:/HACI/MMchallenge/MEIJU2025-baseline-master/MPDD/checkpoints/5s_3labels_mfccs+densenet/best_model_2025-02-07-14.19.38.pth"
AUDIOFEATURE_METHOD="mfccs" # 音频特征类别,可选{wav2vec,opensmile,mfccs}
VIDEOLFEATURE_METHOD="densenet" # 视频特征类别，可选{openface, resnet, densenet}
SPLITWINDOW="5s" # 窗口时长，可选{"1s","5s"}
LABELCOUNT=3 # 标签分类数，可选{2, 3, 5}
TRACK_OPTION="Track2"
FEATURE_MAX_LEN=5 # 设定最大特征长度，不足补零、超出截断
BATCH_SIZE=16
DEVICE="cpu"

for arg in "$@"; do
  case $arg in
    --data_rootpath=*) DATA_ROOTPATH="${arg#*=}" ;;
    --train_model=*) TRAIN_MODEL="${arg#*=}" ;;
    --audiofeature_method=*) AUDIOFEATURE_METHOD="${arg#*=}" ;;
    --videofeature_method=*) VIDEOLFEATURE_METHOD="${arg#*=}" ;;
    --splitwindow_time=*) SPLITWINDOW="${arg#*=}" ;;
    --labelcount=*) LABELCOUNT="${arg#*=}" ;;
    --track_option=*) TRACK_OPTION="${arg#*=}" ;;
    --feature_max_len=*) FEATURE_MAX_LEN="${arg#*=}" ;;
    --batch_size=*) BATCH_SIZE="${arg#*=}" ;;
    --lr=*) LR="${arg#*=}" ;;
    --num_epochs=*) NUM_EPOCHS="${arg#*=}" ;;
    --device=*) DEVICE="${arg#*=}" ;;
    *) echo "Unknown option: $arg"; exit 1 ;;
  esac
done

for i in `seq 1 1 1`; do
    cmd="python test.py \
        --data_rootpath=$DATA_ROOTPATH \
        --train_model=$TRAIN_MODEL \
        --audiofeature_method=$AUDIOFEATURE_METHOD \
        --videofeature_method=$VIDEOLFEATURE_METHOD \
        --splitwindow_time=$SPLITWINDOW \
        --labelcount=$LABELCOUNT \
        --track_option=$TRACK_OPTION \
        --feature_max_len=$FEATURE_MAX_LEN \
        --batch_size=$BATCH_SIZE \
        --device=$DEVICE"

    echo "\n-------------------------------------------------------------------------------------"
    echo "Execute command: $cmd"
    echo "-------------------------------------------------------------------------------------\n"
    echo $cmd | sh
done