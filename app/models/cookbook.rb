require 'csv'
require_relative 'recipe'
require 'pry'
class Cookbook
  attr_accessor :recipes

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    read_from_file
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    @recipes << recipe
    add_line_to_file(recipe.details)
  end

  def remove_recipe(recipe_index)
    @recipes.delete_at(recipe_index)
    update_file
  end

  def mark_complete(recipe_index)
    @recipes[recipe_index].done = true
    update_file
  end

  private

  def read_from_file
    @recipes = []
    CSV.foreach(@csv_file_path) do |row|
      @recipes.push(Recipe.new(*row))
    end
  end

  def add_line_to_file(details)
    CSV.open(@csv_file_path, "a") { |csv| csv << details }
  end

  def update_file
    CSV.open(@csv_file_path, "wb") do |csv|
      @recipes.each { |recipe| csv << recipe.details }
    end
  end
end
