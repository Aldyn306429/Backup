# frozen_string_literal: true

# the node for piece of info
class Node
  attr_accessor :value, :left_value, :right_value
  include Comparable
  def initialize(left_value = nil, value = nil, right_value = nil)
    @value = value
    @left_value = left_value
    @right_value = right_value
  end

  def <=>(other)
    @value <=> other.value
  end
end

# the actual Binary Search Tree
class Tree
  attr_reader :root
  def initialize(array_of_values)
    @root = build_tree(array_of_values)
  end

  def build_tree(array)
    return nil if array.length.zero?
    return Node.new(nil, array[0]) if array.length == 1

    array = array.sort.uniq
    mid = (array.size / 2)

    left_array = mid.positive? ? array[0..mid - 1] : []
    right_array = array[mid + 1..array.size - 1]

    Node.new(build_tree(left_array), array[mid], build_tree(right_array))
  end

  def insert(new_item, array = @root)
    return self.root = Node.new(nil, new_item) if @root.nil?
    return array.left_value = Node.new(nil, new_item) if array.left_value.nil? && new_item < array.value
    return array.right_value = Node.new(nil, new_item) if array.right_value.nil? && new_item > array.value

    if array.value > new_item
      insert(new_item, array.left_value)
    elsif array.value < new_item
      insert(new_item, array.right_value)
    else
      return
    end
    @root = array
  end

  def delete(item, array = @root)
    return if @root.nil?

    parent_array = array

    main = true
    main = false if parent_array.value == item

    right = nil
    until array.nil? || array.value == item
      parent_array = array
      if array.value > item
        array = array.left_value
        right = false
      else
        array = array.right_value
        right = true
      end
    end

    return if array.nil?

    if array.left_value.nil? && array.right_value.nil?
      right ? parent_array.right_value = nil : parent_array.left_value = nil
    elsif !array.left_value.nil? && array.right_value.nil?
      right ? parent_array.right_value = array.left_value : parent_array.left_value = array.left_value
    elsif array.left_value.nil? && !array.right_value.nil?
      right ? parent_array.right_value = array.right_value : parent_array.left_value = array.right_value
    else
      true_array = array.right_value
      parent_true_array = array
      is_left = false

      until true_array.left_value.nil?
        parent_true_array = true_array
        true_array = true_array.left_value
        is_left = true
      end

      if true_array.right_value.nil?
        if main
          right ? parent_array.right_value.value = true_array.value : parent_array.right_value.value = true_array.value
        else
          parent_array.value = true_array.value
        end

        is_left ? parent_true_array.left_value = nil : parent_true_array.right_value = nil
      else
        if main
          right ? parent_array.right_value.value = true_array.value : parent_array.left_value.value = true_array.value
        else
          parent_array.value = true_array.value
        end

        true_array.right_value.nil? ? parent_true_array.right_value = nil : parent_true_array.right_value = true_array.right_value
      end
    end
  end

  def find(item, tree = @root)
    until tree.value == item || tree.nil?
      tree = tree.left_value if tree.right_value.value > item
      tree = tree.right_value if tree.left_value.value > item
    end

    tree.nil? ? return : tree
  end

  #Iterative Solution
  def level_order_i(tree = @root, queue = [])
    return if tree.nil?

    ans = []

    queue.push(tree)
    until queue.empty? 
      ans.push(queue[0].value)
      queue.push(queue[0].left_value) if !queue[0].left_value.nil?
      queue.push(queue[0].right_value) if !queue[0].right_value.nil?

      queue.shift
    end

    return ans
  end

  #Recursive Solution
  def level_order_r(ans = [], queue = [@root])
    return ans if queue.empty?

    node = queue.shift
    ans.push(node.value)
    queue.push(node.left_value) unless node.left_value.nil?
    queue.push(node.right_value) unless node.right_value.nil?

    level_order_r(ans, queue)
  end

  def inorder(ans = [], queue = @root)
    inorder(ans, queue.left_value) unless queue.left_value.nil?
    ans.push(queue.value)
    inorder(ans, queue.right_value) unless queue.right_value.nil?

    return ans if queue.value == @root.value
  end

  def preorder(ans = [], queue = @root)
    ans.push(queue.value)

    preorder(ans, queue.left_value) unless queue.left_value.nil?
    preorder(ans, queue.right_value) unless queue.right_value.nil?

    return ans if queue.value == @root.value
  end

  def postorder(ans = [], queue = @root)
    postorder(ans, queue.left_value) unless queue.left_value.nil?
    postorder(ans, queue.right_value) unless queue.right_value.nil?

    ans.push(queue.value)
    
    return ans if queue.value == @root.value
  end

  def height(target_node)
    return 0 if target_node.nil? 

    left_tree_height = height(target_node.left_value)
    right_tree_height = height(target_node.right_value)
    left_tree_height >= right_tree_height ? left_tree_height + 1 : right_tree_height + 1
  end

  def depth(node, tree = @root)
    return if tree.nil?

    ans = 0

    until (tree.right_value.nil? && tree.left_value.nil?) || tree.value == node
      unless tree.left_value.nil?
        if node < tree.value
          new_tree = tree.left_value 
          ans += 1
        end
      end

      unless tree.right_value.nil?
        if node > tree.value
          new_tree = tree.right_value 
          ans += 1
        end
      end

      tree = new_tree
    end

    return p ans if tree.value == node
    return if tree.right_value.nil? && tree.left_value.nil?
  end

  def balanced?
    return if @root.nil?

    check = (height(@root.left_value) - height(@root.right_value)).abs
    if check <= 1
      return true
    else 
      return false
    end
  end

  def rebalance
    unless balanced?
      array = level_order_r
      @root = build_tree(array)
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if root.nil?

    pretty_print(node.right_value, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_value
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left_value, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_value
  end

  def start 
    array = Array.new(15) {rand(1..100)}
    @root = build_tree(array)
    pretty_print
    puts "\n#{balanced? ? "Balanced!" : "Unbalanced!"}\n"
    puts "\nPreorder:\n#{preorder}"
    puts "\nInorder:\n#{inorder}"
    puts "\nPostorder:\n#{postorder}"
    puts "\nUnbalancing tree"
    insert(100)
    insert(123)
    insert(111)
    puts "\n#{balanced? ? "Balanced!" : "Unbalanced!"}\n"
    pretty_print
    puts "\nRebalancing tree\n"
    rebalance
    pretty_print
    puts "\n#{balanced? ? "Balanced!" : "Unbalanced!"}\n"
    puts "\nPreorder:\n#{preorder}"
    puts "\nInorder:\n#{inorder}"
    puts "\nPostorder:\n#{postorder}"
  end

  private

  attr_writer :root
end

a = Tree.new([])
a.start
