require 'roo'

task :import_student => :environment do
  file = Roo::Spreadsheet.open("#{Rails.root}/data/希悦-学生导入.xlsx")
  sheet = file.sheet(0)

  (2..sheet.last_row).each do |i|
    row = sheet.row(i)
    if Student.find_by_number(row[0]).blank?
      Student.create!(number: row[0], cn_name: row[1], en_name: row[12], grade: row[13])
    end
  end

  puts "rows: #{sheet.last_row - 1}"
  puts "import count: #{Student.count}"
end
