require 'test_helper'

class SessionControllerTest < ActionDispatch::IntegrationTest

  test "should promt for login" do
    get login_url
    assert_response :success
  end

  test "should login" do
    dave = users(:one)
    post login_url, params: { name: dave.name, password: 'secret'}
    assert_redirected_to admin_url
    assert_equal dave.id, session[:user_id]    
  end

  test "should fail login" do
    dave = users(:one)
    post login_url, params: {name: dave.name, password: 'wrong'}
    assert_redirected_to login_url    
  end

  test "should logout" do
    delete logout_url
    assert_redirected_to store_index_url
  end

  # test "should get new" do
  #   get session_new_url
  #   assert_response :success
  # end

  # test "should get create" do
  #   get session_create_url
  #   assert_response :success
  # end

  # test "should get destroy" do
  #   get session_destroy_url
  #   assert_response :success
  # end

end
