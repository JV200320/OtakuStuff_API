module Interactions
  class PagesController < AuthenticatedController

    def create
      page = Page.new
      page['title'] = params['title'] if params.key?(:title) && !params['title'].nil?
      page['description'] = params['description'] if params.key?(:description) && !params['description'].nil?
      page['user_id'] = current_user['id']
      page['owner_nickname'] = current_user['nickname']
      page.save!
    end

    def update
      page = Page.find(params['page_id'])
      if current_user['id'] == page['user_id']
        page.update_attribute(:title, params['title']) unless params['title'].nil? || params['title'] == ''
        page.update_attribute(:description, params['description']) unless params['description'].nil? || params['description'] == ''
        page.update_attribute(:image, params['image']) unless params['image'].nil? || params['image'] == ''
      end
    end

    def destroy
      begin
        page = Page.find(params['page_id'])
      rescue => exception
        render json: {error: "No page with given id."}
        return
      end
      page.destroy if current_user['id'] == page['user_id']
    end

  end
end
