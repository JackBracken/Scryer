require 'scryer/constant_options'
require 'hashie/mash'

class SearchController < ApplicationController
  before_filter :extract_search

  def index
    @fandom_list = Fandom.fandom_facets(224)
    @characters = if @fandoms.size > 1
      $scryer.union_characters(@fandoms).collect do |c|
        Hashie::Mash.new(id: c.character_id, name:c.name)
      end
    else
      Character.where(:fandom_id => 224)
    end
    puts @characters
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
