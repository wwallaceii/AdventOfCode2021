class PolymerTemplate
  def initialize(template:, rules:)
    @template = template
    @rules = rules
  end

  def transform(steps: 0)
    result = @template
    steps.times do
      ending  = result.length - 1
      start = ending - 1
      code = result[start..ending]
      
      while start >= 0
        insert = @rules[code]
        
        result = result.insert(ending, insert)
        ending = start
        start = ending - 1
        code = result[start..ending]
      end
    end
    result
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
result = polymer.transform(steps: 10)
map = result.chars.group_by{|e| e}.map{|k, v| [k, v.length]}.to_h
sorted_array = map.sort_by { |k, v| v}
puts "10 steps: #{sorted_array.last[1] - sorted_array.first[1]}"

puts result = polymer.transform(steps: 40)
#map = result.chars.group_by{|e| e}.map{|k, v| [k, v.length]}.to_h
#sorted_array = map.sort_by { |k, v| v}
#puts "40 steps: #{sorted_array.last[1] - sorted_array.first[1]}"