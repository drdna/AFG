#!/bin/bash

#SBATCH --time 48:00:00
#SBATCH --job-name=velvetFasta
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --partition=normal
#SBATCH --mem=500GB
#SBATCH --mail-type ALL
#SBATCH -A coa_farman_uksr
#SBATCH --mail-type ALL
#SBATCH --mail-user farman@uky.edu

echo "SLURM_NODELIST: "$SLURM_NODELIST

dir=$1

f=$2

mkdir $f 

cp $dir/$f*_1*f*a* $f/input_1.fasta

cp $dir/$f*_2*f*a* $f/input_2.fasta

cd $f

singularity run --app perlvelvetoptimiser226 /share/singularity/images/ccs/conda/amd-conda2-centos8.sinf VelvetOptimiser.pl \
 -s 89 -e 129 -x 2 -d velvet_assembly -f ' -shortPaired -fasta -separate input_1.fasta input_2.fasta '

mv velvet_assembly/contigs.fa velvet_assembly/${f}".fasta"
cp velvet_assembly/${f}".fasta" /scratch/farman/ASSEMBLIES/${f}".fasta"

prefix=`ls velvet_assembly/*logfile.txt'

mv $prefix /scratch/farman/ASSEMBLIES/${f}_${prefix/*\//}
