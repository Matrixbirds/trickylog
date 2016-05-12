# == Schema Information
# Schema version: 20160310132348
#
# Table name: messages
#
#  id          :uuid             not null, primary key
#  user_id     :uuid             indexed
#  user_name   :string
#  user_avatar :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_messages_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :message do
    user_name FFaker::Name.name
    content [FFaker::Name.name] * 3 * " >_< "
  end
end
