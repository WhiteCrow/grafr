require 'roo'

task :import_course => :environment do
  file = Roo::Spreadsheet.open("#{Rails.root}/data/希悦-课程导入.xlsx")
  sheet = file.sheet(0)

  (2..sheet.last_row).each do |i|
    row = sheet.row(i)
    if Course.find_by_number(row[0]).blank?
      Course.create!(number: row[0], name: row[1], subject: row[2], period: row[8])
    end
  end

  puts "rows: #{sheet.last_row - 1}"
  puts "import count: #{Course.count}"
end
