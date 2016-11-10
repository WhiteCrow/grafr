require 'roo'

task :import_course_score => :environment do
  puts ARGV[1]
  file = Roo::Spreadsheet.open("#{Rails.root}/data/course/#{ARGV[1] || '201601G07CS001'}.xlsx")
  course_id = Course.find_by_number!(ARGV[1]).id
  course_scores = CourseScore.all
  students = Student.all

  CourseScore::Categories.each do |category|
    sheet = file.sheet_for(category)
    column_count = sheet.row(2).count

    (2..sheet.last_row).each do |i|
      row = sheet.row(i)
      student_id = students.find_by_cn_name!(row[0]).id

      (1..(column_count - 2)).each do |index|
        # (1..44)
        value = row[1 + index]
        if course_scores.find_by(student_id: student_id, course_id: course_id, category: category, index: index).blank? && value.present?
          CourseScore.create!(student_id: student_id, course_id: course_id, category: category, value: value, index: index)
        end
      end
    end
    puts "#{category} number: #{(sheet.last_row - 1) * (column_count - 2)}"
    puts "import count: #{CourseScore.where(category: category, course_id: course_id).count}"

  end
end
