class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.string :text, null: false
      t.string :slug, null: false, index: true

      t.timestamps
    end
  end
end
