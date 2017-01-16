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

  def to_db_hash
    return super.merge(
        {
            'text' => @text,
            'url' => @url
        }
    )

  end

  # загружаем свои поля из хэш массива
  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для общих полей

    # теперь прописываем свое специфичное поле
    @url = data_hash['url']
  end

end