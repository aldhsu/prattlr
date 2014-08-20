# == Schema Information
#
# Table name: messages
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  parent_id      :integer
#  content        :string(255)
#  upvotes        :integer
#  downvotes      :integer
#  created_at     :datetime
#  updated_at     :datetime
#  parent_message :integer
#  room_id        :integer
#

class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
  has_many :children, class_name: "Message", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Message"
end
