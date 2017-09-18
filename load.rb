require 'roo'
require 'roo-xls'
require './insert.rb'
require './call_history.rb'

#xls = Roo::Spreadsheet.open('./new_prices.xlsx')


#files = Dir.glob "#{folder}/*.xls"
#first_file = files[0]

def get_xls_files(folder_path)
  Dir.glob "#{folder_path}/*.{csv}"
end 

def get_file_path(file_name, folder_path)
  result = file_name
  if !(file_name.include? folder_path)
    result = "#{folder_path}/#{file_name}"
  end
  result
end 

def get_csv(file_name, folder_path)
  result = ''
  file_path = get_file_path(file_name, folder_path)
  if File.extname(file_name) == ".csv"
    file_stream = File.open file_path
    result = CSV.parse(file_stream.read, headers: true)
    file_stream.close
  else 
    book = Roo::Excel.new file_path, extension: :xls
    sheet1 = book.sheet(0)
    csv_str = sheet1.to_csv
    result = CSV.parse(csv_str, headers: true)
  end 
  result 
end 

def get_file_date(file_name, folder_path)
  file = File.open get_file_path(file_name, folder_path)
  result = file.birthtime.strftime('%Y-%m-%d')
  file.close
  result
end 

def get_records_from_file(file_name, folder_path)
  records = []
  csv = get_csv(file_name, folder_path)
  csv_file_createdate_str = get_file_date(file_name, folder_path)
  csv.each do |csv_row|
    record_hash = csv_row.to_hash
    # replace 'Today' string with actual file creation date 
    old_when = record_hash['When']
    record_hash['When'] = old_when.sub 'Today', csv_file_createdate_str
    records << Call_history.new(record_hash)
  end 
  records
end 

def import_records(conn, records)
  records.each do |record|
    res = insert_call_history(conn, record)
    puts "#{res.cmd_tuples()} rows inserted."
  end   
end 

test_file_name = 'tmp.xls'

folder_path = '../Data'
xls_files = get_xls_files(folder_path)
conn = PG::Connection.open(:dbname => 'restaurant')
xls_files.each do |xls_file|
  puts "--- processing file: #{xls_file} ----"
  records = get_records_from_file(xls_file, folder_path)
  import_records conn, records
  puts "--- end processing file: #{xls_file} ----"
end 