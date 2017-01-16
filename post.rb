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
    puts "type: #{type}"
    return post_types[type].new
  end

  def self.find_by_id(id)

    db = SQLite3::Database.open(@@SQLITE_DB_FILE)

      db.results_as_hash = true
    begin
      result = db.execute("SELECT * FROM posts WHERE rowid = ?", id)
    rescue SQLite3::SQLException => e
      puts "Query to db #{@@SQLITE_DB_FILE} failed"
      abort e.message
    end

      result = result[0] if result.is_a? Array

      db.close

      if result.empty?
        puts "this id: #{id} absent in db"
        return nil
      else
        post = create(result['type'])

        post.load_data(result)

        db.close

        return post
      end
    end

  # return records in table
    def self.find_all(limit, type)

      db = SQLite3::Database.open(@@SQLITE_DB_FILE)

      db.results_as_hash = false

      #create query with necessary conditions
      query = "SELECT rowid, * FROM posts "

      query += "WHERE type = :type " unless type.nil?
      query += "ORDER by rowid DESC "

      query += "LIMIT :limit " unless limit.nil?

      begin
        statment = db.prepare query
      rescue SQLite3::SQLException => e
        puts "Query to db #{@@SQLITE_DB_FILE} failed"
        abort e.message
      end

      statment.bind_param('type', type) unless type.nil?
      statment.bind_param('limit', limit) unless limit.nil?

      begin
        result = statment.execute!
      rescue SQLite3::SQLException => e
        puts "Query to db #{@@SQLITE_DB_FILE} failed"
        abort e.message
      end

      statment.close
      db.close

      return result
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

    begin

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
    rescue SQLite3::SQLException => e
      puts "Query to db #{@@SQLITE_DB_FILE} failed"
      abort e.message
    end

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

  # получает на вход хэш массив данных и должен заполнить свои поля
  def load_data(data_hash)
    @created_at = Time.parse(data_hash['created_at'])
  end
end