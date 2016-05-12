require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  setup do
    create(:comment, :associate_author, :associate_article)
  end

  should belong_to(:author).class_name(:User)
  should belong_to(:author).with_foreign_key(:author_id)
  should belong_to(:author).touch(true)

  should belong_to(:article).class_name(:Article)

  %i[title content].each do |_field|
    should validate_presence_of(_field)
  end
  should validate_uniqueness_of(:title)
  should_not allow_value(nil, "", " ").for(:content)
end
