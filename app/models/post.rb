class Post < ApplicationRecord
  belongs_to :user

  has_many_attached :medias

  has_many :likes, dependent: :destroy

  validates :anime_id, presence: true

  validates :content, presence: true, if: ->  {!medias.attached?}


end
