require "test_helper"

class DiscussionThreadsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get discussion_threads_new_url
    assert_response :success
  end

  test "should get create" do
    get discussion_threads_create_url
    assert_response :success
  end

  test "should get edit" do
    get discussion_threads_edit_url
    assert_response :success
  end

  test "should get update" do
    get discussion_threads_update_url
    assert_response :success
  end

  test "should get destroy" do
    get discussion_threads_destroy_url
    assert_response :success
  end
end
