# frozen_string_literal: true

require 'tty-prompt'
require_relative 'student_list.rb'
require_relative 'student'

# class Solution
class Solution
  def initialize
    @prompt = TTY::Prompt.new
    @students = StudentList.new
    @students.process_file
  end

  MAIN_MENU_CHOICES = [
    { name: 'Вывести всех школьников', value: :all_students },
    { name: 'Пересчет оценок и вывод в соответствии',
      value: :new_marks },
    { name: 'Показать двоечников',
      value: :bad_students },
    { name: 'Статистика по классам',
      value: :stats },
    { name: 'Завершить работу приложения', value: :exit }
  ].freeze

  def show_menu
    loop do
      action = @prompt.select('Выберите действие', MAIN_MENU_CHOICES)
      break if action == :exit

      show_all_students if action == :all_students
      show_bad_students if action == :bad_students
      show_marks if action == :new_marks
      show_statistics if action == :stats
    end
  end

  def show_statistics
    @students.stats
  end

  def show_all_students
    @students.print_all
  end

  def show_bad_students
    @students.find_mark(2)
  end

  def show_marks
    print 'Введите 3 новые границы для 3, 4, 5 > '
    string = gets
    string = string.split(' ')
    num3 = string[0].chomp.strip.to_i
    num4 = string[1].chomp.strip.to_i
    num5 = string[2].chomp.strip.to_i
    @students.another_mark_system(num3, num4, num5)
  end
end
