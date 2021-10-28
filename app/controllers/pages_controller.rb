class PagesController < ApplicationController

  def index
    @pages = Page.all
  end

  def search
    search = params['q']
    return if search.nil?
    @results = []
    Page.all.each do |page|
      @results.push(page) if page['title'].downcase.include?(search.downcase) || page['description'].downcase.include?(search.downcase)
    end
    render 'pages/search'
  end

  def followers
    page = Page.find(params['id'])
    @followers = page.followers
  end

end
