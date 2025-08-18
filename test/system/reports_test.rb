# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase

  setup do
    @alice = users(:one)
    @alice_report = reports(:one)
    login_as(@alice)
  end

  test "create a new report" do
    visit reports_path
    click_on "日報の新規作成"

    fill_report_form(title: "aliceの新しい日報", content: "この日報の作成者はaliceです")
    click_on "登録する"

    assert_text "日報が作成されました"
    assert_text "aliceの新しい日報"
    assert_text "この日報の作成者はaliceです"
  end

  test "update a report" do
    visit reports_path
    visit report_path(@alice_report)

    click_on "この日報を編集"

    fill_report_form(title: "aliceの日報のタイトルを変更します", content: "内容も変更します")
    click_on "更新する"

    assert_text "日報が更新されました。"
    assert_text "aliceの日報のタイトルを変更します"
    assert_text "内容も変更します"
  end

  test "destroy a report" do
    visit reports_path
    visit report_path(@alice_report)

    click_on "この日報を削除"

    assert_text "日報が削除されました"
    visit reports_path
    assert_no_text @alice_report.title
  end

  def login_as(user)
    visit root_path
    fill_in "Eメール", with: user.email
    fill_in "パスワード", with: "password"
    click_on "ログイン"
  end

  def fill_report_form(title:, content:)
    fill_in "タイトル", with: title
    fill_in "内容", with: content
  end
end
