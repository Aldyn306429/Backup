# frozen_string_literal: true

# the node
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

# the linked list
class LinkedList
  attr_reader :head, :tail, :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def append(value)
    if head.nil?
      self.head = Node.new(value)
      self.tail = head
    else
      tail.next_node = Node.new(value)
      self.tail = tail.next_node
    end
    self.size += 1
  end

  def prepend(value)
    if head.nil?
      self.head = Node.new(value)
      self.tail = head
    else
      temp_head = head
      self.head = Node.new(value, temp_head)
    end
    self.size += 1
  end

  def at(index)
    return nil if index.negative? || index > size - 1

    result = head
    index.times do
      result = result.next_node
    end

    result.value
  end

  def contains?(check)
    result = head
    size.times do
      return true if result.value == check

      result = result.next_node
    end
    false
  end

  def find(value)
    result = head
    for i in 0..size - 1 do
      return i if result.value == value

      result = result.next_node
    end
    nil
  end

  def to_s
    return nil if size.zero?

    result = head
    size.times do
      print "#{result.value} -> "
      result = result.next_node
    end
    print "nil\n"
  end

  def pop
    remove_at(size - 1)
    self.size -= 1
  end

  def head?
    head.value
  end

  def tail?
    tail.value
  end

  # Extra Credits
  def insert_at(value, index)
    return if index > size || index.negative?

    if index.zero?
      prepend(value)
      return
    elsif index == size
      append(value)
      return
    end

    result = head
    (index - 1).times do
      result = result.next_node
    end

    temp = result.next_node
    result.next_node = Node.new(value, temp)
    self.size += 1
  end

  def remove_at(index)
    return if head.nil? || index > (size - 1) || index.negative?

    result = head

    self.head = result.next_node if index.zero?

    (index - 1).times do
      result = result.next_node
    end
    temp = result.next_node.next_node
    result.next_node = temp
    self.size -= 1
  end

  private

  attr_writer :head, :tail, :size
end
