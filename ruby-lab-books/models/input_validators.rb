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

  def self.check_book(raw_name, raw_author, raw_date)
    name = raw_name || ''
    author = raw_author || ''
    date = raw_date || ''
    errors = [].concat(check_name(name))
               .concat(check_author(author))
               .concat(check_date(date))
               .concat(check_date_format(date))
    {
      name: name,
      author: author,
      date: date,
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
