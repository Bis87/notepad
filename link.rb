class Link < Post

  #super + @url
  def initialize
    super
    @url = ''
  end

  # Этот метод пока пустой, он будет спрашивать 2 строки — адрес ссылки и описание
  def read_from_console
    puts 'Type Link address'
    @url = STDIN.gets.chomp

    puts 'Link description'
    @text = STDIN.gets.chomp
  end

  # Массив из трех строк: адрес ссылки, описание и дата создания
  def to_strings
    time_string = "Created at: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}"

    return [@url, @text, time_string]
  end

end