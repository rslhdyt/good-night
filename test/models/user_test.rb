require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "validations should not be valid without a name" do
    user = User.new
    assert_not user.valid?

    assert_includes user.errors[:name], "can't be blank"
  end

  test "validations should not be valid with a name that is too short" do
    user = User.new(name: "A")
    assert_not user.valid?

    assert_includes user.errors[:name], "is too short (minimum is 3 characters)"
  end

  test "validations should not be valid with a name that is too long" do
    user = User.new(name: "A" * 256)
    assert_not user.valid?

    assert_includes user.errors[:name], "is too long (maximum is 255 characters)"
  end

  test "validations should not be valid with a name that is already taken" do
    User.create(name: "John Doe")
    user = User.new(name: "John Doe")
    assert_not user.valid?

    assert_includes user.errors[:name], "has already been taken"
  end
end
