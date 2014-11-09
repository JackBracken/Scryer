require 'scryer/scryer_client'

class SearchController < ApplicationController
  @@scryer = Scryer::Client.new
  def index

  end

  def omni

  end

  def search
    @search = params[:search]
    @search['fandoms'] = [@search['fandom'], @search['crossovers']].flatten.find_all{|f| !f.empty?}
    @page = (params[:page] || '1').to_i
    @search_results = @@scryer.search(@search, (@page-1)*25, 25)
    @results = @search_results.results
    @paginate = Kaminari.paginate_array([], total_count: @search_results.hits).page(@page).per(25)
  end
end
