def read_input(file_name)
  adjList = Hash.new { |hash, key| hash[key] = []}

  File.open(file_name).each do |line|
      row = line.chomp.split("-")
      adjList[row[0]] << row[1]
      adjList[row[1]] << row[0]
  end
  
  adjList
end

class Graph

  def initialize(adjList:)
      @adjList = adjList
  end

  def list_all_paths(start:, destination:)
      all_paths = []
      path = []
      queue = []
      path << start
      queue.unshift(path)

      while !queue.empty?
          path = queue.pop
          last = path[-1]

          if last == destination
              puts path.join(",")
              all_paths << path
          end

          neighbors = @adjList[last]

          neighbors.each do |neighbor|
              if neighbor == neighbor.upcase || 
                (!(["start", "end"].include?(neighbor) && path.include?(neighbor)) &&
                (!small_node_visited_twice?(path) || (neighbor == neighbor.downcase && !path.include?(neighbor)))
              )
                  newPath = Array.new(path)
                  newPath << neighbor
                  queue.unshift newPath
              end
          end
      end

      return all_paths
  end

  private

  def small_node_visited_twice?(path)
    path.group_by{|e| e}.map{|k,v| [k, v.length]}.to_h.any?{|k,v|  /[[:lower:]]/.match?(k) && v == 2}
  end

end

graph = Graph.new(adjList: read_input("input12.txt"))

puts graph.list_all_paths(start: "start", destination: "end").length