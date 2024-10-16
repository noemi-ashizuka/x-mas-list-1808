require "csv"

def display_list(list)
  list.each_with_index do |(gift, purchased), index|
    x_mark = purchased ? "X" : " "
    puts "#{index + 1} - [#{x_mark}] #{gift}"
    # puts "#{index + 1} - [#{purchased ? "X" : " "}] #{gift}"
  end
end


# loads all the gifts from csv file and returns a hash
def load_csv(filepath)
  # iitialize an empty hash
  gift_list = {}
  # read each line of the csv file. 
  CSV.foreach(filepath, col_sep: ',', quote_char: '"', headers: :first_row) do |row|
    # p row => #<CSV::Row "name":"car" "purchased":"false"> the csv row object works like a hash, the headers are the keys
    # CSV can only store strings. row[purchased] is either the string true or false. If we compare it to the string true we can obtain an actual boolean
    purchased = row["purchased"] == 'true' # this gives us a boolean
    # we add our gift key value pair in the hash
    gift_list[row["name"]] = purchased
  end
  #  p gift_list
  # we return the hash
  gift_list
end

def save_csv(filepath, gift_list)
  CSV.open(filepath, 'wb', col_sep: ',', force_quotes: true, quote_char: '"') do |csv|
    # We had headers to the CSV
    csv << ['name', 'purchased']
    gift_list.each do |name, purchased|
      csv << [name, purchased]
    end
  end
end
