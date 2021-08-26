# frozen_string_literal: true

# User class
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  # Followers and Followed users
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  # Pages
  has_many :pages, dependent: :destroy
  has_many :page_relationships, dependent: :destroy
  has_many :followed_pages, through: :page_relationships

  # Likes and posts
  has_many :anime_posts, dependent: :destroy
  has_many :anime_likes, dependent: :destroy
  has_many :page_posts, dependent: :destroy
  has_many :page_likes, dependent: :destroy

  # Profile avatar
  has_one_attached :avatar

  # Attach avatar before update
  before_update :update_avatar, if: -> { image_changed? }

  # Validations
  validates :nickname, :email, :bio, presence: true
  validates :nickname, uniqueness: true

  # Method to follow another user
  def follow!(other_user)
    return unless other_user != self

    relationships.create!(followed_id: other_user.id)
  end

  # Method to check if other user is being followed by user
  def following?(other_user)
    if relationships.find_by(followed_id: other_user.id).nil?
      false
    else
      true
    end
  end

  # Method to unfollow other user
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  # Method to follow page
  def follow_page!(page)
    page_relationships.create!(page_id: page.id)
  end

  # Method to check if page is being followed by user
  def following_page?(page)
    if page_relationships.find_by(page_id: page.id).nil?
      false
    else
      true
    end
  end

  # Method to unfollow page
  def unfollow_page!(page)
    page_relationships.find_by_page_id(page.id).destroy
  end

  # Method to attach avatar after create
  def attach_avatar(file)
    path_avatar = 'public/images/default_profile/doggo.jpg'
    if image.nil? || file.class != ActionDispatch::Http::UploadedFile
      avatar.attach(io: File.open(path_avatar), filename: 'doggo.jpg')
    else
      avatar.attach(io: file, filename: "#{nickname}.jpg")
    end
  end

  # Method to update attached avatar before update
  def update_avatar
    image = open(self.image)
    avatar.attach(io: image, filename: "#{nickname}.jpg")
  end

  # Method to like and undo like on anime posts
  def anime_like_post(anime_post)
    if AnimeLike.find_by(anime_post_id: anime_post.id, user_id: id).nil? && (anime_post.user_id != id)
      anime_likes.create(anime_post_id: anime_post.id)
    end
  end

  def undo_anime_like_post(anime_post)
    like = AnimeLike.find_by(anime_post_id: anime_post.id, user_id: id)
    like.destroy unless like.nil?
  end

  # Method to like and undo like on page posts
  def page_like_post(page_post)
    if PageLike.find_by(page_post_id: page_post.id, user_id: id).nil? && (page_post.user_id != id)
      page_likes.create(page_post_id: page_post.id)
    end
  end

  def undo_page_like_post(page_post)
    like = PageLike.find_by(page_post_id: page_post.id, user_id: id)
    like.destro

    require 'open-uri'y unless like.nil?
  end
end
