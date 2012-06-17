# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  flunk "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Given /I checked the movies only of rating 'PG' or 'R'/ do
  check('ratings_PG')
  check('ratings_R')
  uncheck('ratings_PG-13')
  uncheck('ratings_G')
end

When /I click on sumbit/ do
  click_button('ratings_submit')
end

Then /I should see only 'PG' or 'R' rated movies/ do
 page.body.should match(/<td>R<\/td>/)
 page.body.should match(/<td>PG<\/td>/)
end

Then /I should not see movies of rating 'PG-13' or 'G'/ do
  page.body.should_not match(/<td>PG-13<\/td>/)
  page.body.should_not match(/<td>G<\/td>/)
end

Then /I should see an empty table/ do
  page.body.scan(/<tr>/).length.should == 0
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(' ').each do |r|
    uncheck == true ? uncheck(r) : check(r)
  end
end

Then /I should see all of the movies/ do
  len = page.body.scan(/<tr>/).length
  Movie.find(:all).length.should == len
end

When /I follow "Movie Title"/ do
  click_link('title_header')
end

Then /I should see "(.*)" before "(.*)"/ do |first, second|
  reg = Regexp.new "#{first}.*#{second}"
  page.body.should =~ reg
end

When /I follow "Release Date"/ do
  click_link('release_date_header')
end

