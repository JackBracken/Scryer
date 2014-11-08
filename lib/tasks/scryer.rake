require 'json'

namespace :scryer do
  desc "Imports character names from JSON file"
  task import_characters: :environment do
    JSON.parse(File.open('data/characters.json').read).each do |c|
      c = Character.new c
      c.save!
    end
  end

  desc "Imports categories from JSON fixture"
  task import_categories: :environment do
    JSON.parse(File.open('data/categories.json').read).each do |c|
      c = Category.new c
      c.save!
    end
  end

  desc "Imports languages from JSON fixture"
  task import_languages: :environment do
    JSON.parse(File.open('data/languages.json').read).each do |l|
      c = Language.new :name => l
      c.save!
    end
  end

end
