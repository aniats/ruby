require "erb"

# Класс для предоставления данных в шаблон
class Product
  def initialize(code, name, desc, cost)
    @code = code
    @name = name
    @desc = desc
    @cost = cost
    @features = []
  end

  def add_feature(feature)
    @features << feature
  end

  # Получение доступа к контексту объекта
  def get_binding
    binding
  end
end

# Описываем шаблон
template = <<~TEMPLATE
  <!DOCTYPE html>
  <html>
    <head><title>Магазин игрушек -- <%= @name %></title></head>
    <body>

      <h1><%= @name %> (<%= @code %>)</h1>
      <p><%= @desc %></p>

      <ul>
        <% @features.each do |f| %>
          <li><b><%= f %></b></li>
        <% end %>
      </ul>

      <p>
        <% if @cost < 10 %>
          <b>Всего <%= @cost %>!!!</b>
        <% else %>
           Свяжитесь с нами, чтобы узнать цену!
        <% end %>
      </p>
    </body>
  </html>
TEMPLATE

# Создаём шаблонизатор и передаём ему шаблон для работы
rhtml = ERB.new(template)

# Заполняем объект с данными для отображения
toy = Product.new("TZ-1002",
                  "Ruby-мыслящий",
                  "Лучший друг программсита! Понимает команды на Ruby...",
                  999.95)
toy.add_feature("Понимает голосовые команды на языке Ruby!")
toy.add_feature("Игнорирует запросы на Perl, Java и всех вариантах языка Си")
toy.add_feature("Знает карате!")
toy.add_feature("Личная подпись Matz на левой ноге!")
toy.add_feature("Глаза инкрустированы драгоценными камнями... Рубинами, конечно!")

# Формируем результат
rhtml.run(toy.get_binding)
