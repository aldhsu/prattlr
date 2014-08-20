# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  topic      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Room < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :messages
end
