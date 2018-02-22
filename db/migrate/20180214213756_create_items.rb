class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :sell_in
      t.integer :quality

      t.timestamps
    end
  end
end
