require "test_helper"

class Api::V1::Me::FollowsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_me_follows_url, headers: { "X-User-Id" => users(:one).id }

    assert_response :success

    json_response = JSON.parse(response.body)

    assert_equal json_response.length, 1
    assert_equal json_response[0]["id"], users(:two).id
    assert_equal json_response[0]["name"], users(:two).name
  end

  test "should create follow" do
    post api_v1_me_follows_url, headers: { "X-User-Id" => users(:one).id }, params: { user_id: users(:three).id }

    assert_response :created

    json_response = JSON.parse(response.body)

    assert_equal json_response["followed_id"], users(:three).id
    assert_equal json_response["follower_id"], users(:one).id
  end

  test "should not create follow if user is not found" do
    post api_v1_me_follows_url, headers: { "X-User-Id" => users(:one).id }, params: { user_id: 5 }

    assert_response :unprocessable_content
  end

  test "should not create follow if user is the same as the current user" do
    user = users(:one)
    post api_v1_me_follows_url, headers: { "X-User-Id" => user.id }, params: { user_id: user.id }

    assert_response :unprocessable_content
  end

  test "should not create follow if user is already followed" do
    post api_v1_me_follows_url, headers: { "X-User-Id" => users(:one).id }, params: { user_id: users(:two).id }

    assert_response :unprocessable_content
  end

  test "should destroy follow" do
    delete api_v1_me_follow_url(id: users(:two).id), headers: { "X-User-Id" => users(:one).id }

    assert_response :no_content
  end
end