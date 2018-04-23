require_relative 'employee.rb'
require 'byebug'
class Manager < Employee

  def initialize (name, title, salary, employee_array)
    super(name, title, salary)
    @employee_array = employee_array

  end

  def bonus(multiplier)
    total_sub_salary * multiplier
  end

  def total_sub_salary
    salary_sum = 0
    employee_array.each do |emp|
        if emp.is_a?(Manager)
          salary_sum += emp.total_sub_salary + emp.salary
         else
           salary_sum += emp.salary
        end
    end
    salary_sum
  end


 private
attr_reader :employee_array
end


if __FILE__ == $PROGRAM_NAME

  emp3 = Employee.new("Shawna", "TA", 12000)
  emp4 = Employee.new("David", "TA", 10000)
  emp2 = Manager.new("Darren", "TA Manager", 78000,  [emp3, emp4])
  emp1 = Manager.new("Ned", "Founder", 1000000, [emp2])
#  p emp1.employee_array
  # p emp2.employee_array
p emp2.bonus(4)
end
