# Родительский класс. Задает основные методы,  имеет 3 детей.

class Post

  #Конструктор
  def initialize
    @text = nil# содержание
    @created_at = Time.now  # дата создания
  end


  # Этот метод вызывается в программе, когда нужно
  # считать ввод пользователя и записать его в нужные поля объекта
  def read_from_console
    #Реализуется у укаждого наследника с присущими ему особенностями считывания
  end


  # Этот метод возвращает состояние объекта в виде массива строк, готовых к записи в файл
  def to_strings
    #Реализуется у укаждого наследника с присущими ему особенностями считывания
  end

  def to_strings

  end

  # Метод возвращает путь для метода save.
  def file_path
    current_path = File.dirname(__FILE__)

    file_name = @created_at.strftime("#{self.class.name}_%Y_%m_%d_%H_%M_%S.txt")

    return current_path + "/" + file_name
  end

  def save
    f = File.new(file_path, 'w:UTF-8')

    for i in to_strings do
      f.puts i
    end

    f.close
  end

end