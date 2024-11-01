require 'minitest/reporters'
require 'minitest/autorun'
require 'date'
require_relative 'hw1'

Minitest::Reporters.use! [
                           Minitest::Reporters::SpecReporter.new,
                           Minitest::Reporters::HtmlReporter.new(
                             reports_dir: 'test/reports',
                             report_filename: 'test_results.html',
                             clean: true,
                             add_timestamp: true
                           )
                         ]

class StudentTest < Minitest::Test
  def setup
    @student = Student.new('Abc', 'Abc', '18-10-2005')
  end
  def teardown
    Student.students.clear
    @student = nil
  end
  def test_wrong_date_of_birth
    assert_raises ArgumentError, 'This should have raised ArgumentError when date of birth is not in past' do 
      Student.new('Abc', 'Abc', Date.today.to_s)
    end
  end
  def test_adding_unique_student_into_students
    student = Student.new('Abc', 'Abc', '18-10-2006')
    assert_equal 2, Student.students.size, 'Unique student wasn\'t added into students'
  end
  def test_adding_same_student_into_students
    @student.add_student
    assert_equal 1, Student.students.size, 'Same student was added into students'
  end
  def test_get_students_by_age
    arr = [Student.new('Abe', 'Abx', '17-10-2005'),
          Student.new('Abd', 'Abz', '19-10-2005'),
          Student.new('Abf', 'Abh', '20-10-2005'),
          Student.new('Abx', 'Abw', '21-10-2005'),
          Student.new('Abx', 'Abw', '21-10-2008'),
          Student.new('Abx', 'Abw', '21-10-2009')
          ]
    assert_equal 5, Student.get_students_by_age(18).length, 'get_students_by_age isn\'t working correctly'
  end
  def test_get_students_by_name
    arr = [Student.new('Abc', 'Abc', '17-10-2005'),
    Student.new('Abz', 'Abc', '19-10-2005'),
    Student.new('Abe', 'Abc', '20-10-2005'),
    Student.new('Abg', 'Abc', '21-10-2005'),
    Student.new('Abx', 'Abw', '21-10-2008'),
    Student.new('Abf', 'Abd', '21-10-2009')
    ]
    assert_equal 5, Student.get_students_by_name('Abc').length, 'get_students_by_name isn\'t working correctly'
  end
  def test_equal
    assert_equal Student.new('Abc', 'Abc', '23-10-2004'), Student.new('Abc', 'Abc', '23-10-2004'), 'student1 == student2 is not working correcly, it should be true'
    assert !(Student.new('Abc', 'Abc', '23-10-2004') == Student.new('Abf', 'Abd', '23-10-2005')), 'student1 == student2 is not working correcly, it should be false'
  end
end