# frozen_string_literal: true

require 'test_helper'

class ReportMentionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'alice_report_mentions_on_bob_report' do
    alice_report = reports(:alice_report)
    bob_report = reports(:bob_report)

    assert_includes alice_report.mentioning_reports, bob_report
  end

  test 'bob_report_is_mentioned_in_alice_report' do
    alice_report = reports(:alice_report)
    bob_report = reports(:bob_report)

    assert_includes bob_report.mentioned_reports, alice_report
  end
end
