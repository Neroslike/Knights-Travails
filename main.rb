require 'pry-byebug'

class Node
  attr_accessor :data, :vertices, :parent

  def initialize(parent = nil, *vertices, data)
    @parent = parent
    @data = data
    @vertices = vertices
  end

  def to_s
    vertex = @vertices.map { |node| node.data}
    parent_data = @parent.data unless @parent.nil?
    "Parent: #{parent_data}\nData: #{@data}\nVertices: #{vertex}"
  end
end

class Knight
  @@PERM = [[-1, -2], [1, 2], [-2, -1], [2, 1], [1, -2], [-1, 2], [2, -1], [-2, 1]]
  @@visited = []

  # Outputs the squares the knight would step on before reaching it's goal.
  def knight_moves(from, to)
    from = build_tree(Node.new(from))
    count = bfs(from, to)
    puts "Moving the knight from #{from.data} to #{to}"
    puts "The knight completed the route in #{count.length - 1} steps"
    times = 0
    until count.empty? do
      puts "#{count.pop} <-- #{times}"
      times += 1
    end
  end

  # This function uses breadth first search to look for the destination of the knight
  # When the destination is found it adds its parent (And subsequent parents) to an array
  # until a node doesn't have a parent, meaning it's the starting point.
  # Returns array of every square it stepped on.
  def bfs(root, target, queue = [])
    if root.data == target
      current_parent = root
      count = [root.data]
      loop do
        current_parent = current_parent.parent
        if current_parent.nil?
          return count
        else
          count << current_parent.data
        end
      end
      return count
    end
    queue.shift
    queue += root.vertices
    bfs(queue[0], target, queue)
  end

  # This function takes a Node of the starting point, and calculates every possible move
  # the knight can do from that position, it does this recursively until all the squares of the
  # board are in the @@visited array.
  def build_tree(root, queue = [root], parent = nil)
    root = transform(root, parent)
    @@visited.push(root.data) unless @@visited.include?(root.data)
    queue.shift
    remove_cycle(queue += root.vertices)
    parent = queue[0].parent unless queue.empty?
    build_tree(queue[0], queue, parent) unless queue.empty?
    root
  end

  protected

  # Takes a node with the square coordinates, calculates all possible moves and returns a
  # Node containing the parent, data and all vertices (possible moves)
  def transform(root, parent)
    vertices = @@PERM.filter_map do |element|
      mapped = element.filter_map.with_index do |item, index|
        transformed = root.data[index] + item
        transformed if transformed > -1 && transformed < 8
      end
      Node.new(root, mapped) if mapped.length > 1
    end
    root.vertices = vertices
    root.parent = parent
    root
  end

  # Clears the queue of nodes with data that are already visited
  # preventing the program of running indefinitely.
  def remove_cycle(queue)
    queue.reject! { |node| @@visited.include?(node.data)}
  end
end

newk = Knight.new
newk.knight_moves([3, 3], [4, 3])
