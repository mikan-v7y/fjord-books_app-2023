# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @alice_report = reports(:one)
    @bob_report = reports(:two)
    @carol_report = reports(:three)
    @dave_report = reports(:four)
  end

  # editable?をテスト

  test 'editable a Report' do
    report = reports(:one)
    assert report.editable?(users(:one))
  end

  test 'uneditable a Report' do
    report = reports(:two)
    assert_not report.editable?(users(:one))
  end

  # created_onをテスト

  test 'created_on' do
    report = reports(:one)
    assert_instance_of Date, report.created_on
    assert_equal Date.new(2025, 8, 15), report.created_on
  end

  # save_mentionsをテスト

  test 'self-reference is not registered' do
    @alice_report.content = "自分自身の日報を言及する http://localhost:3000/reports/#{@alice_report.id}"
    @alice_report.save!
    assert_not_includes @alice_report.mentioning_reports, @alice_report
  end

  test 'save_mentions: reports are included in the mentioning_reports' do
    @alice_report.content = "aliceの日報でbobの日報を言及する http://localhost:3000/reports/#{@bob_report.id}"
    @alice_report.save!
    assert_includes @alice_report.mentioning_reports, @bob_report
  end

  test 'same mention relationship cannot be registered twice' do
    @alice_report.content = "aliceの日報でbobの日報を2回言及する。1回目の言及→http://localhost:3000/reports/#{@bob_report.id} 2回目の言及→http://localhost:3000/reports/#{@bob_report.id}"
    @alice_report.save!
    assert_equal 1, @alice_report.mentioning_reports.size
    assert_not_equal 2, @alice_report.mentioning_reports.size
  end

  test 'non-existent report is ignored' do
    @alice_report.content = 'aliceの日報で存在しない日報を言及する http://localhost:3000/reports/7777'
    @alice_report.save!
    assert_empty @alice_report.mentioning_reports
  end

  # 更新した際に言及内容も更新されることをテスト

  test 'mentioning_reports are correctly updated  when content changes' do
    @alice_report.content = "aliceの日報で、bobとcarolの日報を言及する。bobの日報に言及→http://localhost:3000/reports/#{@bob_report.id} carolの日報に言及→http://localhost:3000/reports/#{@carol_report.id}"
    @alice_report.save!

    assert_includes @alice_report.mentioning_reports, @bob_report
    assert_includes @alice_report.mentioning_reports, @carol_report

    # 更新内容: bobは残す（保持）、carolは削除、daveを追加
    @alice_report.content = "aliceの日報で、bobとdaveの日報を言及する。bobの日報に言及→http://localhost:3000/reports/#{@bob_report.id} daveの日報に言及→http://localhost:3000/reports/#{@dave_report.id}"
    @alice_report.save!
    @alice_report.reload

    assert_includes @alice_report.mentioning_reports, @bob_report
    assert_not_includes @alice_report.mentioning_reports, @carol_report
    assert_includes @alice_report.mentioning_reports, @dave_report
  end
end
