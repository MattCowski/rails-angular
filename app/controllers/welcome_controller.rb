# handle public requests and serve HTML
class WelcomeController < ApplicationController
	# run auth helper only on dashboard route
  before_filter :authenticate_user!, except: [:index]
  layout :choose_layout

  def index
  end

  def dashboard
  end

  def choose_layout
    user_signed_in? ? "angular" : "application"
  end
end
