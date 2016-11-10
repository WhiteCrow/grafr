require 'roo'

task :import_student_course , [:arg] => :environment do |t, args|
  course_number = args[:arg]
  puts course_number
  file = Roo::Spreadsheet.open("#{Rails.root}/data/course/#{course_number || '201601G07CS001'}.xlsx")
  course_id = Course.find_by_number!(course_number).id
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
