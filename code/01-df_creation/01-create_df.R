library('jaffelab')
library('here')

out_file = here('processed-data', '01-df_creation', 'test_matrix.rda')

in_files = list.files(
    here('raw-data'),
    pattern = 'score\\..*\\..*\\.sscore',
    full.names = TRUE
)

#  Vector of gene names included in each filename
gene_names = paste0(
    ss(basename(in_files), '\\.', 2),
    '.',
    ss(basename(in_files), '\\.', 3)
)

#  Get list of 'SCORE1_AVG's, where each element is a vector of scores along
#  the FIDs for a single gene
cols = lapply(in_files, function(filename) read.delim(filename)[, 'SCORE1_AVG'])

#  Here we assume all FID values are identical between input files!
row_names = read.delim(in_files[1])[, 'X.FID']

#  This gives 'FID' as rows, genes as columns, and 'SCORE1_AVG' as values
mat = matrix(
    unlist(cols),
    ncol = length(gene_names),
    dimnames = list(row_names, gene_names)
)

#  You may also prefer having genes as rows and 'FID' as columns
t(mat)

#  Save the matrix
save(mat, file = out_file)
