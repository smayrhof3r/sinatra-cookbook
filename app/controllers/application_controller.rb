#require_relative '../views/view'
require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"

class ApplicationController < Sinatra::Base

  # def initialize
  #   binding.pry
  #   csv = '/home/sheila/code/smayrhof3r/sinatra-cookbook/app/models/recipes.csv'
  #   @cookbook = Cookbook.new(csv)
  #   super
  # end

  configure do
    set :views, "app/views"
    set :public_dir, "public"
  end

  # configure :development do
  #   use BetterErrors::Middleware
  #   BetterErrors.application_root = File.expand_path('..', __FILE__)
  # end

  get '/' do
    csv = '/home/sheila/code/smayrhof3r/sinatra-cookbook/app/models/recipes.csv'
    @@cookbook = Cookbook.new(csv)
    erb :index
  end

  get '/about' do
    erb :about
  end

  get '/action/list' do
    csv = '/home/sheila/code/smayrhof3r/sinatra-cookbook/app/models/recipes.csv'
    @recipes = @@cookbook.recipes
    erb :list
  end

  get '/action/create' do
    erb :create
  end

  get '/action/delete' do
    csv = '/home/sheila/code/smayrhof3r/sinatra-cookbook/app/models/recipes.csv'
    @recipes = @@cookbook.recipes
    erb :delete
  end

  get '/action/markdone' do
    csv = '/home/sheila/code/smayrhof3r/sinatra-cookbook/app/models/recipes.csv'
    @recipes = @@cookbook.recipes
    erb :markdone
  end

  get '/action/import' do
    @request_keyword = true
    erb :import
  end

  post '/action/importrecipe' do
    @request_id_to_import = true
    @@web_recipes = WebRecipe.new.load_recipes(params[:keyword])
    @recipes = @@web_recipes
    @dont_show_ticks = true
    erb :import
  end

  post '/action/createwebrecipe' do
    recipe = @@web_recipes[params[:id].to_i - 1]
    @@cookbook.add_recipe(recipe)
    redirect '/action/list'
  end

  post '/action/newrecipe' do
    name = params[:name]
    rating = params[:rating]
    prep_time = params[:prep_time]
    description = params[:description]
    recipe = Recipe.new(name, description, rating, prep_time)
    @@cookbook.add_recipe(recipe)
    redirect '/action/list'
  end

  post '/action/deleterecipe' do
    @@cookbook.remove_recipe(params[:id].to_i - 1)
    redirect '/action/list'
  end

  post '/action/updaterecipe' do
    @recipes = @@cookbook.all
    @recipes.each_with_index do |recipe, id|
      recipe.done = params[id.to_s] == "true"
    end
    @@cookbook.update_all(@recipes)
    redirect '/action/list'
  end
end



  # def create(recipe_details = nil)
  #   recipe_details ||= @view.request_recipe_details

  #   recipe = Recipe.new(*recipe_details)
  #   @cookbook.add_recipe(recipe)
  # end

  # def destroy
  #   list
  #   @cookbook.remove_recipe(@view.request_recipe_index)
  # end

  # def mark_done
  #   list
  #   @cookbook.mark_complete(@view.request_recipe_index)
  # end
