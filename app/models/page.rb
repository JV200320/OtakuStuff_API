require 'open-uri'
class Page < ApplicationRecord
  belongs_to :user

  has_many :page_posts
  has_many :page_relationships
  has_many :followers, through: :page_relationships, source: :user

  has_one_attached :page_image

  validates :title, presence: true

  after_create :attach_image
  before_update :update_image, if: -> { image_changed? }

  def attach_image
    path_page_image = 'public/images/default_profile/doggo.jpg'
    if self.image.nil?
      self.page_image.attach(io: File.open(path_page_image), filename: 'doggo.jpg')
    else
      page_image = open(self.image)
      self.page_image.attach(io: page_image, filename: "#{self.nickname}.jpg")
    end
  end

  def update_image
    page_image = open(self.image)
    self.page_image.attach(io: page_image, filename: "#{self.nickname}.jpg")
  end

end
