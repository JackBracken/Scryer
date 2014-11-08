require 'scryer/scryer_client'

class HomeController < ApplicationController
  @@scryer = Scryer::Client.new

  def index

  end

  def search
    @search = params[:search]
    @search_results = @@scryer.search(@search)
    @results = @search_results.results
    puts @results
  end
end
