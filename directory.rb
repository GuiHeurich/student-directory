@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #get the firts name
  name = STDIN.gets.chomp
  #get the cohort
  puts "In which cohort is this student?"
  cohort = STDIN.gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    @students << {cohort: cohort, name: name}
    puts "Now we have #{@students.count} student" if @students.count == 1
    puts "Now we have #{@students.count} students" if @students.count > 1
    #get another name from the user
    name = STDIN.gets.chomp
    #and the cohort
    cohort = STDIN.gets.chomp
    #supply default value
      if cohort.empty?
        cohort = "unknown"
      end
  end
end

def print_header
  puts "The students of Villains Academy".center(40)
  puts "--------_-_-_-_---------".center(40)
end

def print_students_list
  if @students.empty?
    return
  else
  @students.map { |s| s[:cohort] }.
    uniq.
    each { |c| puts "#{c} cohort students are #{@students.
                                                  find_all { |s| s[:cohort] == c }.
                                                  map { |s| s[:name] }.
                                                  join(', ')}" }
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end

def show_students
  print_header
  print_students_list
  print_footer
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
      exit
    else
      puts "I don't know what you mean, try again"
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

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
  name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def try_load_students
  filename = ARGV.first #first argument from the command line
  return if filename.nil? #get out of the method if it isn't given
  if File.exists?(filename) #if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else #if it doesn't exist
    puts "Sorry #{filename} doesn't exist."
    exit
  end
end

# nothing happens until we call the methods
try_load_students
interactive_menu
