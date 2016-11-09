require 'roo'

task :import_score_weight => :environment do
  file = Roo::Spreadsheet.open("#{Rails.root}/data/希悦-课程评分权重.xlsx")
  sheet = file.sheet(0)

  (2..sheet.last_row).each do |i|
    row = sheet.row(i)
    if ScoreWeight.find_by_course_number(row[0]).blank?
      ScoreWeight.create!(course_number: row[0], attendence: row[1], class_performance: row[2], homework: row[3], quiz: row[4], mid_term: row[5], final_term: row[6])
    end
  end

  puts "rows: #{sheet.last_row - 1}"
  puts "import count: #{ScoreWeight.count}"
end
