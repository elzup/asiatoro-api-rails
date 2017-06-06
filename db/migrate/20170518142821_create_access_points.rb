class CreateAccessPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :access_points do |t|
      t.string :ssid, :null => false

      t.timestamps
    end

    add_index :access_points, :ssid, :unique => true
  end
end
