class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :value
      t.date :date
      t.references :subcategory, index: true

      t.timestamps
    end
  end
end
