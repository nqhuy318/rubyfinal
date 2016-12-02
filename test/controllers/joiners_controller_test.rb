require 'test_helper'

class JoinersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get joiners_new_url
    assert_response :success
  end

  test "should get edit" do
    get joiners_edit_url
    assert_response :success
  end

  test "should get delete" do
    get joiners_delete_url
    assert_response :success
  end

end
