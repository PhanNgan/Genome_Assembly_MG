#!/bin/sh

# By Julie Orjuela

#$ -j y
#$ -pe ompi 8
#$ -M julie.orjuela@ird.fr
#$ -m ea
#$ -q bioinfo2.q@node23
#$ -cwd
#$ -N maker_graminicola
#$ -o /home/orjuela/TEST-maker/MAKER_$JOB_ID.log
#$ -e /home/orjuela/TEST-maker/MAKER_$JOB_ID.err

temp_folder="/scratch/orjuela-maker/$JOB_ID-maker" 
in_folder="/scratch/orjuela-maker/" 

mkdir $temp_folder
cd $temp_folder

#echo "copie files needs to maker dans temp_folder" 
#scp -r $in_folder $temp_folder
cd $in_folder

echo "loading modules" 
module load system/perl/5.24.0
module load bioinfo/maker/2.31.9
module load bioinfo/tRNAscan-SE/1.3.1
module load bioinfo/snap/2013-11-29

echo "runnign maker" 
echo "maker -fix_nucleotides maker_opts.ctl maker_bopts.ctl maker_exe.ctl" 
maker -fix_nucleotides maker_opts.ctl maker_bopts.ctl maker_exe.ctl

#echo "transfering results" 
#rsync -av -e ssh $temp_folder/MAKER/*maker.output/ $in_folder
#if [[ $? -ne 0 ]]; then
#    echo "transfer failed on $HOSTNAME in $temp_folder" 
#else
#    echo "Suppression des donnees sur le noeud";
#    rm -rf $temp_folder;
#fi

echo "fin" 