class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :label
      t.string :color
      t.references :category, index: true

      t.timestamps
    end
  end
end
