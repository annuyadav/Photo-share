class Photo < ActiveRecord::Base

  # ==== Validations ==============================================
  validates :tag_line, presence: true, length: 2..170
  validates :image, :album, presence: true

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>", large: "600x600>" }, default_url: '/missing.png'
  validates_attachment_content_type :image,
                                    :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg'],
                                    :message => "Sorry, we don't support that type of image format"

  # ==== Associations =============================================
  belongs_to :album
  has_one :owner, through: :album

  validate :on => :create do
    if album && album.photos.length >= Album::NUMBER_OF_PHOTOS_ALLOWED
      errors.add(:album, 'photo limit exceeded.')
    end
  end

end
