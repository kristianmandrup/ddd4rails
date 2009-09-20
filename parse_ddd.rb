require 'json'

url = 'http://search.twitter.com/trends.json'

buffer = open(url, "UserAgent" => "Ruby-Wget").read

# convert JSON data into a hash
result = JSON.parse(buffer)

trends = result['trends']
trends.each do |subject|
  puts subject['name'] + ' ' + subject['url']
end

aFile = File.new("testfile", "r")
# ... process the file
aFile.close

aFile = File.new("testfile")
aFile.each_byte {|ch| putc ch; putc ?. }

aFile.each_line {|line| puts "Got #{line.dump}" }

IO.foreach("testfile") { |line| puts line }

Or, if you prefer, you can retrieve an entire file into an array of lines:

arr = IO.readlines("testfile")

# # Create a new file and write to it  
File.open('test.rb', 'w') do |f2|  
  # use "\n" for two lines of text  
  f2.puts "Created by Satish\nThank God!"  
end

r - Open a file for reading. The file must exist.
w - Create an empty file for writing. If a file with the same name already exists its content is erased and the file is treated as a new empty file.
a - Append to a file. Writing operations append data at the end of the file. The file is created if it does not exist.
r+ - Open a file for update both reading and writing. The file must exist.
w+ - Create an empty file for both reading and writing. If a file with the same name already exists its content is erased and the file is treated as a new empty file.
a+ - Open a file for reading and appending. All writing operations are performed at the end of the file, protecting the previous content to be overwritten. You can reposition (fseek, rewind) the internal pointer to anywhere in the file for reading, but writing operations will move it back to the end of file. The file is created if it does not exist.

File.open(local_filename, 'w') {|f| f.write(doc) }


YAML:


require 'yaml'
refs = open('references.yml') {|f| YAML.load(f) }
refs['custom assemblies'].each do |location|
  location['assemblies'].each do |assembly| 
    assembly['files'].each {|file| if file['output'] then puts "        #{file['output']}" end }
  end
end



CSS:
http://code.google.com/p/ruby-css-parser/

require 'css_parser'
  include CssParser

  parser = CssParser::Parser.new
  parser.load_file!('http://example.com/styles/style.css')

  # lookup a rule by a selector
  parser.find('#content')
  #=> 'font-size: 13px; line-height: 1.2;'

  # lookup a rule by a selector and media type
  parser.find('#content', [:screen, :handheld])

  # iterate through selectors by media type
  parser.each_selector(:screen) do |selector, declarations, specificity|
    ...
  end

  # add a block of CSS
  css = <<-EOT
    body { margin: 0 1em; }
  EOT

  parser.add_block!(css)

  # output all CSS rules in a single stylesheet
  parser.to_s
  => #content { font-size: 13px; line-height: 1.2; }
     body { margin: 0 1em; }