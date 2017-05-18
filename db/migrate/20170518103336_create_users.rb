class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :pass, :null => false
      t.string :token, :null => false

      t.timestamps
    end

    add_index :users, :name, :unique => true
  end
end
