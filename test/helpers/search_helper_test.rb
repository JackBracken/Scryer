require 'test_helper'
require 'hashie/mash'

class SearchHelperTest < ActionView::TestCase
  include SearchHelper

  test 'votes_divided' do
    puts vote(Hashie::Mash.new({:vote => 30, :votenum => 5}))
  end
end
