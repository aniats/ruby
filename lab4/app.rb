# frozen_string_literal: true

require 'roda'
require_relative 'models'

# The core class of the web application for managing your books
class App < Roda
  opts[:root] = __dir__
  plugin :environments
  plugin :render

  configure :development do
    plugin :public
    opts[:serve_static] = true
  end

  opts[:books] = BookList.new([
                                Book.new('Атлант расправил плечи', 'Айн Рэнд', '2020-05-01', '5', 'электронная книга', '12345', ''),
                                Book.new('Автостопом по галактике', 'Дуглас Адамс', '2020-01-01', '4', 'бумажная книга', '12345', ''),
                                Book.new('Финансист', 'Теодор Драйзер', '2019-12-31', '3', 'аудиокнига', '1:34:00', ''),
                                Book.new('Инноваторы', 'Уолтер Айзексон', '2018-08-22', '4', 'аудиокнига', '1:34:00', ''),
                                Book.new('Дурная кровь', 'Джон Каррейру', '2018-03-26', '4', 'бумажная книга', '12345', ''),
                                Book.new('Пересадочная станция', 'Клиффорд Саймак', '2018-01-01', '5', 'электронная книга', '12345', ''),
                                Book.new('Заповедник гоблинов', 'Клиффорд Саймак', '2018-11-27', '3', 'бумажная книга'),
                                Book.new('Прислуга', 'Кэтрин Стокетт', '2019-04-03', '5', 'электронная книга', '12345', '')
                              ])

  route do |r|
    r.public if opts[:serve_static]

    r.on 'main' do
      view('main')
    end

    r.on 'books' do
      @params = InputValidators.check_format(r.params['format'])
      @filtered_books = if @params[:errors].empty? && r.params['format'] != ''
                          opts[:books].filter_by_format(@params[:format])
                        else
                          opts[:books].filter_by_format_all
                        end
      view('books')
    end

    r.on 'new' do
      r.get do
        view('new_book')
      end

      r.post do
        @params = InputValidators.check_book(r.params['name'], r.params['author'], r.params['date'],
                                             r.params['mark'], r.params['format'], r.params['size'],
                                             r.params['description'])
        if @params[:errors].empty?
          opts[:books].add_book(Book.new(@params[:name], @params[:author], @params[:date],
                                         @params[:mark], @params[:format], @params[:size], @params[:description]))
          r.redirect '/books'
        else
          view('new_book')
        end
      end
    end

    r.on 'filter' do
      r.is do
        @params = InputValidators.check_year(r.params['year'])
        @filtered_books = if @params[:errors].empty? && r.params['year']
                            opts[:books].filter(@params[:year])
                          else
                            opts[:books].statistics_for_all_years
                          end
        @month = %w[Январь Февраль Март Апрель Май Июнь Июль Август Сентябрь Октябрь Ноябрь Декабрь]
        view('filter')
      end
    end
  end
end
