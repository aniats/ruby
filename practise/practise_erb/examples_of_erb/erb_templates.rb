require 'erb'

def hello_stranger(name, surname)
  puts ERB.new('Hello, <%= name%> <%= surname %>').result(binding)
end

def invitation(name_event, name, text, host_name)
  message = 'Dear <%= name %>, you are invited to <%= name_event%>
  <%= text %>
  Your lovely, <%= host_name %>'
  puts ERB.new(message).result(binding)
end

def online_shop(product_name, cost, category)
  message = '
  Buy amazing<% if category == :dress %> dress<% end %><% if category == :shoes%> shoes<% end %><% if category == :tools%> instrument<% end %>!
  Name: <%= product_name %>
  Its just <%= cost %>$!!!'
  puts ERB.new(message).result(binding)
end

def time_table
  schedule = [
      {name: "Теормех", audience: 112, when: :numerator},
      {name: "Мат. ан.", audience: 205},
      {name: "Теор. игр", audience: 108},
      {name: "Ин. яз.", audience: 507, when: :denomitanor},
  ]
  schedule
end

def get_timetable(table, weak)
  message = 'Schedule for the week:
  <% table.each do |subject| %>
  <% if subject[:when] == nil || subject[:when] == weak %> <%=subject[:name]%> <%= subject[:audience]%><% end %><% end %>'
  puts ERB.new(message).result(binding)
end

hello_stranger('Anna', 'Tselikova')

invitation('My Birthday', 'Kate',
'I am having birthday this weekend, looking forward to see you!','Anna')

online_shop('Mango', 30, :dress)

get_timetable(time_table, :numerator)
