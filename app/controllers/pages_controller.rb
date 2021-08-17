class PagesController < ApplicationController

  def index
    @pages = Page.all
  end

  def search
    search = params['search']
    return if search.nil?
    @results = []
    Page.all.each do |page|
      @results.push(page) if page['title'].downcase.include?(search.downcase) || page['description'].downcase.include?(search.downcase)
    end
  end

end
