class PageLike < ApplicationRecord
  belongs_to :page_post
  belongs_to :user
end
