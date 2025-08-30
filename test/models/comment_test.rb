# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test 'alice can comment on bobs report' do
    comment = comments(:alice_comment_on_bob_report)

    assert_equal 'aliceがbobの日報にコメントを書きます', comment.content
    assert_equal reports(:bob_report), comment.commentable
    assert_equal users(:alice), comment.user
  end
end
