class CreateFollows < ActiveRecord::Migration[5.1]
  def change
    create_table :follows do |t|
      t.references :user
      t.references :access_point

      t.timestamps
    end
    add_index :follows, [:user_id, :access_point_id], :unique => true
  end
end
