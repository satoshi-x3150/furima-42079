class AddNotNullToBirthDate < ActiveRecord::Migration[7.1]
  def change
    change_column_null :users, :birth_date, false
  end
end

