require 'scryer/scryer_client'

class HomeController < ApplicationController
  @@scryer = Scryer::Client.new

  def index

  end

  def search
    @search = params[:search]
    @search_results = @@scryer.search(@search)
    @results = Kaminari.paginate_array(@search_results.results, total_count: @search_results.hits).page(params[:page]).per(25)
  end
end
