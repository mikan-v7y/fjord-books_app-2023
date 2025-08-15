# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
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
end
