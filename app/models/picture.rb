class Picture < ApplicationRecord
  belongs_to :user, required: false

  has_attached_file :image, styles: { board: '900x900#' }
  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\z/ }, size: { in: 0..50.megabytes }
  validates :image, dimensions: { width: 500, height: 500 }

end
