#library
install.packages('openai')
base_url="https://api.xty.app/v1"
api_key="sk-FLyhhGWDsCZCTbmq640c5c61Ad3d45078eDe56CdDbF01c0a"
Sys.setenv(OPENAI_API_KEY = api_key)
library(GPTCelltype)
library(openai)
# library(assertthat)
# library(glue)
# library(httr)
# library(jsonlite)
# library(lifecycle)
# library(magrittr)
# library(dplyr)


# source("./R/openai.R")
# create_chat_completion <- my_create_chat_completion
source("./R/openai.R")

response <- my_create_chat_completion(
  model = "gpt-3.5-turbo",
  messages = list(list("role"="user","content"="你是谁"))
)

library(Seurat)
# Load the PBMC dataset
pbmc.data <- Read10X(data.dir = "/brahms/mollag/practice/filtered_gene_bc_matrices/hg19/")
# Initialize the Seurat object with the raw (non-normalized data).
pbmc <- CreateSeuratObject(counts = pbmc.data, project = "pbmc3k", min.cells = 3, min.features = 200)
pbmc
data("pbmc_small")
all.markers <- FindAllMarkers(object = pbmc_small)

print(Sys.getenv('OPENAI_API_KEY'))
prompt <- gptcelltype(all.markers, tissuename='human PBMC')
return(prompt)