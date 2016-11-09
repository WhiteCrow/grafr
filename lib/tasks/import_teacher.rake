require 'roo'

task :import_teacher => :environment do
  file = Roo::Spreadsheet.open("#{Rails.root}/data/希悦-教师导入.xlsx")
  sheet = file.sheet(0)

  (2..sheet.last_row).each do |i|
    row = sheet.row(i)
    if Teacher.find_by_number(row[0]).blank?
      Teacher.create!(number: row[0], name: row[1], email: row[6], cn_name: row[8], en_name: row[9])
    end
  end

  puts "rows: #{sheet.last_row - 1}"
  puts "import count: #{Teacher.count}"
end
