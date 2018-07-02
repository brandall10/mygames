class Api::GameLibrary
  API_VERSION = Rails.application.secrets.game_library[:api_version]
  HOST = Rails.application.secrets.game_library[:host] 
  BASE_URL = "#{HOST}/v#{API_VERSION}"

  def get_games
    response = conn.get('games')
    response.body
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