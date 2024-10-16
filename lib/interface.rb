# STEP 1 - The menu loop

# Welcome the user
# Ask the user which action [list|add|delete|quit]?
# Get the user input (action) and store it -> string
# Based on the user action, direct them to the correct message (don't code the action, just puts a message)
# Keep looping until the user types 'quit'

# STEP 2 - List
# Iterate over the gift_list to display the gifts (.each_with_index do |(key, value), index|)
# Format the text this way
  # 1 - [ ] sockets

# STEP 3 - Add
# Ask the user what they want to add
# Get the user answer and store it
# Add gift to the gift_list (CRUD Create: hash[new_key] = new_value)
# Display a message that the gift was added

# STEP 4 - Delete

# Display the list
# Ask the user the NUMBER of the item to delete
# index = Get user answer and store it
# Get the gift to delete somehow... (.keys)
# Delete the gift from the hash (CRUD DELETE: hash.delete(key))
# Let the user know we deleted the gift


# STEP 5 - Mark as bought

# Add a mark action
# Display list
# Ask user what to mark
# get user answer (index)
# Get the gift to delete somehow... (.keys)
# Change the value of the gift (CRUD Update hash[key] = new_value)
# Tell the user we marked the item

# STEP 6 - Import

# Ask what the user want to look for on Letsy
# Get user answer and store it (keyword)
# Scrape Letsy -> # make a method with the sraper
                  # pass the keyword to the method
                  # interpolate the keyword in the url
                  # return a hash that looks like the gift_list but instead with the gifts from letsy
# display the letsy hash using display_list
# index = Ask the user for a number to import
# Use .keys to get the gift too import from the lesty hash
# Add to our gift list
# Tell the user the gift was imported

require_relative "methods"
require_relative "scraper"

# path to the csv file
filepath = "gifts.csv"

gift_list = load_csv(filepath)

# Welcome the user
puts "****🎁****" * 3
puts "Welcome to the Christmas list"
puts "****🎁****" * 3

action = "anything but quit"
# loop starts
until action == "quit"
  # Ask the user which action [list|add|delete|quit]?
  puts "Which action? [list|add|delete|mark|idea|quit]"
  # Get the user input (action) and store it -> string
  action = gets.chomp
  # Based on the user action, direct them to the correct message (don't code the action, just puts a message)
  case action # thing we want to compare
  when "list"
    # Iterate over the gift_list to display the gifts (.each_with_index do |(key, value), index|)
    display_list(gift_list)
    # Format the text this way
      # 1 - [ ] sockets
  when "add"
    # Ask the user what they want to add
    puts "What do you want to add to the gift list?"
    # Get the user answer and store it
    gift = gets.chomp
    # Add gift to the gift_list (CRUD Create: hash[new_key] = new_value)
    gift_list[gift] = false
    # Display a message that the gift was added
    puts "#{gift.capitalize} was added."
    # call save csv to store our current gift_list status
    save_csv(filepath, gift_list)
  when "delete"
    # Display the list
    display_list(gift_list)
    # Ask the user the NUMBER of the item to delete
    puts "What gift number do you want to delete?"
    # index = Get user answer and store it
    index = gets.chomp.to_i - 1
    # Get the gift to delete somehow... (.keys)
    gift_array = gift_list.keys
    gift =  gift_array[index] # key
    # gift = gift_list.keys[index]
    # Delete the gift from the hash (CRUD DELETE: hash.delete(key))
    gift_list.delete(gift)
    # Let the user know we deleted the gift
    puts "#{gift.capitalize} was deleted."
    # call save csv to store our current gift_list status
    save_csv(filepath, gift_list)
    when "mark"
      # Display list
      display_list(gift_list)
      # Ask user what to mark
      puts "What number do you want to mark?"
      # get user answer (index)
      index = gets.chomp.to_i - 1
      # Get the gift to mark somehow... (.keys)
      gift_array = gift_list.keys
      gift =  gift_array[index] # key 
      # gift = gift_list.keys[index]
      # p gift_list[gift] # CRUD HASH READ hash[key] -> value
      
      # Change the value of the gift (CRUD Update hash[key] = new_value)
      # gift_list[gift] = gift_list[gift] ? false : true # true or false
      gift_list[gift] = !gift_list[gift]
      # Tell the user we marked the item
      puts "#{gift.capitalize} was updated."
      # call save csv to store our current gift_list status
      save_csv(filepath, gift_list)
  when "idea"
    # Ask what the user want to look for on Letsy
    puts "What do you want to search for on Letsy?"
    # Get user answer and store it (keyword)
    keyword = gets.chomp
    # check scraper.rb
    letsy_gifts = scrape(keyword) # hash from letsy
    # p letsy_gifts
    # display the letsy hash using display_list
    display_list(letsy_gifts)
    # index = Ask the user for a number to import
    puts "What number do you want to import to your gift list?"
    index = gets.chomp.to_i - 1
    # Use .keys to get the gift too import from the lesty hash
    gift = letsy_gifts.keys[index]
    # Add to our gift list
    gift_list[gift] = false
    # Tell the user the gift was imported
    puts "#{gift.capitalize} was imported to your gift list"
    # call save csv to store our current gift_list status
    save_csv(filepath, gift_list)
  when "quit"
    puts "Goodbye"
  else
    puts "Wrong action."
  end
  # Keep looping until the user types 'quit'
  # loop ends
end
