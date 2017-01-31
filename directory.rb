def input_students
    puts "Please enter the names of the students."
    puts "To finish, just hit return twice."
    # create an empty array
    students = []
    # get the first name
    name = gets.chomp
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

def student_information(students)
  students.each do |student|
    # Enter country information
    puts "Add additional information regarding your student: #{student[:name]}"
    puts "Enter country of birth:"
    country = gets.chomp.capitalize
    if country.empty?
      student[:country] = "None Entered"
    else
      student[:country] = country
    end
    # Enter Height information
    puts "Enter height (cm):"
    height = gets.chomp
    if height.empty?
      student[:height] = "None Entered"
    else
      student[:height] = height
    end
    # Enter hobbies information (Can only get it to work on one line :( )
    puts "Enter hobbies:"
    hobbies = gets.chomp
    if hobbies.empty?
      student[:hobbies] = "None Entered"
    else
      student[:hobbies] = hobbies
    end
  end
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

def print_redo(students)
  count = 0
  while (count < 1)
    students.each_with_index do |student, index|
      puts "#{index +1}. #{student[:name]} (#{student[:cohort]} cohort)"
      puts "-" * 3
      puts "Additional student information:\nCountry: #{student[:country]}\nHeight: #{student[:height]}\nHobbies: #{student[:hobbies]}\n"
      count += 1
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students."
end
#nothing happens until we call the methods
students = input_students
student_information(students)

print_header
print_redo(students)
#short_name(students)
print_footer(students)
#search_letter(students)
