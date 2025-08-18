# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test '#name_or_email' do
    user = User.new(email: 'mikan@example.com', name: '')
    assert_equal 'mikan@example.com', user.name_or_email

    user.name = 'Mikan'
    assert_equal 'Mikan', user.name_or_email
  end
end
