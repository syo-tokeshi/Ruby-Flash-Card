# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    subject(:normal_user) { create(:normal_user) }
    it { is_expected.to have_many(:user_methods).through(:user_ruby_methods).source(:ruby_method) }
    it { is_expected.to have_many(:user_ruby_methods).dependent(:destroy) }
    it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider).case_insensitive }
  end

  describe '#validations' do
    it 'ファクトリが有効であること' do
      expect(build(:normal_user)).to be_valid
    end
  end
end
