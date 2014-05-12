class V1::CategoriesController < V1::ApplicationController
  def index
    respond_with Category.where(user_id: current_user['_id']).all
  end
end