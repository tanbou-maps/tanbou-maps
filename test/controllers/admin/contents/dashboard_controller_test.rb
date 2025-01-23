require "test_helper"

class Admin::Contents::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_contents_dashboard_index_url
    assert_response :success
  end
end
