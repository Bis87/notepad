require_relative 'post.rb'
require_relative 'memo.rb'
require_relative 'link.rb'
require_relative 'task.rb'

require 'optparse'

# все опции будут записаны сюда
options = {}

OptionParser.new do |opt|

  opt.banner = 'Usage: read.rb [options]'

  opt.on('-h', 'Print this help') do
    puts opt
    exit
  end

  opt.on('--type POST_TYPE', 'specify type of post to show(default any)') {|o| options[:type] = o}
  opt.on('--id POST_ID', 'if id exist - show this post in detail') {|o| options[:id] = o}
  opt.on('--limit POST_NUMBER', 'number of posts to show(default all)') {|o| options[:limit] = o}

end.parse!

if options[:id] != nil
  result = Post.find_by_id(options[:id])
else
  result = Post.find_all(options[:limit], options[:type])
end

if result.is_a? Post
  puts "Record: #{result.class.name}, id = #{options[:id]}"

  result.to_strings.each do |line|
    puts line
  end
else

  print "| id\t| @type\t|  @created_at\t\t\t|  @text \t\t\t| @url\t\t| @due_date \t "

  result.each do |row|
    puts

    row.each do |el|
      print "| #{el.to_s.delete('\\n')[0..40]}\t"
    end
  end
end

puts