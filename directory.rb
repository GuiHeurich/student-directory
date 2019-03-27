@students = []

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #get the firts name
  name = gets.chomp
  #get the cohort
  puts "In which cohort is this student?"
  cohort = gets.chomp
  #while the name is not empty, repeat this code
  while !name.empty? do
    #add the student hash to the array
    @students << {cohort: cohort, name: name}
    puts "Now we have #{@students.count} student" if @students.count == 1
    puts "Now we have #{@students.count} students" if @students.count > 1
    #get another name from the user
    name = gets.chomp
    #and the cohort
    cohort = gets.chomp
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
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
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
    when "9"
      exit
    else
      puts "I don't know what you mean, try again"
  end
end
# nothing happens until we call the methods
interactive_menu
