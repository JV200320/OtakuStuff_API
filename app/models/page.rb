class Page < ApplicationRecord
  belongs_to :user

  has_many :page_posts
  has_many :page_relationships
  has_many :followers, through: :page_relationships, source: :user

  has_one_attached :page_image

  validates :title, :owner_nickname, presence: true

  before_update :update_image, if: -> { image_changed? }

  def attach_image(file)
    unless file.class != ActionDispatch::Http::UploadedFile
      page_image.attach(io: file, filename: "#{self.nickname}.jpg")
      image = url_for(page_image)
    end
  end

  def update_image
    page_image = open(self.image)
    self.page_image.attach(io: page_image, filename: "#{self.nickname}.jpg")
  end

end
