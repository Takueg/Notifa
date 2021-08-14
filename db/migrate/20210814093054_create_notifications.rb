class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.boolean :is_sent
      t.references :post, null: false, foreign_key: true
      t.references :search, null: false, foreign_key: true

      t.timestamps
    end
  end
end
