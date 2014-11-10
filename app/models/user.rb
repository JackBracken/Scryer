class User < ActiveRecord::Base
  self.table_name = 'user'
  #self.primary_key = :id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable
  establish_connection "#{Rails.env}_dlp"

  has_many :feedbacks

  def is_admin?
    try(:usergroupid) == 6
  end

  def encrypted_password
    password
  end
end
