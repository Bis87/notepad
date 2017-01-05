require 'date'

class Task
  #super + @due_date
  def initialize
    super
    @due_date = Time.now
  end


# Этот метод пока пустой, он будет спрашивать 2 строки - описание задачи и дату дедлайна
  def read_from_console
    puts 'Type task here'
    @text = STDIN.gets.chomp

    puts 'Type deadline Date'
    input = STDIN.gets.chomp

    @due_date = Date.parse(input)
  end

# Массив из трех строк: дедлайн задачи, описание и дата создания
  def to_strings
    time_string = "Created at: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}"

    deadline = "Deadline: #{@due_date}"

    return [deadline, @text, time_string]
  end

end