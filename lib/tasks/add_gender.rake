require 'roo'

task :add_gender => :environment do
  file = Roo::Spreadsheet.open("#{Rails.root}/data/希悦-学生导入.xlsx")
  sheet = file.sheet(0)

  (2..sheet.last_row).each do |i|
    row = sheet.row(i)
    student = Student.find_by_number!(row[0])
    student.update!(gender: row[5])
  end

  puts "rows: #{sheet.last_row - 1}"
  puts "import count: #{Student.count}"
end
