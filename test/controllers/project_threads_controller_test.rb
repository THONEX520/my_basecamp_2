require "test_helper"

class ProjectThreadsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get project_threads_new_url
    assert_response :success
  end

  test "should get edit" do
    get project_threads_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get project_threads_destroy_url
    assert_response :success
  end
end
