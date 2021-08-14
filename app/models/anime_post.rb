class AnimePost < ApplicationRecord
  belongs_to :user

  has_many_attached :medias

  has_many :anime_likes, dependent: :destroy

  has_many :relations, foreign_key: "comment_id", class_name: "AnimeReply", dependent: :destroy
  has_many :replies, through: :relations, source: :reply, dependent: :destroy
  has_one :inverse_relation, foreign_key: "reply_id", class_name: "AnimeReply"
  has_one :replied, through: :inverse_relation, source: :anime_post

  enum kind: {post: 0, reply: 1}

  validates :anime_id, presence: true, if: -> {kind == 0}

  validates :content, presence: true, if: ->  {!medias.attached?}

  def reply(user, content)
    anime_post = AnimePost.create(kind: "reply", content: content, user_id: user.id)
    AnimeReply.create(reply_id: anime_post.id ,comment_id: id)
  end

end
