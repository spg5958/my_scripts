#!/bin/bash
#SBATCH --account=sam77_h
#SBATCH --time=30:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=70GB
#SBATCH --partition=sla-prio
#SBATCH --job-name=MultiGPS
#SBATCH --output=slurm-%x-%j.out
umask 007


java -Xmx70G -jar ~/group/software/MultiGPS/multigps.v0.75.mahonylab.jar --geninfo mm10.info --threads 8 --exclude mm10_blacklist.bed --verbose --design Ascl1_EB+12hr.design --fixedpb 5 --q 0.01 --out "multigps_q_0.01" >multigps.out 2>&1
