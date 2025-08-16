# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @alice_report = reports(:one)
    @bob_report = reports(:two)
  end

  test 'editable a Report' do
    report = reports(:one)
    assert report.editable?(users(:one))
  end

  test 'uneditable a Report' do
    report = reports(:two)
    assert_not report.editable?(users(:one))
  end

  test 'created_on' do
    report = reports(:one)
    assert_instance_of Date, report.created_on
    assert_equal Date.new(2025, 8, 15), report.created_on
  end

  test 'save_mentions: not mention myself' do
    @alice_report.content = "自分自身の日報を言及する http://localhost:3000/reports/#{@alice_report.id}"
    @alice_report.send(:save_mentions)
    assert_not_includes @alice_report.mentioning_reports, @alice_report
  end
end
