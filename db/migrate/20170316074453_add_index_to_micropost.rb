class AddIndexToMicropost < ActiveRecord::Migration[5.0]
  def change
  	add_index :microposts, [:user_id, :created_at]
  end
end
