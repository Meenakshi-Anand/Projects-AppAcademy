class Employee


  def initialize (name,title,salary)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    salary * multiplier
  end


  attr_reader :name , :salary , :title , :boss

end
