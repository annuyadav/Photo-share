class User < ActiveRecord::Base

  # ===== Constants ===============================================
  STAMP_WIDTH = 50
  STAMP_HEIGHT = 50
  THUMBNAIL_WIDTH = 200
  THUMBNAIL_HEIGHT = 200
  MEDIUM_WIDTH = 300
  MEDIUM_HEIGHT = 300

  # ==== Validations ==============================================
  validates :first_name, :last_name, presence: true, length: 2..72

  # ==== Associations =============================================
  has_many :albums, dependent: :destroy
  has_many :photos, through: :albums

  has_attached_file :profile_pic, styles: {medium: "#{MEDIUM_WIDTH}x#{MEDIUM_HEIGHT}>", thumb: "#{THUMBNAIL_WIDTH}x#{THUMBNAIL_HEIGHT}>", stamp: "#{STAMP_WIDTH}x#{STAMP_HEIGHT}>"}, default_url: "/default_user_img.png"
  validates_attachment_content_type :profile_pic,
                                    :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg'],
                                    :message => "Sorry, we don't support that type of image format"

  # ==== Devise settings ==========================================
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable, :trackable

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable


  def full_name
    [first_name, last_name].join(' ')
  end

end
