# Put your step definitions here
Given /^a new game with (\d+) players$/ do |num_players|
  step("I run `greed #{num_players}` interactively")
end

Given /^it is player (\d+)'s turn$/ do |index|
  step("the output should contain \"Player #{index}'s turn\"")
end

Given /^the next roll is (.*)$/ do |roll|
  roll_array = roll.split(" ").map(&:to_i)
  @player.stub(:roll).and_return(roll_array)
end

When /^player (\d+) rolls$/ do |_|
  @player.roll
end

When /^player (\d+) elects to roll again$/ do |_|
  
end

When /^player (\d+) elects to not roll again$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
