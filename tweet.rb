require 'twitter'
class Tweet < Post



  @@CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key = 'YuMEAIlSgne4hcFv1NOAvKoq1'
    config.consumer_secret = 'cfxqIoq6QvTX2mwJL8Drxeo0C99beJljiJ54MMuCOPmmfVogAv'
    config.access_token = '821808995656667136-jvqL0cTOzkilPy59N0MunYf3bkrheso'
    config.access_token_secret = 'mYZDtdZ0A9UWgCAfw5PHWLNJcSm2P9vXaDTbCZq32jagQ'
  end

  def read_from_console
    puts 'Print new Twit. (140 symbols as max!):'

    @text =  STDIN.gets.chomp[0..140]

    #.encode('utf-8')

    puts "Sending your tweet: #{@text}"

    @@CLIENT.update(@text)

    puts 'Tweet sent'
  end

  def to_strings
    time_string = "Created at: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')}"

    #Возвращает массив строк введенных пользователем
    # Первый элемент массива - строка с отформатированным временем создания записи
    return @text.unshift(time_string)
  end

  def to_db_hash
    return super.merge(
        {
            'text' => @text
        }
    )

  end

  # загружаем свои поля из хэш массива
  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для общих полей

    # теперь прописываем свое специфичное поле
    @text = data_hash['text'].split('\n\r')
  end

end