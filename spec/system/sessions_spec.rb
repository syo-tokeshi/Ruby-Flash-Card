# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  let(:user) { FactoryBot.create(:user) }
  before do
    driven_by(:rack_test)
  end

  it 'ユーザーはログインすることができる' do
    login_as(user)
    expect(page).to have_content 'Github アカウントによる認証に成功しました。
'
  end

  it 'ユーザーはログアウトすることができる' do
    login_as(user)
    find('.user-icon').click
    click_on 'ログアウト'

    expect(page).to have_content 'ログアウトしました'
    expect(page).to have_content 'Rubyのメソッドを効率良く学びたくないですか？'
  end
  it 'ログインしていない場合、トップページにリダイレクトされる' do
    visit user_ruby_methods_path
    expect(page).to have_content 'Rubyのメソッドを効率良く学びたくないですか？'
  end
end
