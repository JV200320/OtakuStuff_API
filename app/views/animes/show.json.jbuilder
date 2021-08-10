json.anime do
  json.merge! @anime.except("request_hash", "request_cache_expiry", "request_cached")
end