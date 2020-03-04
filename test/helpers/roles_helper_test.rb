require 'test_helper'

class RolesHelperTest < ActionView::TestCase
  attr_accessor :current_user

  test "owner can edit an Idea they own" do
    owner = User.create! email: "owner@epfl.ch",
      password: "password"

    self.current_user = owner
    idea = Idea.create! user: owner, title: "A fun idea"

    assert can_edit?(idea)
  end
end
