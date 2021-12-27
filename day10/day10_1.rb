PARENS = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
}

POINTS = {
    ")" => 3,
    "]" => 57,
    "}" => 1197,
    ">" => 25137
}

def read_input(file_name)
    lines = []
    File.open(file_name).each do |line|
        lines << line
    end
    
    lines
end

def valid_line(line)
    chars = line.split("")
    stack = []

    chars.each do |character|
        if PARENS.keys.include? character
            stack << character
        elsif PARENS.values.include? character
            if PARENS[stack.last] == character
                stack.pop
            else
                return character
            end 
        end
    end

    return ""
end

def calculate_syntax_error_score(lines)
    score = 0

    lines.each do |line|
        result = valid_line(line)
        if POINTS[result]
            score += POINTS[result]
        end
    end
    return score
end
puts calculate_syntax_error_score(read_input("input10.txt"))