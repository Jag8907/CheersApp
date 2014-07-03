# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  public     :boolean          not null
#  completed  :boolean          not null
#  title      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Goal < ActiveRecord::Base
  validates :user_id, :title, :completed, :public, presence: true
  
  belongs_to :user
end
