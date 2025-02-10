require "test_helper"

class Admin::Users::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_users_dashboard_index_url
    assert_response :success
  end
end
