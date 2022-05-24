class ParseView

  def request_keyword
    print "what keyword would you like to search? >> "
    gets.chomp
  end

  def display(recipes)
    recipes.each_with_index do |recipe, i|
      print "#{i + 1}: #{recipe[0].ljust(30 - i/10)} "
      print ": #{"💗" * recipe[2].to_i}#{"🤍" * (5-recipe[2].to_i)} "
      print ": #{recipe[3]}".ljust(10)
      puts ": '#{recipe[1]}...'"
    end
  end

  def request_recipe_index
    print "Which recipe? >> "
    gets.chomp.to_i - 1
  end
end
