class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :title, null: false, default: ''
      t.string :url, null: false, unique: true
      t.string :short_url, null: false, default: ''
      t.integer :visites, null: false, default: 0

      t.timestamps
    end
  end
end
