PARENS = {
    "(" => ")",
    "[" => "]",
    "{" => "}",
    "<" => ">"
}

POINTS = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4
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
                return nil
            end 
        end
    end

    if !stack.empty?
        return stack.reverse.map {|x| PARENS[x]}
    end

    return nil
end

def calculate_completion_scores(lines)
    scores = []
    lines.each do |line|
        score = 0
        result = valid_line(line)
        if !result.nil?
            result.each do |missing_char|
                score *= 5
                score += POINTS[missing_char]
            end
            scores << score
        end
    end
    return scores
end

def get_middle_score(scores)
    length = scores.length
    midpoint = length / 2

    return scores.sort[midpoint]
end

puts get_middle_score(calculate_completion_scores(read_input("input10.txt")))