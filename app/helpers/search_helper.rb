module SearchHelper
  def extract_names(vals, join_char=' ')
    vals.collect { |c| c.name }.join(join_char)
  end

  def show_characters(characters, relationships)
    # categories.collect { |c| c.name }.join(join_char)

    unbound_characters = characters.collect { |c| c.name }
    bound_characters = relationships.flatten.collect { |c| c.name }

    # Remove characters that'll be formatted with pairing brackets
    unbound_characters.delete_if { |c| bound_characters.index(c) }

    # Colors for relationships
    colors = %w(primary danger warning success)

    formatted_relationships = relationships.collect do |relationship|
      color = colors.pop
      content_tag(:span, class: "text-#{color}") do
        [
          content_tag(:i, '', class: "fa fa-margin fa-angle-left"),
          extract_names(relationship, ', '),
          content_tag(:i, '', class: "fa fa-margin fa-angle-right")
        ].join.html_safe
      end.html_safe
    end

    (formatted_relationships + unbound_characters).join(', ')
  end

  def vote(thread_data)
    thread_data.votenum/thread_data.votetotal
  end

  def has_results?
    @search_results.hits > 0 && @search_results.results.size > 0
  end

  def included_text(excluded, item_type)
    "#{excluded ? 'Excluded' : 'Included'} #{item_type}"
  end
end
