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
#

require 'rails_helper'

RSpec.describe Message, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
