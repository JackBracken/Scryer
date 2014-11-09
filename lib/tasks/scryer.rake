require 'json'
require 'scryer/scryer_client'

namespace :scryer do
  desc "Imports all data files"
  task :import => [:import_characters, :import_categories, :import_languages, :import_fandoms] do

  end

  desc "Imports character names from DLP API"
  task import_characters: :environment do
    client = Scryer::Client.new

    Character.delete_all

    client.characters.each do |c|
      c = Character.new(:id => c.character_id, :name => c.name, :fandom_id => c.fandom_id)
      c.save!
    end
  end

  desc "Imports fandoms from DLP API"
  task import_fandoms: :environment do
    client = Scryer::Client.new

    Fandom.delete_all

    client.fandoms.each do |f|
      fd = Fandom.new(:id => f.fandom_id, :name => f.name)
      fd.save!
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
