class AddUniqueUsersUidAndProvider < ActiveRecord::Migration[7.0]
  def change
    add_index :users, [:uid, :provider], unique: true
  end
end
