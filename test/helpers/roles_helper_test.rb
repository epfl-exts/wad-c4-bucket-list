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

  test "admin can edit an Idea they do not own" do
    admin = User.create! email: "admin@epfl.ch",
      password: "password",
      role: "admin"

    self.current_user = admin

    owner = User.create! email: "owner@epfl.ch",
      password: "password"
    idea = Idea.create! user: owner, title: "A fun idea"

    assert can_edit?(idea)
  end
end
