class Memo < Post

  # Считывет из консоли до тех пор пока не введено слово 'end'
  # Введенные строки сохраняются в массив
  def read_from_console
    puts 'Type text here. Type "End" to finish input'

    @text = []

    line = nil

    while line != 'end'

      line = STDIN.gets.chomp

      @text << line

    end

    @text.pop
  end

  def to_strings
    time_string = "Created at: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}"

    #Возвращает массив строк введенных пользователем
    # Первый элемент массива - строка с отформатированным временем создания записи
    return @text.unshift(time_string)
  end


end