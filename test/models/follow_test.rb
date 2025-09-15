require "test_helper"

class FollowTest < ActiveSupport::TestCase
  test "validations should not be valid without a follower_id" do
    follow = Follow.new
    assert_not follow.valid?

    assert_includes follow.errors[:follower_id], "can't be blank"
  end
  
  test "validations should not be valid without a followed_id" do
    follow = Follow.new
    assert_not follow.valid?

    assert_includes follow.errors[:followed_id], "can't be blank"
  end
  
  test "validations should not be valid with a combination that is already taken" do
    follow = Follow.new(follower_id: 1, followed_id: 2)
    assert_not follow.valid?

    assert_includes follow.errors[:followed_id], "has already been taken"
  end
  
  test "validations should not be valid when followed_id is the same as follower_id" do
    follow = Follow.new(follower_id: 1, followed_id: 1)
    assert_not follow.valid?

    assert_includes follow.errors[:followed_id], "is the same as follower_id"
  end
end
