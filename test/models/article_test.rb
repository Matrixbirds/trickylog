require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  setup do
    create(:article)
  end

  should have_many(:comments).class_name(:Comment)

  should belong_to(:author).class_name(:User)
  should belong_to(:author).with_foreign_key(:author_id)

  %i[title content].each do |_field|
    should validate_presence_of(_field)
    should_not allow_value(nil, "", " ").for(_field)
  end

  # should validate_uniqueness_of(:title)
end
