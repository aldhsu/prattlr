# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates_uniqueness_of :username
  validates :username, presence: true
  validates :username, length: {in: 6..12}
  has_secure_password
  has_many :messages
  has_and_belongs_to_many :rooms
end
