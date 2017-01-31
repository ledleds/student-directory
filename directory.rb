def input_students
    puts "Please enter the names of the students."
    puts "To finish, just hit return twice."
    # create an empty array
    students = []
    # get the first name
    name = gets.chomp.capitalize
    # while name is not empty, repeat this code
    while !name.empty? do
      students << {name: name, cohort: :november}
      puts "We now have #{students.count} students."
      # get another name from the user
      name = gets.chomp.capitalize
    end
    # return array of students
    students
end

def print_header
  puts "The students of Villans Academy"
  puts "----------"
end

def search_letter(students)
  puts "What letter do you want to search?"
  letter = gets.chomp.upcase
  puts "Here are the students that start with '#{letter}':"
  students.each do |student|
    if (student[:name].start_with? letter)
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def short_name(students)
  puts "-" * 10
  puts "These are our students with less than 12 characters in their name:"
  students.each do |student|
    length = student[:name].length
    if length <= 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print(students)
   students.each_with_index do |student, index|
     puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
   end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students."
end
#nothing happens until we call the methods
students = input_students
print_header
#print(students)
short_name(students)
print_footer(students)
#search_letter(students)
