require 'scryer/scryer_client'
require 'scryer/constant_options'

class SearchController < ApplicationController
  @@scryer = Scryer::Client.new

  def index
    @search = params[:search] || {}
  end

  def omni

  end

  def search
    @search = params[:search]
    @search['fandoms'] = [@search['fandom'], @search['crossovers']].flatten.find_all{|f| f && !f.empty?}
    @page = (params[:page] || '1').to_i
    @search_results = @@scryer.search(@search, (@page-1)*25, 25)
    @results = @search_results.results
    @paginate = Kaminari.paginate_array([], total_count: @search_results.hits).page(@page).per(25)
  end

  def characters
    @characters = @@scryer.union_characters(params[:fandom])

    respond_to do |format|
      format.json { render json: @characters }
    end
  end
end
