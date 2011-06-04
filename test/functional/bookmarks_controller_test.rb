require 'test_helper'

class BookmarksControllerTest < ActionController::TestCase
  setup do
    session[:user_id] = users(:electrum).id
  end

  test "should get index" do
    get :index
    assert_response :success
  end
end
