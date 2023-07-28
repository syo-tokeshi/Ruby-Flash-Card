# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UserRubyMethods', type: :system do
  let!(:user) { create(:user) }
  let!(:user_zip_method) { create(:user_zip_method, { user: }) }

  before do
    login_as(user)
    visit user_ruby_methods_path
  end

  context '正しい条件の場合' do
    it '学習の進捗で絞り込みを行うことができる' do
      choose '分からなかった'
      click_on '検索'
      expect(page).to have_content 'zip'
      expect(page).to have_content 'レシーバーのインデックス番号に合わせて引数の配列を合体させて、配列を作成する'
    end
    it 'モジュール名で検索をすることができる' do
      choose 'Array'
      click_on '検索'
      expect(page).to have_content 'zip'
      expect(page).to have_content 'レシーバーのインデックス番号に合わせて引数の配列を合体させて、配列を作成する'
    end
  end

  context '正しくない条件の場合' do
    it '学習の進捗とモジュール名が間違っていると検索できないこと' do
      choose '分かっていた'
      choose 'Array'
      click_on '検索'
      expect(page).to_not have_content 'zip'
    end
  end

  it 'ユーザーはメソッドを編集できること' do
    expect(page).to have_selector '.method-item', text: 'zip'
    click_on '編集'
    fill_in 'メモ', with: 'メモを変更しました'
    click_on '更新する'
    expect(page).to have_content '更新が完了しました😊'
  end

  it '公式サイトにアクセスできるリンクがあること' do
    expect(page).to have_selector '.method-item', text: 'zip'
    expect(page).to have_link 'zip', href: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/zip.html'
  end

  it '分かっていた or 分からなかった、のラベルが表示されること' do
    expect(page).to have_selector '.method-item', text: 'zip'
    expect(page).to have_content '分からなかった'
  end
end
