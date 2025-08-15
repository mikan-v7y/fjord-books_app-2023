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
end
