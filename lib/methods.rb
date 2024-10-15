def display_list(list)
  list.each_with_index do |(gift, purchased), index|
    x_mark = purchased ? "X" : " "
    puts "#{index + 1} - [#{x_mark}] #{gift}"
    # puts "#{index + 1} - [#{purchased ? "X" : " "}] #{gift}"
  end
end
