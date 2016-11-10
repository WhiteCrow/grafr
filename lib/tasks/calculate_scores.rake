require 'roo'

task :calculate_scorces => :environment do
  puts ARGV[1]
  course = Course.find_by_number!(ARGV[1])
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
