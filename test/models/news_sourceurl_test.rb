require 'test_helper'

class NewsSourceurlTest < ActiveSupport::TestCase
  should have_many(:news).class_name(:News)
end
