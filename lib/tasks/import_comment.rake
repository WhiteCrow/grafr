require 'roo'

task :import_comment => :environment do
  dir = Dir.open("#{Rails.root}/data/comments")
  dir.each do |fname|
    if fname.match(/xlsx$/)
      file = Roo::Spreadsheet.open("#{Rails.root}/data/comments/#{fname}")
      sheet = file.sheet(5)

      course_number = fname.split('.xlsx').first
      course = Course.find_by_number!(course_number)
      student_courses = course.student_courses.includes(:student)

      (2..sheet.last_row).each do |i|
        name = sheet.row(i)[0].delete(" ")
        comment = sheet.row(i)[2]

        begin
          student = Student.find_by_cn_name!(name)
        rescue
          puts '"' + name + '"'
          binding.pry
        end
        sc = student_courses.find_by(student_id: student.try(:id), course_id: course.id)
        sc.update!(comment: comment) if sc.present?
        puts "Comment: #{course_number} #{name}"
      end

    end
  end
end
