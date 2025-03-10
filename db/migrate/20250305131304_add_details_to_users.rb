class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :nickname, :string
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name_kana, :string
    add_column :users, :first_name_kana, :string
    add_column :users, :birth_date, :date, default: '2000-01-01' # デフォルト値を設定
  end
end
