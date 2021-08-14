class AnimeLike < ApplicationRecord
  belongs_to :anime_post
  belongs_to :user
end
