class AnimeReply < ApplicationRecord
  belongs_to :anime_post, foreign_key: "comment_id"
  belongs_to :reply, class_name: "AnimePost", foreign_key: "reply_id", dependent: :destroy

  validates :reply_id, :comment_id, presence: true
end
