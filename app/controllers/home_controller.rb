require 'scryer/scryer_client'

class HomeController < ApplicationController
  @@scryer = Scryer::Client.new

  def index

  end

  def search
    @search = params[:search]
    @page = (params[:page] || '1').to_i
    @search_results = @@scryer.search(@search, (@page-1)*25, 25)
    @results = @search_results.results
    @paginate = Kaminari.paginate_array([], total_count: @search_results.hits).page(@page).per(25)
  end
end
