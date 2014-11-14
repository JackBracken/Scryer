class Search
  attr_reader :search, :results, :hits, :pagination

  def initialize(search_results, page, per_page)
    @search = search_results
    @page = page
    @per_page = per_page
    @results = @search.results
    @hits = @search.hits
    @pagination = Kaminari.paginate_array([], total_count: @hits).page(@page).per(@per_page)
  end

  def self.perform_search(search, page, per_page)
    search_results = $scryer.search(search, (page-1)*per_page, per_page)

    Search.new(search_results, page, per_page)
  end
end
