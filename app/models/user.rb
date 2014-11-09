class User < ActiveRecord::Base
  self.table_name = 'user'
  #self.primary_key = :id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable
  establish_connection "#{Rails.env}_dlp"

  def encrypted_password
    password
  end
end