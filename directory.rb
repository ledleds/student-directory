@students = [] # an empty array accessible to all methods
require 'csv'
require 'Date'

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list from a file"
  puts "5. Add additional student information."
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    puts "Loading students..."
    show_students
  when "3"
    save_students
  when "4"
    puts "What file would you like to load?"
    user_file = gets.chomp.downcase
    load_students(user_file)
    puts "\n"
    show_students
    puts "\n"
  when "5"
    student_information
  when "9"
    puts "Exiting program"
    exit # This causes the program to terminate
  else
    puts "I don't know what you meant, try again."
  end
end

def input_students
  country = hobbies = height = "Not yet entered"
  puts "Please enter the names of the students."
  puts "To finish, just hit return twice."
  name = STDIN.gets.strip
  while !name.empty? do
    puts "Please enter their cohort:"
    cohort = STDIN.gets.strip.capitalize
    if cohort.empty? then cohort = "Jan" end
    Date::ABBR_MONTHNAMES.include? cohort ? cohort.to_sym : cohort = :default_cohort
    puts "We now have #{@students.count} student#{@students.count > 1 ? 's' : ''}."
    # the add to students method adds them to @students
    add_to_students(name, cohort, country, height, hobbies)
    puts "\n"
    puts "Enter a new name."
    puts "(To finish, just hit return)"
    name = STDIN.gets.strip
  end
end

def add_to_students(name, cohort, country, height, hobbies)
  @students << {name: name, cohort: cohort, country: country, height: height, hobbies: hobbies}
end

def show_students
  print_header
  print_student_list
  print_footer
end

def print_header
  puts "The Students of Villains Academy"
  puts "----------".center(30)
end

def print_student_list
  if @students.count == 0
    puts "No students were inputted."
  else
    @students.each_with_index do |student, index|
      puts "#{index +1}. #{student[:name]} (#{student[:cohort]} cohort)"
      puts "Additional information. Country of Birth: #{student[:country]}; Height: #{student[:height]}(cm); Hobbies: #{student[:hobbies]}."
    end
  end
end

def print_footer
  if @students.count >=1
    puts "Overall, we have #{@students.count} great student#{@students.count > 1 ? 's' : '' }."
  end
end

def save_students
  puts "What would you like to name your file? (Including file extension)"
  filename = STDIN.gets.chomp
  #opens up the filename given by the user, sets it to write permissions. Iterates over the file...
  CSV.open(filename, "w") do |file|
  # then iterates over @students and appends the values of the array into the csv file.
    @students.each do |students|
      file << students.values
    end
  end
  puts "#{filename} was saved."
end

def load_students(filename = "students.csv")
  @students = []
  CSV.open(filename, "r") do |file|
    file.to_a.map {|name, cohort, country, height, hobbies| add_to_students(name, cohort, country, height, hobbies)}
  end
  puts "Loading #{filename}"
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil?
    filename = "students.csv"
  end
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def jan_cohort
  puts "These are the students in the January cohort:"
  @students.select {|student| student[:cohort] == "Jan" || student[:cohort] == "January" }.each_with_index do |student, index|
    puts "#{index +1}. #{student[:name]} (#{student[:cohort]} cohort)".center(29)
  end
end

def student_information
  puts "Which student would you like to add information to. (Type A for all, or enter their name)"
  student_selection = STDIN.gets.chomp
  if student_selection == "A"
    @students.each do |student|
      # Enter country information
      puts "Add additional information regarding your student: #{student[:name]}"
      puts "Enter country of birth:"
      country = STDIN.gets.strip.capitalize
      student[:country] = country
      # Enter Height information
      puts "Enter height (cm):"
      height = STDIN.gets.strip
      student[:height] = height
      # Enter hobbies information (Can only get it to work on one line :( )
      puts "Enter hobbies:"
      hobbies = STDIN.gets.strip
      student[:hobbies] = hobbies
      end
  else @students.select do |student|
      if student[:name] == student_selection
        puts "Enter country of birth:"
        country = STDIN.gets.strip.to_sym
        student[:country] = country
        puts "Enter height (cm):"
        height = STDIN.gets.strip
        student[:height] = height
        puts "Enter hobbies:"
        hobbies = STDIN.gets.strip
        student[:hobbies] = hobbies
      end
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
    puts "Hobbies: #{student[:hobbies]}".center(31)
  end
end

def search_letter
  puts "What letter do you want to search?"
  letter = STDIN.gets.strip.upcase
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

try_load_students
interactive_menu
