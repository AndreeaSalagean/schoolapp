require 'test_helper'

class DiscussionsControllerTest < ActionDispatch::IntegrationTest
  test "should get indexedit" do
    get discussions_indexedit_url
    assert_response :success
  end

  test "should get show" do
    get discussions_show_url
    assert_response :success
  end

  test "should get new" do
    get discussions_new_url
    assert_response :success
  end

end
