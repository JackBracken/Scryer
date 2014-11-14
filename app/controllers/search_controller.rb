require 'scryer/constant_options'
require 'hashie/mash'

class SearchController < ApplicationController
  before_filter :extract_search

  def index
    @fandom_list = Fandom.fandom_facets(224)
    @characters = if @fandoms.size > 1
      union_characters(@fandoms).collect do |c|
        Hashie::Mash.new(id: c.character_id, name:c.name)
      end
    else
      Character.where(:fandom_id => 224)
    end
  end

  def omni

  end

  def search
    @page = (params[:page] || '1').to_i
    @search_results = Search.perform_search(@search, @page, 25)
    @read_stories = PensieveEvent.where(story_id: (@search_results.results.map{|r| r.story_id})).map{|r2| r2.story_id}
  end

  def characters
    @characters = union_characters(params[:fandom])

    respond_to do |format|
      format.json { render json: @characters }
    end
  end

private

  def union_characters(fandoms)
    # Stable cache keys
    fandoms = fandoms.sort

    Rails.cache.fetch("fandom_character_union_#{fandoms}", :expires_in => 24.hours) do
      $scryer.union_characters(fandoms)
    end
  end

  def extract_search
    @search = params[:search]
    unless @search.is_a?(Hash)
      @search = {}
    end

    @fandoms = [@search['fandom'], @search['crossovers']].flatten.compact
    @search['crossovers'] = ([] << @search['crossovers']).flatten if @search['crossovers']
  end
end
