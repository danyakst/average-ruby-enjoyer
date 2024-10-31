require 'date'

class Student
  attr_reader :surname, :name, :date_of_birth
  @@students = []
  def initialize(surname, name, date_of_birth)
    @surname = surname
    @name = name
    @date_of_birth = Date.parse(date_of_birth)
    raise ArgumentError unless (@date_of_birth <=> Date.today) == -1
    add_student()
  end
  def calculate_age()
    (Date.today - @date_of_birth).to_i / 365
  end
  def add_student()
    @@students << self unless @@students.include?(self)
  end
  def remove_student()
    @@students.delete(self)
  end
  def get_students_by_age(age)
    @@students.select do |item|
      item.calculate_age == age
    end
  end
  def get_students_by_name(name)
    @@students.select do |item|
      item.name == name
    end
  end
  def ==(other)
    @surname == other.surname && @name == other.name && @date_of_birth == other.date_of_birth
  end
end