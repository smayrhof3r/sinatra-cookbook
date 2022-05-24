
class View
  def display(recipes)
    puts "  MY COOKBOOK ".center(50, "🟦")
    recipes.each_with_index do |recipe, i|
      print "🟦"
      print "#{recipe.done ? "✅" : "◻️ "} "
      print "#{i+1}: #{recipe.name}".ljust(30)
      print recipe.rating ? "  #{"💗" * recipe.rating.to_i}#{"🤍" * (5-recipe.rating.to_i)}  " : "  unrated  "
      print "#{recipe.prep_time}".ljust(10)
      print "'#{recipe.description}...'".ljust(25)
      puts "🟦"
    end
    puts "🟦" * 43
  end

  def request_recipe_details
    [recipe_("name"), recipe_("description"), recipe_("rating"), recipe_("prep time (eg. '20 min', '2 hrs')")]
  end

  def request_recipe_index
    print "Which recipe? >> "
    gets.chomp.to_i-1
  end

  private

  def recipe_(input)
    print "Recipe #{input} >> "
    gets.chomp
  end
end
