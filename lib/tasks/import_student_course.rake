require 'roo'

task :import_student_course => :environment do
  puts ARGV[1]
  file = Roo::Spreadsheet.open("#{Rails.root}/data/course/#{ARGV[1] || '201601G07CS001'}.xlsx")
  course_id = Course.find_by_number!(ARGV[1]).id
  students = Student.all

  sheet = file.sheet(0)
  (2..sheet.last_row).each do |i|
    row = sheet.row(i)
    student_id = students.find_by_cn_name!(row[0]).id
    if StudentCourse.find_by(student_id: student_id, course_id: course_id).blank?
      sc = StudentCourse.create!(student_id: student_id, course_id: course_id)
      puts sc.to_json
    end
  end

  puts "rows: #{sheet.last_row - 1}"
  puts "import count: #{StudentCourse.count}"
end
