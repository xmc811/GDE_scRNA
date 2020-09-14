

get_char_vars <- function(scrna) {
    
    v <- colnames(scrna@meta.data)
    
    v <- v[map_lgl(scrna@meta.data, is.factor) | 
               map_lgl(scrna@meta.data, is.character)]
    
    v %<>%
        `[`(!str_detect(.,"integrated_snn_res"))
    
    return(v)
}


get_num_vars <- function(scrna) {
    
    v <- colnames(scrna@meta.data)
    v <- v[map_lgl(scrna@meta.data, is.numeric)]
    
    return(v)
}


parse_genes <- function(gene_list) {
    
    gene_list <- gsub("[[:space:]]", "", gene_list)
    
    genes <- str_split(gene_list, "(,|;)")[[1]]
    
    return(genes[genes != ""])
}




