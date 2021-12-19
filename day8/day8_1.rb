def read_input(file_name)
    codes = []
    File.open(file_name).each do |line|
        temp = line.chomp.split("|")
        codes.concat(temp[1].split(" "))
    end
    
    codes
end

def count_simple_digits(codes)
    codes.filter {|code| [2,3,4,7].include? code.length}.length
end

codes = read_input("input8.txt")
puts codes
puts count_simple_digits(codes)
