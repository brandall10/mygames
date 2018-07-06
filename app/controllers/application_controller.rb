class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def gl_api
    @gl_api ||= GameLibrary.new
  end
end
