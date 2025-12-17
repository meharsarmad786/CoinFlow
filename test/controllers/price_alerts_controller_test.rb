require "test_helper"

class PriceAlertsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get price_alerts_index_url
    assert_response :success
  end

  test "should get create" do
    get price_alerts_create_url
    assert_response :success
  end

  test "should get destroy" do
    get price_alerts_destroy_url
    assert_response :success
  end
end
