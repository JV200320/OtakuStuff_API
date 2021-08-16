class PageReply < ApplicationRecord
  belongs_to :page_post, foreign_key: "comment_id"
  belongs_to :reply, class_name: "PagePost", foreign_key: "reply_id", dependent: :destroy

  validates :reply_id, :comment_id, presence: true
end
