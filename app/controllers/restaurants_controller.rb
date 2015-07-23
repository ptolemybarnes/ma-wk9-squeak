class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.create(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :stars, :description)
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    unless current_user.restaurants.find_by id: @restaurant.id
      flash.notice ="Error: You must be the author to edit a restaurant"  
      redirect_to restaurants_path
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)

    redirect_to '/restaurants'
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.destroy_as current_user
      flash[:notice] = 'Restaurant deleted successfully'
    else
      flash.notice = "Error: you are not the author of the entry for #{@restaurant.name}"
    end
    redirect_to restaurants_path
  end

end
