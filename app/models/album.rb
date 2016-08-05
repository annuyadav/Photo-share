class Album < ActiveRecord::Base

  # ==== Associations =============================================
  NUMBER_OF_PHOTOS_ALLOWED = 4

  # ==== Associations =============================================
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'
  has_many :photos, dependent: :destroy

  # ==== Validations ==============================================
  validates :name, presence: true, length: 2..100
  # validates_length_of :photos, maximum: 3

  def default_photo_url
    _photo = photos.first || Photo.new
    _photo.image.url(:thumb)
  end

end
