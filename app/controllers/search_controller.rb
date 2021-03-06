require 'scryer/constant_options'
require 'hashie/mash'

class SearchController < ApplicationController
  before_filter :extract_search

  def index
    @characters = Character.for_fandoms(@fandoms)
    @fandom_facets = Fandom.fandom_facets(@fandoms)
  end

  def omni

  end

  def search
    if @search == {} || !@search
      redirect_to root_path, :alert => 'You must provide a valid search.'
      return
    end

    @page = (params[:page] || '1').to_i
    @search_results = Search.perform_search(@search, @page, 25)
    @read_stories = read_stories(@search_results)

    record_search
  end

  def click
    record_click(params[:event])
  end

  def crossovers
    @fandom_facets = Fandom.fandom_facets(params[:fandom])

    respond_to do |format|
      format.json { render json: @fandom_facets }
    end
  end

  def characters
    @characters = Character.for_fandoms(params[:fandom])

    respond_to do |format|
      format.json { render json: @characters }
    end
  end

private
  def record_search
    metadata = {ip: request.remote_ip, page: @page}
    if current_user
      metadata.merge!({user: {id: current_user.id, username: current_user.username}})
    end

    Keen.publish_async('search', @search.merge(metadata))
  rescue Keen::Error => e
    Rollbar.report_exception(e)
  end

  def record_click(event)
    Keen.publish('click', event)
  end

  def read_stories(search_results)
    result_story_ids = search_results.results.map{|r| r.story_id}

    PensieveEvent
      .where(story_id: result_story_ids)
      .pluck(:story_id)
  end

  def extract_search
    @search = params[:search]
    unless @search.is_a?(Hash)
      @search = {}
    end

    @fandoms = [@search['fandom'], @search['crossovers']].flatten.compact
    @search['crossovers'] = ([] << @search['crossovers']).flatten if @search['crossovers']

    if !@fandoms || @fandoms.empty?
      @fandoms = [224]
    end
  end
end
