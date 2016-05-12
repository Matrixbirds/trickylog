# == Schema Information
# Schema version: 20160310132348
#
# Table name: news
#
#  id                :uuid             not null, primary key
#  title             :string
#  url               :string
#  provider          :integer
#  news_sourceurl_id :uuid             indexed
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_news_on_news_sourceurl_id  (news_sourceurl_id)
#

class News < ActiveRecord::Base
  belongs_to :news_sourceurl

  enum provider: [:default]
end
