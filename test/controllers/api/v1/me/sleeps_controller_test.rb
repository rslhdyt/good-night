class Api::V1::Me::SleepsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_me_sleeps_url, headers: { "X-User-Id" => users(:one).id }

    assert_response :success

    json_response = JSON.parse(response.body)

    assert_equal json_response.length, 1
    assert_equal json_response[0]["duration"], sleeps(:one).duration
  end

  test "should create sleep" do
    post api_v1_me_sleeps_url, headers: { "X-User-Id" => users(:one).id }

    assert_response :created

    json_response = JSON.parse(response.body)

    assert_not_nil json_response["sleep_start"]
    assert_nil json_response["duration"]

    assert_equal Sleep.count, 4
  end

  test "should not create sleep if user already has an active sleep session" do
    sleep = sleeps(:active)
    post api_v1_me_sleeps_url, headers: { "X-User-Id" => sleep.user_id }

    assert_response :unprocessable_content
  end
  
  test "should update sleep" do
    sleep = sleeps(:active)
    patch api_v1_me_sleep_url(id: sleep.id), headers: { "X-User-Id" => sleep.user_id }

    assert_response :ok

    json_response = JSON.parse(response.body)

    assert_not_nil json_response["duration"]
    assert_not_nil json_response["sleep_end"]
  end

  test "should not update sleep if sleep already ended" do
    patch api_v1_me_sleep_url(id: sleeps(:one).id), headers: { "X-User-Id" => users(:one).id }

    assert_response :unprocessable_content
  end

  test "should not update sleep if sleep is not found" do
    patch api_v1_me_sleep_url(id: 999), headers: { "X-User-Id" => users(:one).id }

    assert_response :not_found
  end
end