class CategoriesController < ApplicationController
  def index
    games_library_api = Api::GameLibrary.new
    @categories = games_library_api.get_categories
  end

  def show
  end
end