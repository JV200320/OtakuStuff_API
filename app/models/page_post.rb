class PagePost < ApplicationRecord
  belongs_to :page
  belongs_to :user

  has_many_attached :medias

  has_many :page_likes, dependent: :destroy

  has_many :relations, foreign_key: "comment_id", class_name: "PageReply", dependent: :destroy
  has_many :replies, through: :relations, source: :reply, dependent: :destroy
  has_one :inverse_relation, foreign_key: "reply_id", class_name: "PageReply"
  has_one :replied, through: :inverse_relation, source: :page_post

  enum kind: {post: 0, reply: 1}

  validates :content, presence: true, if: ->  {!medias.attached?}

  def reply(user, content)
    page_post = PagePost.create!(kind: "reply", content: content, user_id: user.id, page_id: page_id)
    PageReply.create!(reply_id: page_post.id ,comment_id: id)
  end
end
