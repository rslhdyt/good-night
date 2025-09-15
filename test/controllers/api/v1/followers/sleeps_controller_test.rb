require "test_helper"

class Api::V1::Followers::SleepsControllerTest < ActionDispatch::IntegrationTest
  test "should get follower's sleeps" do
    follower = users(:two)
    get api_v1_follower_sleeps_url(user_id: follower.id), headers: { "X-User-Id" => users(:one).id }

    assert_response :success

    json_response = JSON.parse(response.body)
    # Assuming follower has one sleep in the fixture
    assert_equal 1, json_response.length
    assert_equal follower.id, json_response[0]["user_id"]
  end

  test "should return not found if follower does not exist" do
    get api_v1_follower_sleeps_url(user_id: 999), headers: { "X-User-Id" => users(:one).id }

    assert_response :not_found
  end

  test "should return unauthorized if user id header is missing" do
    get api_v1_follower_sleeps_url(user_id: users(:two).id)

    assert_response :unauthorized
  end
end
