class GamesController < ApplicationController
  def index
    response = gl_api.get_games(search_tag: params[:search_tag])

    if response.status == 200
      @games = response.body
    else
      redirect_to redirect_url, notice: 'Can not view games'
    end
  end

  def show
    response = gl_api.get_game(params[:id])

    if response.status == 200
      @game = response.body
    else
      redirect_to redirect_url, notice: 'Game not found'
    end
  end

  def edit
    response = gl_api.get_game(params[:id])

    if response.status == 200
      @game = response.body
    else
      redirect_to redirect_url, notice: 'Game not found'
    end
  end

  def create
    game_params = {
      category_id: params[:category_id],
      title: params[:title],
      description: params[:description],
      author: params[:author],
      status: params[:status]
    }
    response = gl_api.add_game(game_params)

    if response.status == 201
      redirect_to redirect_url, notice: 'Game was successfully created'
    else
      redirect_to redirect_url, notice: response.body.join(', ')
    end
  end

  def update 
    game_params = {
      category_id: params[:category_id],
      title: params[:title],
      description: params[:description],
      author: params[:author],
      status: params[:status]
    }
    response = gl_api.update_game(params[:id], game_params)

    if response.status == 200
      redirect_to redirect_url, notice: 'Game was successfully updated'
    else
      redirect_to redirect_url, notice: response.body.join(', ')
    end
  end

  def destroy
    response = gl_api.delete_game(params[:id])

    if response.status == 204
      redirect_to redirect_url, notice: 'Game was successfully destroyed.'
    else
      redirect_to redirect_url, notice: response.body.join(', ')
    end
  end

  private
  def redirect_url
    params[:category_id] ? category_url(id: params[:category_id]) : root_url
  end
end