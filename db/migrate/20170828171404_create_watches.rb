class CreateWatches < ActiveRecord::Migration[5.1]
  def change
    create_table :watches do |t|
      t.references :source, foreign_key: true
      t.references :target, foreign_key: true
      t.references :access_point, foreign_key: true

      t.timestamps
    end
    add_foreign_key :watches, :users, column: :source_id
    add_foreign_key :watches, :users, column: :target_id
  end
end
