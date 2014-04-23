class HomeController < ApplicationController
  before_action :require_signed_in!, except: [:home]
  def home
  end
end
