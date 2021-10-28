module Animes
  class AnimesController < ApplicationController
    include Anime
  
    def index
      page = nil
      page = params['page'] unless params['page'].nil?
      url = page.nil? ? "/top/anime" : "/top/anime/#{page}"
      @animes = get_anime(url)['top']
      render "animes/index"
    end
    
    def show
      @anime = get_anime("/anime/#{params['anime_id']}")
      render "animes/show"
    end
    
    def search
      search = nil
      if params['search']
        search = params['search']
        if params['page']
          search['page'] = params['page']
        end
      end
      @animes = get_anime("/search/anime", search)['results']
      render "animes/index"
    end
  end
end
  