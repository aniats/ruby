class Parent
    def say_hello
      puts "Hello from #{self}"
    end
end
  parent = Parent.new
  puts parent.say_hello
  
  class Child < Parent
  end
  child = Child.new
  puts child.say_hello

  puts "Child superclass: #{Child.superclass}"
  puts "Parent.superclass: #{Parent.superclass}"
  puts "Object.superclass: #{Object.superclass}"
  puts "BasicObject.superclass "\
   "#{BasicObject.superclass.inspect}"