require "application_system_test_case"

class SearchesTest < ApplicationSystemTestCase
  test "searching with matches on title and description" do
    idea_1 = Idea.new title: "Go cycling across Europe",
                      description: "An amazing way to see lots of Europe",
                    user: User.new
    idea_1.save!

    idea_2 = Idea.new title: "Visit Provence",
                      description: "Go to vineyards, go cycling up Mont Ventoux, see the lavendar fields",
                      user: User.new
    idea_2.save!

    idea_3 = Idea.new title: "Overnight hike in Switzerland",
                      description: "Stay in a Swiss refuge in the mountains",
                      user: User.new
    idea_3.save!

    visit(root_path)

    fill_in("q", with: "cycling")
    click_on("Search", match: :first)

    assert has_content?("Go cycling across Europe")
    assert has_content?("Visit Provence")
    refute has_content?("Overnight hike in Switzerland")
  end
end
