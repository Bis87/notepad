require 'sqlite3'

# Родительский класс. Задает основные методы,  имеет 3 детей.

class Post

  @@SQLITE_DB_FILE = 'notepad.sqlite'

  #Статический метод. Возвращает все возможные типы постов(всех наследников)
  def self.post_types
    {'Memo' => Memo, 'Task' => Task, 'Link' => Link}
  end

  # Статический метод. Внего передается индекс элемента массива из post_types
  # Возвращает новый объект выбранного класса
  def self.create(type)
    return post_types[type].new
  end

  #Конструктор
  def initialize
    @text = nil # содержание
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

  def save_to_db



    db = SQLite3::Database.open(@@SQLITE_DB_FILE)

    db.results_as_hash = true

    db.execute(
          "INSERT INTO posts (" +
          #достаем ключи из хэща и соединяем их через запятую
              to_db_hash.keys.join(', ') +
              ")" +
              "VALUES (" +
          # через плейсхолдеры '?' передаем values из хэша
          # колличество плейсхолдеров равно количеству values
              ('?,'*to_db_hash.keys.size).chomp(',') +
          ")",
              to_db_hash.values
    )

    insert_row_id = db.last_insert_row_id

    db.close

    return insert_row_id
  end

  # вернет хэш со всеми полями данной записи
  def to_db_hash
    {
        'type' => self.class.name,
        'created_at' => @created_at.to_s
    }
  end

end