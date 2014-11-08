module HomeHelper
  def extract_names(categories, join_char=' ')
    categories.collect { |c| c.name }.join(join_char)
  end

  def vote(thread_data)
    thread_data.votenum/thread_data.votetotal
  end

  def has_results?
    @search_results.hits > 0 && @results.size > 0
  end
end
