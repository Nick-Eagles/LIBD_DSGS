#$ -l h_fsize=100G
#$ -cwd
#$ -o ../../processed-data/03-parallel_fastq_dump/01-small_test_$TASK_ID.log
#$ -e ../../processed-data/03-parallel_fastq_dump/01-small_test_$TASK_ID.log
#$ -t 1-3
#$ -tc 3

#  This script assumes 'SRR_Acc_List.txt' has already been downloaded for the
#  desired study, and 'prefetch' was run to obtain all samples in SRA's format.
#
#  'wc -l SRR_Acc_List.txt' was used to determine the number of total tasks,
#  passed to the '-t' argument at the top of this script.

module load sratoolkit/2.10.8

#  Simply make sure we can retrieve the sample ID properly for each task in the
#  test array
echo $(awk "NR==$SGE_TASK_ID" ../../raw-data/SRR_Acc_List.txt)
