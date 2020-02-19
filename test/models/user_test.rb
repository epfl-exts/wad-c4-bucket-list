require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "email is downcased before validation" do
    user = User.new email: "nEw@EpFl.Ch"
    user.valid?
    assert_equal "new@epfl.ch", user.email
  end
end
