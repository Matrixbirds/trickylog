require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = create(:user, :female, password: '123123', password_confirmation: '123123')
  end

  %i[articles comments].each do |_field|
    should have_many(_field).with_foreign_key(:author_id).class_name("#{_field}".singularize.capitalize)
  end

  %i[name password].each do |_field|
    should validate_presence_of(_field)
    should_not allow_value(nil, "", " ").for(_field)
  end

  should validate_uniqueness_of(:name).case_insensitive
  should validate_confirmation_of(:password)

  test "should validate password && password_confirmation on create" do
    user = User.create(:name => Time.now.to_s, :password => nil, :password_confirmation => nil)
    assert_equal ["不能为空"], user.errors.messages[:password]
    assert_equal ["不能为空"], user.errors.messages[:password_confirmation]
    user = User.create(:name => Time.now.to_s)
  end
end
