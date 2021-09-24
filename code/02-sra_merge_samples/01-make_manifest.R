#  Given a metadata file from SRA, and the corresponding FASTQ files already
#  downloaded, produce a 'samples.manifest' file appropriate for SPEAQeasy,
#  that properly signals to merge FASTQ files corresponding to the same sample.

library('here')

#  Fill this directory in: it is the directory containing FASTQ files and also
#  the directory where the 'samples.manifest' file will be written (omitted to
#  protect privacy).
base_dir = ''

metadata = read.csv(here('raw-data', 'SraRunTable.txt'))

r1 = file.path(base_dir, paste0(metadata$Run, '_1.fastq.gz'))
r2 = file.path(base_dir, paste0(metadata$Run, '_2.fastq.gz'))

man = paste(r1, 0, r2, 0, metadata$submitted_subject_id, sep='\t')

writeLines(man, con=file.path(base_dir, 'samples.manifest'))
