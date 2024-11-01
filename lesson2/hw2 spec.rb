require "minitest/spec"
require 'minitest/autorun'
require 'minitest/reporters'
require_relative '../lesson1/hw1'

Minitest::Reporters.use! [
                           Minitest::Reporters::SpecReporter.new,
                           Minitest::Reporters::HtmlReporter.new(
                             reports_dir: 'lesson2/test/reports',
                             report_filename: 'spec_test_results.html',
                             clean: true,
                             add_timestamp: true
                           )
                         ]


describe Student do
  before do
    @student = Student.new('Abc', 'Acd', '18-10-2005')
  end
  after do
        Student.students.clear
        @student = nil
  end
  describe 'initialize' do
    it 'creates correct instance' do
      expect(@student.name).must_equal 'Acd'
      expect(@student.surname).must_equal 'Abc'
      expect(@student. date_of_birth).must_equal Date.parse('18-10-2005')
      assert_equal 1, Student.students.length
    end
    it 'It raises error when date of birth is wrong' do
      expect {Student.new('Abc', 'Abc', Date.today.to_s)}.must_raise ArgumentError
    end
  end
  describe 'methods' do
    describe 'test addition of student into list of students' do
      it 'Adds unique student' do
        Student.new('Unique', 'Student', '18-10-2005')
        expect(Student.students.length).must_equal 2
      end
      it 'Don\'t add same student' do
        @student.add_student
        expect(Student.students.length).must_equal 1
      end
    end
    it 'Finds students by age' do
      Student.new('Abe', 'Abx', '17-10-2005')
      Student.new('Abd', 'Abz', '19-10-2005')
      Student.new('Abf', 'Abh', '20-10-2005')
      Student.new('Abx', 'Abw', '21-10-2005')
      Student.new('Abx', 'Abw', '21-10-2008')
      Student.new('Abx', 'Abw', '21-10-2009')
      expect(Student.get_students_by_age(@student.calculate_age).length).must_equal 5
    end
    it 'Finds students by name' do
      Student.new('Abc', 'Abc', '17-10-2005')
      Student.new('Abz', 'Abc', '19-10-2005')
      Student.new('Abe', 'Abc', '20-10-2005')
      Student.new('Abg', 'Abc', '21-10-2005')
      Student.new('Abx', 'Abw', '21-10-2008')
      Student.new('Abf', 'Abd', '21-10-2009')
      expect(Student.get_students_by_name('Abc').length).must_equal 4
    end
    it 'correctly compares 2 students' do
      expect(Student.new('Abc', 'Abc', '23-10-2004')).must_equal Student.new('Abc', 'Abc', '23-10-2004')
      expect(Student.new('Abc', 'Abc', '23-10-2004') == Student.new('Abf', 'Abd', '23-10-2005')).must_equal false
    end
  end
end