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
    uri = search.length > 1 ? URI(@@base_url + url + search) : URI(@@base_url + url)
    JSON.parse(Net::HTTP.get(uri))
  end

  private

  def set_search(values)
    items = 1
    search = '?'
    values = JSON.parse(values)
    values.each do |k, v|
      if items == 1
        search += "#{k}=#{v}"
        items += 1
      else
        search += "&#{k}=#{v}"
      end
    end
    search
  end
end
