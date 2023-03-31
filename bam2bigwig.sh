#!/bin/bash

effectiveGenomeSize=2652783500
for bamFile in "$@"
do
    echo "$bamFile"
    IFS='.' read -r -a array <<< "$bamFile"
    bamCoverage --numberOfProcessors 8 --bam $bamFile --outFileName ${array[0]}.bw --outFileFormat 'bigwig' --binSize 1 --effectiveGenomeSize $effectiveGenomeSize
done
