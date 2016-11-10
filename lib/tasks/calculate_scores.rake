require 'roo'

task :calculate_scores, [:arg] => :environment do |t, args|
  course_number = args[:arg]
  puts course_number
  course = Course.find_by_number!(course_number)
  student_courses = course.student_courses.includes(:student)
  student_courses.each do |sc|
    CourseScore::CategoriesDict.keys.each do |category|
      result = sc.recalculate(category)
      puts "#{course.number} #{sc.student.cn_name} #{category}: #{result}"
    end
    result = sc.update_total_score!
    puts "#{course.number} #{sc.student.cn_name} total score: #{result}"
  end
end
