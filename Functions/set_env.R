set_env <- function(token_s = "Default"){
    message("Paketler Yükleniyor")
    require(httr)
    require(jsonlite)
        if(token_s == "Default"){
        message("Kayıtlı Token Kullanılıyor")
        assign("token", "f6367236978849e29886bf7fa4f5bf92", envir = .GlobalEnv)
        } else {
            if(is.character(token_s)){
            message("Sunulan Token Kullanılıyor")
            assign("token", value = token_s)
            } else {
            stop("Sunulan token string olmak zorunda.")
            }
        }
    message("Bağlantı Test Ediliyor...")
    Sys.sleep(0.3)
    GET(url = "https://api.opensea.io/v2/collection/slug/nfts", 
    add_headers('X-API-KEY'= token)) -> resp
    resp$status_code -> scode
    if(scode == 200){
        message("Bağlantı Başarılı!")
    } else {
        message("Bağlantı Başarısız")
    }
}



