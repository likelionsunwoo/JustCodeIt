require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get detail" do
    get :detail
    assert_response :success
  end

end
