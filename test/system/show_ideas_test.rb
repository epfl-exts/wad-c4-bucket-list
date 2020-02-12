require "application_system_test_case"

class ShowIdeasTest < ApplicationSystemTestCase
  test "show an Idea" do
    idea = Idea.new title: "Make a birthday cake",
                    done_count: 33,
                    user: User.new
    idea.save!

    visit(idea_path(idea))
    assert has_content?(idea.title)
    assert has_content?(idea.done_count)
    assert has_content?(idea.created_at.strftime("%d %b '%y"))

    click_on("Edit")

    assert_equal current_path, edit_idea_path(idea)
  end
end
