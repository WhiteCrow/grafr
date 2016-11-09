require 'roo'

task :import_teacher_course_relation => :environment do
  file = Roo::Spreadsheet.open("#{Rails.root}/data/希悦-课程导入.xlsx")
  sheet = file.sheet(0)

  (2..sheet.last_row).each do |i|
    row = sheet.row(i)
    teacher_id = Teacher.find_by_number!(row[4]).id
    course_id = Course.find_by_number!(row[0]).id
    if TeacherCourse.find_by_teacher_id_and_course_id(teacher_id, course_id).blank?
      TeacherCourse.create!(teacher_id: teacher_id, course_id: course_id)
    end
  end

  puts "rows: #{sheet.last_row - 1}"
  puts "import count: #{TeacherCourse.count}"
end
