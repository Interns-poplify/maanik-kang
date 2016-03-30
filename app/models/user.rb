class User < ActiveRecord::Base
	has_many :articles, dependent: :destroy

  has_many :comments,dependent: :destroy
  has_attached_file :image, :styles => { :small => "150x150",thumb: "100x100",medium: "300X300" }
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
