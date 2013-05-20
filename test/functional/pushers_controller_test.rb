require 'test_helper'

class PushersControllerTest < ActionController::TestCase
  setup do
    @pusher = pushers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pushers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pusher" do
    assert_difference('Pusher.count') do
      post :create, pusher: { identifier: @pusher.identifier, key: @pusher.key }
    end

    assert_redirected_to pusher_path(assigns(:pusher))
  end

  test "should show pusher" do
    get :show, id: @pusher
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pusher
    assert_response :success
  end

  test "should update pusher" do
    put :update, id: @pusher, pusher: { identifier: @pusher.identifier, key: @pusher.key }
    assert_redirected_to pusher_path(assigns(:pusher))
  end

  test "should destroy pusher" do
    assert_difference('Pusher.count', -1) do
      delete :destroy, id: @pusher
    end

    assert_redirected_to pushers_path
  end
end
