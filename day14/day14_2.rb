class PolymerTemplate
  def initialize(template:, rules:)
    @template = template
    @rules = rules
  end

  def transform(steps: 0)
    pairs = @template.chars.each_cons(2).map {|pair| pair.join}.tally
    char_counts = @template.chars.tally
    char_counts.default = 0
    
    steps.times do
      new_pairs = Hash.new(0)
      pairs.each do |pair, total|
        new_char = @rules[pair]
        
        char_counts[new_char] = char_counts[new_char] + total
        new_pairs[pair] = new_pairs[pair] - total
        new_pairs[pair[0] + new_char] = new_pairs[pair[0] + new_char] + total
        new_pairs[new_char + pair[1]] = new_pairs[new_char + pair[1]] + total
      end
      pairs.merge!(new_pairs) {|key, old_val, new_val| old_val + new_val}
      
    end
    char_counts.values.max - char_counts.values.min
  end
end

def read_input(filename)
  template = ''
  rules = Hash.new()
  reading_rules = false
  File.open(filename).each do |line|
      row = line.chomp

      if reading_rules
        match = row.match(/([A-Z][A-Z]) -> ([A-Z])/)
        rules[match[1]] = match[2]
      else
        if row.empty?
          reading_rules = true
        else
          template = row
        end
      end

  end

  [template, rules]
end

input = read_input("input14.txt")

polymer = PolymerTemplate.new(template: input[0], rules: input[1])
result = polymer.transform(steps: 40)
puts result