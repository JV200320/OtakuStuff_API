# frozen_string_literal: true
require 'open-uri'
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_one_attached :avatar

  after_create :attach_avatar
  before_update :update_avatar, if: -> {image_changed?}

  validates :nickname, :email, :bio, presence: true
  validates :nickname, uniqueness: true

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    if relationships.find_by(followed_id: other_user.id).nil?
      false
    else
      true
    end
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  def attach_avatar
    path_avatar = 'public/images/default_profile/doggo.jpg'
    if self.image.nil?
      self.avatar.attach(io: File.open(path_avatar), filename: 'doggo.jpg')
    else
      image = open(self.image)
      self.avatar.attach(io: image, filename: "#{self.nickname}.jpg")
    end
  end

  def update_avatar
    image = open(self.image)
    self.avatar.attach(io: image, filename: "#{self.nickname}.jpg")
  end

  def like_post(post)
    if Like.find_by(post_id: post.id, user_id: id).nil?
      if post.user_id != id
        likes.create(post_id: post.id)
      end
    end
  end
  
  def undo_like_post(post)
    like = Like.find_by(post_id: post.id, user_id: id)
    unless like.nil?
      like.destroy
    end
  end
  

end
