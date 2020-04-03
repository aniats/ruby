# frozen_string_literal: true

require 'tty-prompt'
require_relative 'my_complex'

def get_num(str)
  values = str.split()
  r = values[0].chomp().lstrip.rstrip.to_f
  c = values[1].chomp().lstrip.rstrip.to_f
  MyComplex.new(r, c)
end

puts 'Class for complex numbers with 4 basic arithmetic operations: add, sub, multiply, divide.'
prompt = TTY::Prompt.new
lhs = get_num(prompt.ask("Enter first complex number @real @imaginary > ", require: true))
rhs = get_num(prompt.ask("Enter second complex number @real @imaginary > ", require: true))
res = prompt.select('Choose operation: ', per_page: 4) do |menu|
  menu.choice '+'
  menu.choice '-'
  menu.choice '*' 
  menu.choice '/'
end

if res == '+'
  puts "Result: #{lhs.add(rhs)}"
elsif res == '*'
  puts "Result: #{lhs.multiply(rhs)}"
elsif res == '-'
  puts "Result: #{lhs.sub(rhs)}"
else
  puts "Result: #{lhs.divide(rhs)}"
end