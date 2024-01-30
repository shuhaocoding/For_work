if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("GEOquery")

setwd("~/Desktop")
library(GEOquery)
Sys.setenv( "VROOM_CONNECTION_SIZE" = 500072 )

unique_identifiers <- as.numeric(readLines("gds_result_ID_M.txt"))
# Replace with the actual path to your text file
last_six_digits <- substr(unique_identifiers, 4, 9) # Extract last six digits
accession_numbers <- paste0("GSE", last_six_digits)
writeLines(accession_numbers, "gds_result_accessions_M.txt")


# GEOquery
for (accession in accession_numbers) {
  gset <- getGEO(accession)
  exprs_data <- exprs(gset[[1]]) # Extract the expression matrix
  write.csv(exprs_data, file = paste0("gds_brain_expression/", accession, "_expression.csv"))
}

