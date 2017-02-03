@students = [] # an empty array accessible to all methods
def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry #{filename} doesn't exist"
    exit
  end
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def input_students
    puts "Please enter the names of the students."
    puts "To finish, just hit return twice."
    # get the first name
    name = $stdin.gets.strip
    # while name is not empty, repeat this code
    while !name.empty? do
      @students << {name: name}
      count = @students.count
      if count == 1
        puts "We now have #{count} student."
      else count > 1
        puts "We now have #{count} students."
      end
      # get another name from the user
      name = $stdin.gets.strip
    end
    input_cohort
end

def interactive_menu
  loop do
    print_menu
    process($stdin.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit #This causes the programme to terminate
  else
    puts "I don't know what you meant, try again."
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def input_cohort
  @students.each do |student|
    puts "Please enter the cohort for #{student[:name]}"
    cohort = $stdin.gets.strip.capitalize
    puts "You entered #{cohort}, is this correct? If not enter the correct cohort:"
    check = $stdin.gets.chomp
    while check.empty?
      puts "Saved"
      student[:cohort] = cohort
      break
      if !check.empty?
        input_cohort
      end
    end
  end
end

# def input_cohort
#   @students.each do |student|
#     puts "Please enter the cohort for #{student[:name]}"
#     cohort = $stdin.gets.strip.capitalize
#
#     puts "You entered '#{cohort}', is this correct?"
#     puts "Enter Y for yes or N for no."
#     correct = $stdin.gets.strip.upcase
#
#     until (correct == 'Y' || correct == 'N')
#       puts "Enter Y for yes or N for no."
#       correct = $stdin.gets.strip.upcase
#     end
#     if correct == "Y"
#       student[:cohort] = cohort
#     else correct == "N"
#       puts "Please enter the cohort for #{student[:name]}"
#       cohort = $stdin.gets.strip.capitalize
#       student[:cohort] = cohort
#     end
#   end
# end

def jan_cohort
  puts "These are the students in the January cohort:"
  @students.select {|student| student[:cohort] == "Jan" || student[:cohort] == "January" }.each_with_index do |student, index|
    puts "#{index +1}. #{student[:name]} (#{student[:cohort]} cohort)".center(29)
  end
end

def student_information
  @students.each do |student|
    # Enter country information
    puts "Add additional information regarding your student: #{student[:name]}"
    puts "Enter country of birth:"
    country = $stdin.gets.strip.capitalize
    if country.empty?
      student[:country] = "None Entered"
    else
      student[:country] = country
    end
    # Enter Height information
    puts "Enter height (cm):"
    height = $stdin.gets.strip
    if height.empty?
      student[:height] = "None Entered"
    else
      student[:height] = height
    end
    # Enter hobbies information (Can only get it to work on one line :( )
    puts "Enter hobbies:"
    hobbies = $stdin.gets.strip
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

def search_letter
  puts "What letter do you want to search?"
  letter = $stdin.gets.strip.upcase
  puts "Here are the students that start with '#{letter}':"
  @students.each do |student|
    if (student[:name].start_with? letter)
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def short_name
  puts "-" * 10
  puts "These are our students with less than 12 characters in their name:"
  @students.each do |student|
    length = student[:name].length
    if length <= 12
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_students_list
  student_count = @students.count
  if student_count == 0
    puts "No students were inputted."
  else
    @students.each_with_index do |student, index|
      puts "#{index +1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_information
  @students.each do |student|
    puts "--------------------------".center(29)
    puts "#{student[:name]}".center(29)
    puts "Additional student information:"
    puts "Country: #{student[:country]}".center(29)
    puts "Height: #{student[:height]}".center(30)
    puts "Hobbies: #{student[:hobbies]}\n".center(31)
  end
end

def print_footer
  count = @students.count
  if count == 1
    puts "Overall, we have #{count} great student."
  elsif count == 0
    puts ''
  else count > 1
    puts "Overall, we have #{@students.count} great students."
  end
end

def save_students
  #open the file for writing
  file = File.open("students.csv", "w")
  #iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

interactive_menu
