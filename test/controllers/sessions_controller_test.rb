require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
  end

  test "access signin session" do
    get :signin
    assert_response :success
  end

  test "access create session" do
    post :create, { session: { username: @user.name, password: @user.password } }
    assert_redirected_to admin_root_path
  end

  test "access destroy session" do
    delete :destroy
    assert_redirected_to root_path
  end

end
