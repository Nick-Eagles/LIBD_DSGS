#$ -l h_fsize=100G
#$ -cwd
#$ -o ../../processed-data/03-parallel_fastq_dump/02-fastq_dump_array_$TASK_ID.log
#$ -e ../../processed-data/03-parallel_fastq_dump/02-fastq_dump_array_$TASK_ID.log
#$ -t 1-785
#$ -tc 20

#  This script assumes 'SRR_Acc_List.txt' has already been downloaded for the
#  desired study, and 'prefetch' was run to obtain all samples in SRA's format.
#
#  'wc -l SRR_Acc_List.txt' was used to determine the number of total tasks,
#  passed to the '-t' argument at the top of this script.

module load sratoolkit/2.10.8

fastq-dump --split-files --gzip $(awk "NR==$SGE_TASK_ID" ../../raw-data/SRR_Acc_List.txt)
