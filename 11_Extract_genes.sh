#!/bin/bash
#SBATCH --job-name=Extract_genes
#SBATCH --partition=standard
#SBATCH -c 2
#SBATCH --mem 6g
#SBATCH -t 1:30:00
#SBATCH -o extract_genes_output.o%j
#SBATCH -e extract_genes_error.e%j


module load java

java -jar $EBROOTSNPEFF/SnpSift.jar \
extractFields -e "." functionalVariants.vcf "ANN[0].GENE" ID > genes.SetID

sort genes.SetID | uniq > uniqueGenes.SetID
