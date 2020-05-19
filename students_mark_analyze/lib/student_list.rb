# frozen_string_literal: true

require 'csv'

# class StudentList
class StudentList
  attr_reader :student_list
  def initialize
    @student_list = []
  end

  def stats
    classes = Hash.new(0)
    a7 = 0
    b7 = 0
    v7 = 0
    g7 = 0
    d7 = 0
    @student_list.each do |st|
      classes[st.class_name] += st.right_answers
      a7 += 1 if st.class_name == '7А'
      b7 += 1 if st.class_name == '7Б'
      v7 += 1 if st.class_name == '7В'
      g7 += 1 if st.class_name == '7Г'
      d7 += 1 if st.class_name == '7Д'
    end

    puts 'Результаты: '
    classes.each do |key, value|
      amount = 0
      amount = a7 if key == '7А'
      amount = b7 if key == '7Б'
      amount = v7 if key == '7В'
      amount = g7 if key == '7Г'
      amount = d7 if key == '7Д'
      puts "Класс: #{key} Средняя оценка: #{value / amount}"
    end
  end

  def print_all
    @student_list.each do |st|
      puts "Имя: #{st.name} Класс: #{st.class_name} Количество правильных ответов: #{st.right_answers}"
    end
  end

  def add(student)
    @student_list << student
  end

  def another_mark_system(for_3, for_4, for_5)
    @student_list.each do |st|
      cnt_right = st.right_answers
      st.mark = 2 if cnt_right < for_3

      st.mark = 3 if cnt_right >= for_3 && cnt_right < for_4

      st.mark = 4 if cnt_right >= for_4 && cnt_right < for_5

      st.mark = 5 if cnt_right >= for_5
    end

    find_mark(2)
    find_mark(3)
    find_mark(4)
    find_mark(5)
  end

  def find_mark(mark)
    res = []
    @student_list.each do |st|
      res << st if st.mark == mark
    end

    puts "Люди с оценкой #{mark}: "
    res.each do |st|
      puts "Имя: #{st.name} Класс: #{st.class_name} Количество правильных ответов: #{st.right_answers}"
    end
  end

  def process_file
    test = File.expand_path('../data/test_results.csv', __dir__)
    CSV.foreach(test, headers: false, encoding: 'utf-8') do |row|
      class_name = row[0]
      name = row[1]
      string_answers = row[2]
      answers = []
      string_answers.each_char { |c| answers << c.to_i }
      add(Student.new(class_name, name, answers))
    end
    @student_list
  end
end
