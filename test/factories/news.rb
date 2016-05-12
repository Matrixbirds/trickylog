# == Schema Information
# Schema version: 20160310132348
#
# Table name: news
#
#  id                :uuid             not null, primary key
#  url               :string
#  provider          :string
#  news_sourceurl_id :uuid             indexed
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_news_on_news_sourceurl_id  (news_sourceurl_id)
#

FactoryGirl.define do
  factory :news do
    url "https://github.co"
    provider "default"
    association :news_sourceurl, factory: :news_sourceurl
  end
end
