require "application_system_test_case"

class HomePagesTest < ApplicationSystemTestCase
  test "home page displays most recent Ideas" do
    1.upto(4) do |i|
      idea = Idea.new title: "Idea number #{i}",
                      user: User.new
      idea.save!
    end

    visit root_path
    assert has_content?("Idea number 4")
    assert has_content?("Idea number 3")
    assert has_content?("Idea number 2")
  end
end
