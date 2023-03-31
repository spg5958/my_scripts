#!/bin/bash
#SBATCH --account=sam77_h
#SBATCH --time=30:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --mem=40GB
#SBATCH --partition=sla-prio
#SBATCH --job-name=download_fastq_files
#SBATCH --output=slurm-%x-%j.out
umask 007


procs=8

for listFile in "$@"
do
echo $listFile
[ ! -f $listFile ] && { echo "$listFile not found"; exit 99; }
  while IFS=$'\t' read -r -a col1 col2
  do
    IFS='_' read -r -a array <<< $col1
    destination="${array[0]}"
    IFS='.' read -r -a array2 <<< "${array[-1]}"
    SRR="${array2[0]}"
    echo "$col1 = $destination $SRR"
    ~/group/software/sratoolkit.2.10.9-centos_linux64/bin/fasterq-dump-orig.2.10.9 -p -e $procs $SRR -O $destination -o "${col1}"
  done < <(tail -n +2 $listFile)
done
