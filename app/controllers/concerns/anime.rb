module Anime

  extend ActiveSupport::Concern

  included do
    require 'net/http'
    require 'uri'
    require 'json'
  end

  @@base_url = 'https://api.jikan.moe/v3'

  def get_anime(url, values = nil)
    search = values.nil? ? '' : set_search(values)
    if search.length > 1
      uri = URI(@@base_url+url+search)
      res = JSON.parse(Net::HTTP.get(uri))
      return res
    else
      uri = URI(@@base_url+url)
      res = JSON.parse(Net::HTTP.get(uri))
      return res
    end
  end

  private

  def set_search(values)
    items = 1
    search = '?'
    values.each do |k,v|
      if items == 1
        search+= "#{k}=#{v}"
        items+=1
      else
        search+= "&#{k}=#{v}"
        items+=1
      end
    end
    search
  end
  

end