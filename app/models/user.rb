# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  password   :string(255)
#  token      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :username, :password, presence: true
  validates :username, uniqueness: true
  validates :password, length: {minimum: 6}
  
  def set_token
    self.token = SecureRandom.urlsafe_base64(16)
    self.save!
    self.token
  end
  
  has_many :goals
end
