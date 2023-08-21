get_nft_collection <- function(collection_name){
    base <- "https://api.opensea.io/v2/collection/"
    if(is.character(collection_name) == FALSE){
    stop("Collection name string olmak zorunda.")
    } 
    temp.response <- GET(paste(base,collection_name,"/nfts", sep = ""), 
    add_headers('X-API-KEY' = token))
    if(temp.response$status_code != 200){
    stop(paste("Bağlantı başarısız.",temp.response$status_code))
    }
    temp.content <- fromJSON(rawToChar(temp.response$content))
    temp.content <- as.data.frame(temp.content)
    
    return(temp.content)
}

