class Expense < ActiveRecord::Base
  belongs_to :subcategory
  delegate :category, :category_label, to: :subcategory
  delegate :label                    , to: :subcategory, prefix: true

  def self.initialize_with_params(params)
    expense             = self.new
    expense.value       = params[:value]*100
    expense.date        = params[:date]

    category            = Category.find_or_initialize_by(label: params[:category], user_id: params[:user_id])

    expense.subcategory = category.subcategories.find_or_initialize_by(label: params[:subcategory])
    expense
  end

  def as_json(options = {})
    {
      value: value,
      date: date,
      category: category_label,
      subcategory: subcategory_label
    }
  end
end
