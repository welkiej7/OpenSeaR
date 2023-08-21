get_nft<- function(chain,address,identifier){
    GET(url = paste("https://api.opensea.io/v2/chain/",chain,"/contract/",address,"/nfts/",identifier, sep = ""), 
    add_headers('X-API-KEY'= token)) -> temp.response
    if(temp.response$status_code != 200){
        stop(paste("Bağlantı başarısız.",temp.response$status_code))
    }
    fromJSON(rawToChar(temp.response$content)) -> main.response
    traits <- main.response$nft$traits
    owners <- main.response$nft$owners[1]
    quantity <- main.response$nft$owners[2]
    suspicious <- main.response$nft$is_suspicious
    created_at <- main.response$nft$created_at
    updated_at <- main.response$nft$updated_at
    creator <- main.response$nft$creator
    collection <- main.response$nft$collection
    rarity <-  as.data.frame(unlist(main.response$nft$rarity))
    if(suspicious){
        warning("NFT is listed as suspicious.")
    }
    info <- as.data.frame(matrix(NA_real_, nrow = 1, ncol = 7))
    colnames(info) <- c("Collection","Owners","Suspicious","Created_at","Updated_at","Creator","Quantity")
    info$Collection <- collection
    info$Owners <- owners
    info$Suspicious <- suspicious
    info$Created_at <- created_at
    info$Updated_at <- updated_at
    info$Creator <- creator
    info$Quantity <- quantity
    return(list(traits, rarity, info))
}
