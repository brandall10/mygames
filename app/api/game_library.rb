class GameLibrary
  API_VERSION = Rails.application.secrets.game_library[:api_version]
  HOST = Rails.application.secrets.game_library[:host] 
  BASE_URL = "#{HOST}/v#{API_VERSION}"

  def get_games(search_tag: '')
    conn.get('games', search_tag: search_tag)
  end

  def get_categories
    conn.get('categories')
  end

  def get_game(id)
    conn.get("games/#{id}")
  end

  def get_category(id)
    conn.get("categories/#{id}")
  end

  def add_category(name)
    conn.post('categories', name: name)
  end

  def add_game(category_id:, title:, description:nil, author:nil, status:nil)
    game_params = {
      category_id: category_id, 
      title: title, 
      description: description,
      author: author,
      status: status 
    }
    conn.post('games', game_params)
  end

  def update_game(id, category_id: :undef, title: :undef, description: :undef, author: :undef, status: :undef)
    game_params = {}
    game_params[:category_id] = category_id unless category_id == :undef
    game_params[:title] = title unless title == :undef
    game_params[:description] = description unless description == :undef
    game_params[:author] = author unless author == :undef
    game_params[:status] = status unless status == :undef

    conn.patch("games/#{id}", game_params)
  end

  def delete_game(id)
    conn.delete("games/#{id}")
  end

  def delete_category(id)
    conn.delete("categories/#{id}")
  end

  private
  def conn
    @conn ||= Faraday.new(url: BASE_URL) do |faraday|
      faraday.request  :json
      faraday.response :json
      faraday.adapter Faraday.default_adapter
    end
  end
end