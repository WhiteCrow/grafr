require 'roo'

task :import_course_score => :environment do
  file = Roo::Spreadsheet.open("#{Rails.root}/data/201601G07CS001.xlsx")
  course_id = Course.find_by_number!("201601G07CS001").id
  course_scores = CourseScore.where(category: "Attendence")
  students = Student.all

  sheets = {}
  CourseScore::Categories.each do |category|
    sheets[category] = file.sheet_for(category)
  end

  sheet = sheets["Attendence"]
  column_count = sheet.row(2).count

  (2..sheet.last_row).each do |i|
    row = sheet.row(i)
    student_id = students.find_by_cn_name!(row[0]).id

    (1..(column_count - 2)).each do |index|
      # (1..44)
      value = row[1 + index]
      if course_scores.find_by(student_id: student_id, course_id: course_id, category: "Attendence", index: index).blank? && value.present?
        cs = CourseScore.create!(student_id: student_id, course_id: course_id, category: "Attendence", value: value, index: index)
        puts cs.to_json
      end
    end
  end

  puts "Attendence number: #{(sheet.last_row - 1) * (column_count - 2)}"
  puts "import count: #{CourseScore.count}"
end
