# require 'io'
is_hobo_model = false
has_fields = false


def find_next(arr, search_token)
  arr.each_with_index do |line, l_index|
    tokens = line.scan(/[^\s]+/)
    tokens.each_with_index do |item, index|      
      # test if comment line
      puts "token:#{item}:"      
      return l_index if item.to_s == search_token                
    end    
  end
  return nil  
end

def find_next_end(arr)
  arr.each_with_index do |line, l_index|
    tokens = line.scan(/(\w+|#)/)
    tokens.each_with_index do |item, index|      
      # test if comment line
      token = item[0]
      if index == 0 
        return l_index if token == "end"                
      end     
    end    
  end
  return nil  
end

def replace(arr, index, length, replace)
  arr.slice!(index, length)
  arr.insert(index, replace)
end

def insert_newlines(arr, index, num)
  num.times do
    arr.insert(index, "\n")
  end
end

def comment(arr, index, length, replace)  
  list = arr[index..index+length-1]
  res = []
  list.each do |x|
    a = x.lstrip
    a = "\n" if a.strip == "" 
    firstchar = a.scan(/(\w+|#)/)      
    if firstchar.size > 0 
      firstchar = firstchar[0] 
      if firstchar.to_s == '#'
        res << x
      elsif !a.include?("###")
        # not a comment and not generated, comment it out
        res << ("    # " + a)  
      end      
    end
  end 
  res << "\n"
  arr.slice!(index, length)  
  insert_newlines(arr, index, 1)  
  res.insert(index, replace)
  res
end


# replace = "\tA\n\tB\n\tC"

replace = "    A ###\n    B ###\n    C ###\n"

arr = IO.readlines("user2.rb")
result = []
arr.each_with_index do |line, l_index|
    tokens = line.scan(/(\w+|#)/)
    # puts tokens.to_yaml
    tokens.each_with_index do |item, index|      
      # test if comment line
      token = item[0]
      if index == 0
        # puts "#{token}:#{index}"              
        if token == "#"
           # comment
        elsif token == 'hobo_model'
          # puts "is Hobo model:"
          is_hobo_model = true
          
        elsif token == 'has_many'
          # TODO - Use ParseTree to preparse file and help build hashmap :hash_many => {:x => 'end'} 
          # for what to search for to find end of statement :) 
          length = find_next(arr[l_index..-1], '#end')                    
          puts "has_many - end #{length}"
          
        elsif token == 'fields'
          # puts "Has fields:"
          has_fields = true
          length = find_next_end(arr[l_index..-1])
          if length
            # replace(arr, l_index+1, length-1, replace)
            result << line
            result << comment(arr, l_index+1, length-1, replace)            
            arr[l_index] = result
          else
            puts "'end' not found"
          end
        else          
          # default action
        end     
      else
        # ?
      end      
    end
#  end
end

puts arr.join

File.open('user2.rb', 'w') do |file|  
   file.puts arr.join
end
