# == Schema Information
# Schema version: 20160310132348
#
# Table name: news_sourceurls
#
#  id          :uuid             not null, primary key
#  description :string
#  source_url  :string
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :news_sourceurl do
    description FFaker::Lorem.sentences(10)
    source_url "https://github.com"
  end
end
