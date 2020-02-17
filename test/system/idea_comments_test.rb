require "application_system_test_case"

class IdeaCommentsTest < ApplicationSystemTestCase
  test "adding a comment to an idea" do
    idea = Idea.new title: "Visit Vancouver",
                    user: User.new
    idea.save!

    visit new_user_path
    fill_in "Email", with: "exists@epfl.ch"
    fill_in "Password", with: "password"
    click_on "Sign up"


    visit idea_path(idea)
    fill_in "Add a comment", with: "Canada is so much fun!"
    click_on "Post"

    assert_equal idea_path(idea), current_path
    assert has_content?("Canada is so much fun!")
  end

  test "Comment cannot be added when not logged in" do

    idea = Idea.new title: "Visit Vancouver",
                    user: User.new
    idea.save!

    visit idea_path(idea)

    refute page.has_content?("Add a comment")
  end
end
