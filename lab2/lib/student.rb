# frozen_string_literal: true

# class Student
class Student
  attr_accessor :class_name, :name, :answers, :right_answers, :mark
  def initialize(class_name, name, answers)
    @class_name = class_name
    @name = name
    @answers = answers
    count_mark
  end

  def count_mark
    cnt_right = 0
    @answers.each do |val|
      cnt_right += 1 if val == 1
    end

    @right_answers = cnt_right

    @mark = 2 if cnt_right < 21

    @mark = 3 if cnt_right > 20 && cnt_right < 26

    @mark = 4 if cnt_right > 25 && cnt_right < 31

    @mark = 5 if cnt_right > 30
  end
end
