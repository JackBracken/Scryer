module Scryer
  class ConstantOptions
    ORDERING = {'Descending' => 'desc', 'Ascending' => 'asc'}
    SORTING = {
      'Best Match' => '_score',
      'Updated' => 'updated',
      'Published' => 'published',
      'Wordcount' => 'meta.words',
      'Reviews' => 'meta.reviews',
      'Favorites' => 'meta.favs',
      'Follows' => 'meta.follows',
      'DLP Review Score' => '_dlp',
      #'Popular & Recent' => '_popular',
      #'Flesch Index (Reading level)' => '_flesch',
      'Chapters' => 'meta.chapters'
    }
    RATING = {
      'K' => 'k',
      'K+' => 'k+',
      'T' => 'T',
      'M' => 'M',
    }
    STATUS = {
      '' => '',
      'Completed' => 'complete',
      'Hiatus' => 'hiatus',
      'In-Progress' => 'progress'
    }
  end
end
