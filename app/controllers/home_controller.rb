class HomeController < ApplicationController
  def index

  end

  def search
    @results = []
    @search = params[:search]
  end
end
