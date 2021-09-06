require 'test_helper'

class DeckReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get deck_reviews_new_url
    assert_response :success
  end

  test "should get create" do
    get deck_reviews_create_url
    assert_response :success
  end

  test "should get destroy" do
    get deck_reviews_destroy_url
    assert_response :success
  end

end
