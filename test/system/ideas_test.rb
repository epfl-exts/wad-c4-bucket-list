require "application_system_test_case"

class IdeasTest < ApplicationSystemTestCase
  test "create new idea" do
    visit new_user_path
    fill_in "Email", with: "exists@epfl.ch"
    fill_in "Password", with: "password"
    click_on "Sign up"

		visit new_idea_path
    fill_in 'Title', with: 'See the Matterhorn'
    fill_in 'Done count', with: 10
    fill_in 'Photo url', with: "http://fpoimg.com/255x170"
    click_on 'Create'
    visit ideas_path
    assert has_content?("See the Matterhorn")
  end

  test "create two new ideas" do
    visit new_user_path
    fill_in "Email", with: "exists@epfl.ch"
    fill_in "Password", with: "password"
    click_on "Sign up"

		visit new_idea_path
    fill_in 'Title', with: 'See the Matterhorn'
    fill_in 'Done count', with: 10
    fill_in 'Photo url', with: "http://fpoimg.com/255x170"
    click_on 'Create'

		visit new_idea_path
    fill_in 'Title', with: 'See Mont Blanc'
    fill_in 'Done count', with: 14
    fill_in 'Photo url', with: "http://fpoimg.com/255x170"
    click_on 'Create'
    
    visit ideas_path

    assert has_content?("See the Matterhorn")
    assert has_content?("See Mont Blanc")
  end

  test "creating an idea with invalid title" do
    visit new_user_path
    fill_in "Email", with: "exists@epfl.ch"
    fill_in "Password", with: "password"
    click_on "Sign up"

    visit new_idea_path
    fill_in 'Done count', with: 27
    fill_in 'Photo url', with: "http://fpoimg.com/255x170"
    click_on 'Create'

    assert has_content?("Title can't be blank")
  end

  test "editing an idea" do
    idea = Idea.new title: "Make a birthday cake",
                    done_count: 33,
                    user: User.new(email: 'test@epfl.ch', password: 'password')
    idea.save!
                    
    visit(edit_idea_path(idea))

    fill_in "Done count", with: 44
    fill_in "Title", with: "Make a Christmas cake"

    click_on "Update Idea"
    click_on "Make a Christmas cake"

    sleep 0.2
    assert has_content?("Make a Christmas cake")
    assert has_content?("44 have done")
  end

  test "editing an idea with validation errors" do
    idea = Idea.new title: "Make a birthday cake",
                    done_count: 33,
                    user: User.new(email: "test@epfl.ch",
                    password: "password")
    idea.save!
                    
    visit(edit_idea_path(idea))

    fill_in "Title", with: "This title is far, far too long to pass the validation rules for the Idea model"

    click_on "Update Idea"

    assert has_content?("Title is too long (maximum is 75 characters)")
  end

  test "search" do
    idea_1 = Idea.new title: "Climb Mont Blanc",
                      user: User.new(email: "test@epfl.ch",
                      password: "password")
    idea_1.save!

    idea_2 = Idea.new title: "Visit Niagara Falls",
                      user: User.new(email: "test@epfl.ch",
                      password: "password")
    idea_2.save!

    visit(root_path)

    fill_in("q", with: "Mont")
    click_on("Search", match: :first)

    assert has_content?("Climb Mont Blanc")
    refute has_content?("Visit Niagara Falls")
  end

	test "no matching results" do
    idea = Idea.new title: "Stand at the top of the Empire State building",
                    user: User.new(email: "test@epfl.ch",
                    password: "password")
    idea.save!

    visit(root_path)

    fill_in("q", with: "Mont")
    click_on("Search", match: :first)

    assert has_content?("No ideas found!")
  end
end
