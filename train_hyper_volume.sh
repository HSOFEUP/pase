#!/bin/bash
#SBATCH -J hyper1.1_K80
#SBATCH -o log/hyper_volume_1.1.K80.out
#SBATCH --mem=32GB
#SBATCH -t 5-00:00:00
#SBATCH -n 1
#SBATCH -c 8
#SBATCH -p gpu
#SBATCH --gres=gpu:1 -C K80

python -u  train.py --batch_size 5 --epoch 50 --save_path /export/team-mic/zhong/test/aspp_res2d \
       --num_workers 8 --warmup 10000000 --net_cfg cfg/workers_aspp.cfg \
       --fe_cfg cfg/PASE_aspp_res.cfg --do_eval --data_cfg /export/corpora/LibriSpeech_50h/librispeech_data_50h.cfg \
       --min_lr 0.0005 --fe_lr 0.0005 --data_root /export/corpora/LibriSpeech_50h/wav_sel \
       --dtrans_cfg cfg/distortions/all.cfg \
       --stats data/librispeech_50h_stats.pkl --lrdec_step 30 --lrdecay 0.5 \
       --chunk_size 16000 \
       --random_scale True \
       --backprop_mode hyper_volume --delta 1.1 \
       --lr_mode poly \
       --tensorboard True \
       --att_cfg cfg/attention.cfg --attention_K 40
       --sup_exec ./sup_cmd.txt --sup_freq 1
