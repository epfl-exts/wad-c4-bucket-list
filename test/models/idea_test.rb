require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test "with a title that is too long" do
    idea = Idea.new title: "This is a title that is far too long to be valid and will a validation error"
    idea.save

    refute idea.valid?
    assert_includes idea.errors.full_messages, "Title is too long (maximum is 75 characters)"
  end

  test "with no title" do
    idea = Idea.new
    idea.save

    refute idea.valid?
    assert_includes idea.errors.full_messages, "Title can't be blank"
  end

  test "the first empty Idea created is first in the list" do
    first_idea = Idea.new title: 'An interesting idea',
                          user: User.new
    first_idea.save!
    second_idea = Idea.new title: 'Another interesting idea',
                           user: User.new
    second_idea.save!
    assert_equal(first_idea, Idea.all.first)
  end

  test "the first complete Idea created is first in the list" do
    first_idea = Idea.new title: "Cycle around Lac Léman",
                          photo_url: "http://mybucketlist.ch/an_image.jpg",
                          done_count: 5,
                          user: User.new
    first_idea.save!
    second_idea = Idea.new title: "Do a tandem paraponte",
                           photo_url: "http://mybucketlist.ch/another_image.jpg",
                           done_count: 8,
                           user: User.new
    second_idea.save!
    
    assert_equal(first_idea, Idea.all.first)
  end

  test "updated_at is changed after updating the title" do
    idea = Idea.new title: "Visit Marrakech",
                    user: User.new
    idea.save!

    first_updated_at = idea.updated_at

    idea.title = "Visit the market in Marrakech"
    idea.save!

    refute_equal(idea.updated_at, first_updated_at)
  end

	test "updated_at is changed after updating the done_count" do
    idea = Idea.new title: 'An interesting idea',
                    done_count: 23,
                    user: User.new
    idea.save!

    first_updated_at = idea.updated_at

    idea.done_count = 24
    idea.save!

    refute_equal(idea.updated_at, first_updated_at)
  end

	test "updated_at is changed after updating the photo_url" do
    idea = Idea.new title: 'An interesting idea',
                    photo_url: "https://mybucketlist.ch/an_image.png",
                    user: User.new
    idea.save!

    first_updated_at = idea.updated_at

    idea.photo_url = "https://mybucketlist.ch/another_image.png"
    idea.save!

    refute_equal(idea.updated_at, first_updated_at)
  end

  test "one matching result" do
    idea = Idea.new title: "Stand at the top of the Empire State building",
                    user: User.new
    idea.save!

    results = Idea.search("the top")
    assert_equal results.length, 1
  end

  test "only description matches" do
    idea = Idea.new title: "Surfing in Portugal",
                    description: "See what Atlantic coast waves are like!",
                    user: User.new
    idea.save!

    results = Idea.search("coast")
    assert_equal results.length, 1
  end

  test "both description and title match" do
    idea_1 = Idea.new title: "Overnight hike in Switzerland",
                      description: "Stay in a Swiss refuge in the mountains",
                      user: User.new
    idea_1.save!

    idea_2 = Idea.new title: "Hike the mountains in Italy",
                      description: "See the Dolomites and Italian Alps",
                      user: User.new
    idea_2.save!

    results = Idea.search("mountains")
    assert_equal results.length, 2
  end

  test "no matching results" do
    idea = Idea.new title: "Stand at the top of the Empire State building",
                    user: User.new
    idea.save!

    results = Idea.search("snorkelling")
    assert_empty results
  end

	test "two matching results" do
    idea_1 = Idea.new title: "Stand at the top of the Empire State building",
                      user: User.new
    idea_1.save!

    idea_2 = Idea.new title: "Stand on the pyramids",
                      user: User.new
    idea_2.save!

    results = Idea.search("Stand")
    assert_equal results.length, 2
  end

  test "most_recent with no records" do
    results = Idea.most_recent
    assert_empty results
  end

  test "most_recent with two records" do
    idea_1 = Idea.new title: "Stand at the top of the Empire State building",
                      user: User.new
    idea_1.save!

    idea_2 = Idea.new title: "Stand on the pyramids",
                      user: User.new
    idea_2.save!

    results = Idea.most_recent
    assert_equal results.length, 2
  end

  test "most_recent with six records" do
    user = User.new

    1.upto(6) do |i|
      idea = Idea.new title: "Idea number #{i}",
                      user: user
      idea.save!
    end

    results = Idea.most_recent
    assert_equal results.length, 3
  end
end
