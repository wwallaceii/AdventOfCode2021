require 'set'
class Panel
    attr_reader :digits, :panel_digits
    def initialize(digits, panel_digits)
        @digits = digits
        @panel_digits = panel_digits         
    end
end
def read_input(file_name)
    panels = []
    File.open(file_name).each do |line|
        temp = line.chomp.split("|")
        digits = temp[0].split(" ")
        panel_digits =temp[1].split(" ")

        panels << Panel.new(digits, panel_digits)
    end
    
    panels
end

def sum_decoded_digits(panels)
    sum = 0
    
    panels.each do |panel|
        digit_to_code = Hash.new()
        panel.digits.filter {|digit| [2,3,4,7].include?(digit.length)}.each do |digit|
            if digit.length == 2
                digit_to_code["1"] = Set.new(digit.chars.to_a)
            elsif digit.length == 4
                digit_to_code["4"] = Set.new(digit.chars.to_a)
            elsif digit.length == 3
                digit_to_code["7"] = Set.new(digit.chars.to_a)
            elsif digit.length == 7
                digit_to_code["8"] = Set.new(digit.chars.to_a)
            end
        end
        
        panel.digits.filter {|digit| digit.length == 6}.each do |digit|
            new_set = Set.new(digit.chars.to_a)
            if new_set > digit_to_code["4"]
                digit_to_code["9"] = new_set
            elsif new_set > digit_to_code["7"]
                digit_to_code["0"] = new_set
            else
                digit_to_code["6"] = new_set
            end
        end

        panel.digits.filter {|digit| digit.length == 5}.each do |digit|
            new_set = Set.new(digit.chars.to_a)
            if new_set > digit_to_code["7"]
                digit_to_code["3"] = new_set
            elsif new_set < digit_to_code["6"]
                digit_to_code["5"] = new_set
            else
                digit_to_code["2"] = new_set
            end
        end

        code_string = ""
        panel.panel_digits.each do |code_digit|
            code_string << digit_to_code.key(Set.new(code_digit.chars.to_a))
        end
        sum += code_string.to_i
    end
    
    sum
end

panels = read_input("input8.txt")
puts sum_decoded_digits(panels)
