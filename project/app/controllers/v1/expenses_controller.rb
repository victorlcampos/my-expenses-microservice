class V1::ExpensesController < V1::ApplicationController
  def create
    params[:user_id] = current_user['_id']

    expense = Expense.initialize_with_params(params.permit(:value, :date, :category, :subcategory, :user_id))
    expense.save!

    respond_with expense, status: 201, location: v1_expense_path(expense)
  end

  def show
    raise params.inspect
    respond_with Expense.find(params[:id])
  end
end
