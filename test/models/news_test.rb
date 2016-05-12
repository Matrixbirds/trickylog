require 'test_helper'

class NewsTest < ActiveSupport::TestCase
  should belong_to(:news_sourceurl).class_name(:NewsSourceurl)
end
