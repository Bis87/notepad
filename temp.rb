def self.find(limit, type, id)

  db = SQLite3::Database.open(@@SQLITE_DB_FILE)

  # 1. Конкретная запись по id
  if !id.nil?
    db.results_as_hash = true

    result = db.execute("SELECT * FROM posts WHERE rowid = ?", id)

    result = result[0] if result.is_a? Array

    db.close

    if result.empty?
      puts "this id: #{id} absent in db"
      return nil
    else
      post = create(result['type'])

      post.load_data(result)

      return post
    end

  else
    # return records in table
    db.results_as_hash = false

    #create query with necessary conditions
    query = "SELECT rowid, * FROM posts "

    query += "WHERE type = :type " unless type.nil?
    query += "ORDER by rowid DESC "

    query += "LIMIT :limit " unless limit.nil?

    statment = db.prepare(query)

    statment.bind_param('type', type) unless type.nil?
    statment.bind_param('limit', limit) unless limit.nil?

    result = statment.execute!

    statment.close
    db.close

    return result
  end

end