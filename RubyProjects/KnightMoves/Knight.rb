# frozen_string_literal: true

# To find the shortest path
class Knight
  attr_reader :knight, :end_knight
  def initialize(a, b)
    @knight = [a[0], a[1]]
    @end_knight = [b[0], b[1]]
    @helper_board = visited_board
    @new_temp = []
    @path = []
  end

  def visited_board
    board = []
    for i in 1..8
      temp = []
      for j in 1..8
        temp.push('')
      end
      board.push(temp)
    end
    board
  end

  def find_path(a = @knight, b = @end_knight)
    found = false
    found = true if a[0] == b[0] && a[1] == b[1]

    queue = []
    queue.push([[a[0] - 1, a[1] - 1]])

    i = 1
    @helper_board[a[0] - 1][a[1] - 1] = i
    until found
      i += 1
      temp = queue.shift
      @new_temp = []
      until temp.empty?
        idk = find_possible_pos(temp[0][0], temp[0][1])
        temp.shift
        idk.each do |pos|
          found = true if pos[0] + 1 == b[0] && pos[1] + 1 == b[1]
          @new_temp.push(pos)
          @helper_board[pos[0]][pos[1]] = i if @helper_board[pos[0]][pos[1]] == ''
        end
      end
      queue.push(@new_temp)
    end

    go_on = false
    total = @helper_board[b[0] - 1][b[1] - 1]
    test = find_possible_pos(b[0] - 1, b[1] - 1)
    @path.push([b[0], b[1]])

    until total == 0
      total -= 1

      for i in 0..7
        for j in 0..7
          test.each do |temp|
            if @helper_board[temp[0]][temp[1]] == total
              @path.push([temp[0] + 1, temp[1] + 1])
              test = find_possible_pos(temp[0], temp[1])
              go_on = true
              break
            end
          end
        end
        break if go_on
      end
      go_on = false
    end
    @path.reverse
  end

  def find_possible_pos(x, y)
    arr = []
    arr.push([x + 1, y + 2]) if x + 1 >= 0 && x + 1 <= 7 && y + 2 >= 0 && y + 2 <= 7
    arr.push([x - 1, y + 2]) if x - 1 >= 0 && x - 1 <= 7 && y + 2 >= 0 && y + 2 <= 7
    arr.push([x + 2, y + 1]) if x + 2 >= 0 && x + 2 <= 7 && y + 1 >= 0 && y + 1 <= 7
    arr.push([x - 2, y + 1]) if x - 2 >= 0 && x - 2 <= 7 && y + 1 >= 0 && y + 1 <= 7
    arr.push([x - 1, y - 2]) if x - 1 >= 0 && x - 1 <= 7 && y - 2 >= 0 && y - 2 <= 7
    arr.push([x + 1, y - 2]) if x + 1 >= 0 && x + 1 <= 7 && y - 2 >= 0 && y - 2 <= 7
    arr.push([x - 2, y - 1]) if x - 2 >= 0 && x - 2 <= 7 && y - 1 >= 0 && y - 1 <= 7
    arr.push([x + 2, y - 1]) if x + 2 >= 0 && x + 2 <= 7 && y - 1 >= 0 && y - 1 <= 7
    arr
  end
end
