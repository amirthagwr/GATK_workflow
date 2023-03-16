#!/bin/bash
#SBATCH --job-name=GATK
#SBATCH --partition=standard
#SBATCH -c 1
#SBATCH --mem 32g
#SBATCH -t 4:30:00
#SBATCH -o GATK_output.o%j
#SBATCH -e GATK_error.e%j


module load java
module load nixpkgs/16.09
module load gatk/4.1.2.0

refpath=home/hpcxxxx/reference_files/hg19/chr22
cd $PWD

mkdir variant_Calls

for file in $(ls RemoveDups/); do
filename=${file:0:7}
java -Xmx2g -jar $EBROOTGATK/gatk-package-4.1.2.0-local.jar HaplotypeCaller \
-R  ${refpath}/human.g1k.v37.chr22.fa \
-I RemoveDups/${filename}.sort.rmdup.bam \
-O variant_Calls/${filename}.sort.rmdup.bam.vcf 
done
