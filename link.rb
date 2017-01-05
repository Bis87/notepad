class Link < Post

  #super + @url
  def initialize
    super
    @url = ''
  end

  # Этот метод пока пустой, он будет спрашивать 2 строки — адрес ссылки и описание
  def read_from_console

  end

  # Массив из трех строк: адрес ссылки, описание и дата создания
  # Будет реализован в след. уроке
  def to_strings

  end

end