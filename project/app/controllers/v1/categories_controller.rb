class V1::CategoriesController < V1::ApplicationController
  def index
    respond_with Category.where(user_id: user_id).all
  end
end