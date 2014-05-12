class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :label
      t.string :color
      t.integer :user_id

      t.timestamps
    end
  end
end