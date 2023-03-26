class ItemsController < ApplicationController
  # rescue_from and other before_action methods can be defined here
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    # logic for retrieving items goes here
    # render the response as JSON and include the user association
    items = Item.all
    if params[:user_id]
      user = User.find_by(id: params[:user_id])
      if !user
        return render json: {error: "User not found"}, status: :not_found
      end
      items = user.items
    end
    render json: items, include: :user
  end

  def show
    # logic for retrieving a single item goes here
    item = Item.find(params[:id]) # find the item
    render json: item # render the response
  end

  def create
    # logic for creating a new item goes here
    item = Item.create!(item_params) # create the item
    render json: item, status: :created # render the response
  end

  private
    # private methods go here, such as params filtering or error handling
    def render_not_found_response
      render json: { error: "Item not found" }, status: :not_found
    end

    def item_params
      params.permit(:name, :description, :price, :user_id)
    end
end
