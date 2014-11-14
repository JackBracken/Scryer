require 'scryer/constant_options'
require 'hashie/mash'

class SearchController < ApplicationController
  before_filter :extract_search

  def index
    @fandom_list = Fandom.fandom_facets(224)
    @characters = Character.for_fandoms(@fandoms)
  end

  def omni

  end

  def search
    @page = (params[:page] || '1').to_i
    @search_results = Search.perform_search(@search, @page, 25)
    @read_stories = PensieveEvent.where(story_id: (@search_results.results.map{|r| r.story_id})).map{|r2| r2.story_id}
  end

  def characters
    @characters = Character.for_fandoms(params[:fandom])

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
