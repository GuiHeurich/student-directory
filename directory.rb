require 'csv'
@students = []

def try_load_students
    puts "Hello, which file would you like to load:"
    filename = gets.chomp
    load_students(filename)
end

def interactive_menu
  loop do
    print_menu
    menu_input(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list"
  puts "4. Load the list"
  puts "9. Exit"
end

def menu_input(selection)
  case selection
  when "1" then input_students
  when "2" then show_students
  when "3" then save_students
  when "4" then load_students
  when "9" then exit
  else puts "I don't know what you mean, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  puts "In which cohort is this student?"
  cohort = STDIN.gets.chomp
  while !name.empty? do
    add_student(name, cohort)
    puts "\nNow we have #{@students.count} students\n".center(40)
    name = STDIN.gets.chomp
    cohort = STDIN.gets.chomp
      if cohort.empty?
        cohort = "unknown"
      end
  end
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts "The students of Villains Academy".center(40)
  puts "--------_-_-_-_---------\n".center(40)
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
  puts "Overall, we have #{@students.count} great students".center(40)
end

def save_students
  puts "Tell me in which file to save:"
  filename = gets.chomp
  CSV.open(filename, "w") do |csv|
    @students.each do |student|
      csv << [student[:name], student[:cohort]]
    end
  puts "\nSaved #{@students.count} students to #{filename}!\n".center(40)
  end
end

def load_students(filename = "students.csv")
  CSV.foreach(filename) do |row|
    name, cohort = row
    add_student(name, cohort)
    end
  puts "Sucessfully loaded #{@students.count} from #{filename}".center(60)
end

try_load_students
interactive_menu
