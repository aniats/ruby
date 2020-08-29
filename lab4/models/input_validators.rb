# frozen_string_literal: true

# Validators for the incoming requests
module InputValidators
  def self.check_year(raw_year)
    year = raw_year || ''
    errors = []
    if year != ''
      errors.concat(['Год должен быть в формате ГГГГ']) if year.size != 4
      errors.concat(['Только цифры допустимы']) unless /\d{4}/ =~ year
    end
    {
      year: year,
      errors: errors
    }
  end

  def self.check_format(raw_format)
    format = raw_format || ''
    errors = []
    if format != '' && format != 'бумажная книга' && format != 'электронная книга' && format != 'аудиокнига'
      errors.concat(['Формат чтения книги должен быть: бумажная книга/электронная книга/аудиокнига'])
    end
    {
      errors: errors,
      format: format
    }
  end

  def self.check_date_format(date)
    errors = []
    if /\d{4}-\d{2}-\d{2}/ =~ date
      errors.concat(['Месяц должен быть в диапозоне: 1..12']) if date[5..6].to_i > 12
      errors.concat(['В месяце не больше 31 дня']) if date[8..9].to_i > 31
      errors
    else
      ['Дата должна быть передана в формате ГГГГ-ММ-ДД']
    end
  end

  def self.check_audio(size)
    errors = []
    if /\d+:\d{2}:\d{2}/ =~ size
      split = size.split('/')
      errors.concat(['Часы - положительное число']) if split[0].to_i.negative?
      errors.concat(['Минуты в диапозоне 0..60']) if split[1].to_i.negative? || split[1].to_i > 59
      errors.concat(['Секунды в диапозоне 0..60']) if split[2].to_i.negative? || split[2].to_i > 59
      errors
    else
      ['Время должно быть в формате h:mm:ss']
    end
  end

  def self.check_format_size(format, size)
    size == size || ''
    errors = []
    if size == ''
      errors.concat(['Размер не задан'])
    else
      if format == 'бумажная книга' || format == 'электронная книга'
        if size.to_i.negative?
          errors.concat(['Число должно быть положительным'])
        end
      elsif format == 'аудиокнига'
        errors.concat(check_audio(size))
      end
    end
    errors
  end

  def self.check_mark(mark)
    errors = []
    if /\d+/ =~ mark
      if mark.to_i.negative? || mark.to_i > 100
        errors.concat(['Оценка в диапозоне 0..10'])
      end
    else
      errors.concat(['Оценка - положительное число 0..10'])
    end
    errors
  end

  def self.check_format_new(raw_format)
    format = raw_format || ''
    errors = []
    if format != '' && format != 'бумажная книга' && format != 'электронная книга' && format != 'аудиокнига'
      errors.concat(['Формат чтения книги должен быть: бумажная книга/электронная книга/аудиокнига'])
    end
    errors
  end

  def self.check_book(raw_name, raw_author, raw_date, 
                      raw_mark, raw_format, raw_size, raw_description)
    name = raw_name || ''
    author = raw_author || ''
    date = raw_date || ''
    format = raw_format || ''
    size = raw_size || ''
    mark = raw_mark || ''
    errors = [].concat(check_name(name))
               .concat(check_author(author))
               .concat(check_date(date))
               .concat(check_date_format(date))
               .concat(check_format_new(format))
               .concat(check_format_size(format, size))
               .concat(check_mark(mark))
    {
      name: name,
      author: author,
      date: date,
      format: format,
      mark: mark,
      size: size,
      description: raw_description,
      errors: errors
    }
  end

  def self.check_name(name)
    if name.empty?
      ['Название книги не может быть пустым']
    else
      []
    end
  end

  def self.check_author(author)
    if author.empty?
      ['Имя автора не может быть пустым']
    else
      []
    end
  end

  def self.check_date(date)
    if date.empty?
      ['Дата не может быть пустой']
    else
      []
    end
  end
end
