require 'test_helper'

class ModelControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
