class ApplicationController < ActionController::Base
    include JwtService
    protect_from_forgery with: :null_session
  end