require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "changing the associated Idea for a Comment" do
    idea = Idea.new title: "Learn to play guitar",
                    user: User.new
    idea.save!

    comment = Comment.new body: "I'd like to do this!",
                          idea: idea,
                          user: User.new
    comment.save!

    second_idea = Idea.new title: "Learn to ski",
                           user: User.new
    second_idea.save!

    comment.idea = second_idea
    comment.save!

    assert_equal Comment.first.idea, second_idea
  end

  test "cascading save" do
    idea = Idea.new title: "Learn to play guitar",
                    user: User.new
    idea.save!

    comment = Comment.new body: "I'd like to do this!",
                          user: User.new
    idea.comments << comment
    idea.save!

    assert_equal Comment.first, comment
  end
  
  test "comments are ordered correctly" do
    idea = Idea.new title: "Learn to play guitar",
                    user: User.new
    idea.save!

    user = User.new

    comment_1 = Comment.new body: "Great idea!", user: user
    comment_2 = Comment.new body: "I agree! I'd like to do this as well", user: user

    idea.comments << comment_1
    idea.comments << comment_2
    idea.save!

    assert_equal Comment.first, comment_1
    assert_equal 2, Comment.all.length
  end
end
