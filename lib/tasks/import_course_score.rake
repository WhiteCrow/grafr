require 'roo'

task :import_course_score, [:arg] => :environment do |t, args|
  course_number = args[:arg]
  puts course_number
  file = Roo::Spreadsheet.open("#{Rails.root}/data/course/#{course_number || '201601G07CS001'}.xlsx")
  course_id = Course.find_by_number!(course_number).id
  course_scores = CourseScore.all
  students = Student.all

  CourseScore::Categories.each do |category|
    sheet = file.sheet_for(category)
    column_count = sheet.row(2).count

    (2..sheet.last_row).each do |i|
      row = sheet.row(i)
      begin
        student_id = students.find_by_cn_name!(row[0]).id
      rescue
        puts row[0]
      end

      (1..(column_count - 2)).each do |index|
        # (1..44)
        value = row[1 + index]
        begin
          if course_scores.find_by(student_id: student_id, course_id: course_id, category: category, index: index).blank? && value.present?
            CourseScore.create!(student_id: student_id, course_id: course_id, category: category, value: value, index: index)
          end
        rescue
          puts row[0]
          binding.pry
        end
      end
    end
    puts "#{category} number: #{(sheet.last_row - 1) * (column_count - 2)}"
    puts "import count: #{CourseScore.where(category: category, course_id: course_id).count}"

  end
end
