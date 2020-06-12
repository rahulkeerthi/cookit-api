require 'csv'

files = 'db/data/*.csv'
csv_path = 'db/data/restaurants.csv'
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row, header_converters: :symbol }

# files.each do |file|
  data = CSV.foreach(csv_path, **csv_options) do |row|
    puts row[:name]
  end
# end

