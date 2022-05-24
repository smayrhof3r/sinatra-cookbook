class Recipe
  attr_reader :name, :description, :rating, :prep_time
  attr_accessor :done

  def initialize(name, description, rating, prep_time = 0, done = false)
    @name = name
    @description = description
    @rating = rating
    @done = (done == "true")
    @prep_time = prep_time
  end

  def details
    [@name, @description, @rating, @prep_time, @done]
  end
end
