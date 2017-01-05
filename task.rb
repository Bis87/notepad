class Task
  #super + @due_date
  def initialize
    super
    @due_date = Time.now
  end


# Этот метод пока пустой, он будет спрашивать 2 строки - описание задачи и дату дедлайна
  def read_from_console

  end

# Массив из трех строк: дедлайн задачи, описание и дата создания
# Будет реализован в след. уроке
  def to_strings

  end

end