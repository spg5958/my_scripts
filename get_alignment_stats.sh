#!/bin/bash
#SBATCH --account=sam77_h
#SBATCH --time=30:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem=40GB
#SBATCH --partition=sla-prio
#SBATCH --job-name=test
#SBATCH --output=slurm-%x-%j.out

for bamFile in "$@"
do
  echo ""
  echo $bamFile
  total_reads=$(samtools view -c ${bamFile})
  mapped_reads=$(samtools view -c -F 4 $bamFile)
  unmapped_reads=$(samtools view -c -f 4 $bamFile)
  uniquely_mapped_reads=$(samtools view -c -q 20 $bamFile)
  
  echo "Total reads = $total_reads  $(bc <<< "scale=4; ${total_reads}*100/${total_reads}")%"
  echo "Mapped reads = $mapped_reads  $(bc <<< "scale=4; ${mapped_reads}*100/${total_reads}")%"
  echo "Unmapped reads = $unmapped_reads  $(bc <<< "scale=4; ${unmapped_reads}*100/${total_reads}")%"
  echo "Uniquely mapped reads = $uniquely_mapped_reads  $(bc <<< "scale=4; ${uniquely_mapped_reads}*100/${total_reads}")%"
done
  
