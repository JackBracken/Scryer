module HomeHelper
  def extract_names(categories, join_char=' ')
    categories.collect { |c| c.name }.join(join_char)
  end
end
