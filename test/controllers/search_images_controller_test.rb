require 'test_helper'

class SearchImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @search_image = search_images(:one)
  end

  test "should get index" do
    get search_images_url
    assert_response :success
  end

  test "should get new" do
    get new_search_image_url
    assert_response :success
  end

  test "should create search_image" do
    assert_difference('SearchImage.count') do
      post search_images_url, params: { search_image: {  } }
    end

    assert_redirected_to search_image_url(SearchImage.last)
  end

  test "should show search_image" do
    get search_image_url(@search_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_search_image_url(@search_image)
    assert_response :success
  end

  test "should update search_image" do
    patch search_image_url(@search_image), params: { search_image: {  } }
    assert_redirected_to search_image_url(@search_image)
  end

  test "should destroy search_image" do
    assert_difference('SearchImage.count', -1) do
      delete search_image_url(@search_image)
    end

    assert_redirected_to search_images_url
  end
end
