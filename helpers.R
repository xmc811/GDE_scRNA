

get_char_vars <- function(scrna) {
    
    v <- colnames(scrna@meta.data)
    
    v <- v[map_lgl(scrna@meta.data, is.factor) | 
               map_lgl(scrna@meta.data, is.character)]
    
    v %<>%
        `[`(!str_detect(.,"integrated_snn_res"))
    
    return(v)
}
