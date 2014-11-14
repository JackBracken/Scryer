require 'scryer/constant_options'

class SearchController < ApplicationController
  before_filter :extract_search

  def index
    @fandom_list = Fandom.fandom_facets(224)
  end

  def omni

  end

  def search
    @page = (params[:page] || '1').to_i
    @search_results = $scryer.search(@search, (@page-1)*25, 25)
    @results = @search_results.results
    @paginate = Kaminari.paginate_array([], total_count: @search_results.hits).page(@page).per(25)
  end

  def characters
    @characters = $scryer.union_characters(params[:fandom])

    respond_to do |format|
      format.json { render json: @characters }
    end
  end

private

  def extract_search
    @search = params[:search]
    unless @search.is_a?(Hash)
      @search = {}
    end

    @fandoms = [@search['fandom'], @search['crossovers']].flatten.compact
    @search['crossovers'] = ([] << @search['crossovers']).flatten if @search['crossovers']
  end
end
