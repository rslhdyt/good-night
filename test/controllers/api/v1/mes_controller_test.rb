require "test_helper"

class Api::V1::MesControllerTest < ActionDispatch::IntegrationTest
  test "should return unauthorized if user id header is not present" do
    get api_v1_me_url

    assert_response :unauthorized
  end

  test "should return unauthorized if user id header is present but user is not found" do
    users(:one)

    get api_v1_me_url, headers: { "X-User-Id" => 5 }

    assert_response :unauthorized
  end

  test "should return current user if user id header is present and user is found" do
    user = users(:one)

    get api_v1_me_url, headers: { "X-User-Id" => user.id }

    assert_response :success

    json_response = JSON.parse(response.body)

    assert_equal json_response["id"], user.id 
    assert_equal json_response["name"], user.name
  end

  test "should return following sleeps" do
    get following_sleeps_api_v1_me_url, headers: { "X-User-Id" => users(:one).id }

    assert_response :success

    json_response = JSON.parse(response.body)

    assert_equal json_response.length, 1
  end
end