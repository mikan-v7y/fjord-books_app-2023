# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase

  setup do
    @alice = users(:one)
    @alice_report = reports(:one)
  end

  def login_as(user)
    visit root_path
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: "alice137"
    click_on "ログイン"
  end

  test "create a new report" do
    login_as(@alice)

    visit reports_path
    click_on "日報の新規作成"

    fill_in "タイトル", with: "aliceの新しい日報"
    fill_in "内容", with: "この日報の作成者はaliceです"
    click_on "登録する"

    assert_text "日報が作成されました"
    assert_text "aliceの新しい日報"
    assert_text "この日報の作成者はaliceです"
  end

  test "update a report" do
    login_as(@alice)

    visit reports_path
    visit report_path(@alice_report)

    click_on "この日報を編集"

    fill_in "タイトル", with: "aliceの日報のタイトルを変更します"
    fill_in "内容", with: "内容も変更します"
    click_on "更新する"

    assert_text "日報が更新されました。"
    assert_text "aliceの日報のタイトルを変更します"
    assert_text "内容も変更します"
  end

  test "destroy a report" do
    login_as(@alice)

    visit reports_path
    visit report_path(@alice_report)

    click_on "この日報を削除"

    assert_text "日報が削除されました"
    visit reports_path
    assert_no_text @alice_report.title
  end

  # test 'visiting the index' do
  #   visit reports_url
  #   assert_selector 'h1', text: 'Reports'
  # end

  # test 'should create report' do
  #   visit reports_url
  #   click_on 'New report'

  #   fill_in 'Content', with: @report.content
  #   fill_in 'Title', with: @report.title
  #   fill_in 'User', with: @report.user_id
  #   click_on 'Create Report'

  #   assert_text 'Report was successfully created'
  #   click_on 'Back'
  # end

  # test 'should update Report' do
  #   visit report_url(@report)
  #   click_on 'Edit this report', match: :first

  #   fill_in 'Content', with: @report.content
  #   fill_in 'Title', with: @report.title
  #   fill_in 'User', with: @report.user_id
  #   click_on 'Update Report'

  #   assert_text 'Report was successfully updated'
  #   click_on 'Back'
  # end

  # test 'should destroy Report' do
  #   visit report_url(@report)
  #   click_on 'Destroy this report', match: :first

  #   assert_text 'Report was successfully destroyed'
  # end
end
