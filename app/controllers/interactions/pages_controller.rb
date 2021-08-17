module Interactions
  class PagesController < AuthenticatedController
    
    def create
      if params['image'] && !params['image'].nil?
        Page.create!(user_id: current_user['id'], title: params['title'], image: params['image'],description: params['description'])
        return
      end
      Page.create!(user_id: current_user['id'], title: params['title'], description: params['description'])
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
