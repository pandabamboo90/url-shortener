class CreateLinks < ActiveRecord::Migration[6.1]
  def change
    create_table :links do |t|
      t.text :url, null: false
      t.string :encoded_url, null: false, index: true

      t.timestamps
    end
  end
end
