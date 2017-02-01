def input_students
    puts "Please enter the names of the students."
    puts "To finish, just hit return twice."
    # create an empty array
    students = []
    # get the first name
    name = gets.chomp
    # while name is not empty, repeat this code
    while !name.empty? do
      students << {name: name}
      count = students.count
      if count == 1
        puts "We now have #{students.count} student."
      else count > 1
        puts "We now have #{students.count} students."
      end
      # get another name from the user
      name = gets.chomp.capitalize
    end
    # return array of students
    students
end

def input_cohort(students)
  students.each do |student|
    puts "Please enter the cohort for #{student[:name]}"
    cohort = gets.chomp.capitalize

    puts "You entered '#{cohort}', is this correct?"
    puts "Enter Y for yes or N for no."
    correct = gets.chomp.upcase

    until (correct == 'Y' || correct == 'N')
      puts "Enter Y for yes or N for no."
      correct = gets.chomp.upcase
    end
    if correct == "Y"
      student[:cohort] = cohort
    else correct == "N"
      puts "Please enter the cohort for #{student[:name]}"
      cohort = gets.chomp.capitalize
      student[:cohort] = cohort
    end
  end
end

def jan_cohort(students)
  puts "These are the students in the January cohort:"
  students.select {|student| student[:cohort] == "Jan" || student[:cohort] == "January" }.each_with_index do |student, index|
    puts "#{index +1}. #{student[:name]} (#{student[:cohort]} cohort)".center(29)
  end
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
      puts "--------------------------".center(29)
      puts "Additional student information:"
      puts "Country: #{student[:country]}".center(29)
      puts "Height: #{student[:height]}".center(30)
      puts "Hobbies: #{student[:hobbies]}\n".center(31)
      count += 1
    end
  end
end

def print_footer(students)
  count = students.count
  if count == 1
    puts "Overall, we have #{count} great student."
  else count > 1
    puts "Overall, we have #{students.count} great students."
  end
end

students = input_students
input_cohort(students)
#student_information(students)
print_header
jan_cohort(students)
#print_redo(students)
print_footer(students)
