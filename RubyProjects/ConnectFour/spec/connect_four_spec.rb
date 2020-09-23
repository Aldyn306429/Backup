require './board.rb'
require './player_interface.rb'

describe 'Tests' do
  context 'board.rb' do
    subject { Board.new }
    context 'display_board' do
      it 'Returns starter board' do
      test =
      "        1   2   3   4   5   6   7
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |"
        expect(subject.board).to eql(test)
      end
    end
    context '#each_turn' do
      it 'Returns board on empty column' do
      test =
      "        1   2   3   4   5   6   7
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | o |"
        subject.each_turn(7, 'o')
        expect(subject.board).to eql(test)
      end
      it 'Returns board on filled column' do
      test =
      "        1   2   3   4   5   6   7
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | o | - | - | - | - | - |
      | - | o | - | - | - | - | - |"
        subject.each_turn(2, 'o')
        subject.each_turn(2, 'o')
        expect(subject.board).to eql(test)
      end
      it 'Returns same board if full' do
      test =
      "        1   2   3   4   5   6   7
      | - | - | o | - | - | - | - |
      | - | - | o | - | - | - | - |
      | - | - | o | - | - | - | - |
      | - | - | o | - | - | - | - |
      | - | - | o | - | - | - | - |
      | - | - | o | - | - | - | - |"
        subject.each_turn(3, 'o')
        subject.each_turn(3, 'o')
        subject.each_turn(3, 'o')
        subject.each_turn(3, 'o')
        subject.each_turn(3, 'o')
        subject.each_turn(3, 'o')
        subject.each_turn(3, 'o')
        expect(subject.board).to eql(test)
      end
    end
    context '#highlight_path' do
      it 'Highlights the path of red cells' do
        test =
      "        1   2   3   4   5   6   7
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | #{"\u25EF".red.bg_yellow} | #{"\u25EF".red.bg_yellow} | #{"\u25EF".red.bg_yellow} | #{"\u25EF".red.bg_yellow} | - | - | - |"
        subject.cell[5][0] = "\u25EF".red
        subject.cell[5][1] = "\u25EF".red
        subject.cell[5][2] = "\u25EF".red
        subject.cell[5][3] = "\u25EF".red
        subject.make_change
        subject.highlight_path([[5, 0], [5, 1], [5, 2], [5, 3]])
        expect(subject.board).to eql(test)
      end
      it 'Highlights the path of yellow cells' do
        test =
          "        1   2   3   4   5   6   7
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | - | - | - | - | - | - | - |
      | #{"\u25EF".yellow.bg_yellow} | #{"\u25EF".yellow.bg_yellow} | #{"\u25EF".yellow.bg_yellow} | #{"\u25EF".yellow.bg_yellow} | - | - | - |"
        subject.cell[5][0] = "\u25EF".yellow
        subject.cell[5][1] = "\u25EF".yellow
        subject.cell[5][2] = "\u25EF".yellow
        subject.cell[5][3] = "\u25EF".yellow
        subject.make_change
        subject.highlight_path([[5, 0], [5, 1], [5, 2], [5, 3]])
        expect(subject.board).to eql(test)
      end
    end
  end
  context 'player_interface.rb' do
    subject { Interface.new }
    context 'game_over?' do
      it 'Draw: No more spaces left' do
        cell = Array.new([
          ['o', 'o', 'o', 'x', 'o', 'o', 'o'],
          ['x', 'x', 'x', 'o', 'x', 'x', 'x'],
          ['o', 'o', 'x', 'x', 'x', 'o', 'x'],
          ['x', 'x', 'o', 'o', 'x', 'x', 'o'],
          ['o', 'o', 'x', 'x', 'o', 'o', 'x'],
          ['o', 'o', 'x', 'x', 'o', 'x', 'o']])
        expect(subject.game_over?(cell)).to be true
      end
      it 'Spaces remaining' do
        cell = Array.new([
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', 'o', '-', '-', '-', '-'],
          ['-', '-', 'o', '-', '-', '-', '-'],
          ['-', '-', 'o', '-', 'x', 'x', '-'],
          ['-', 'x', 'x', '-', 'o', 'x', 'o'],
          ['x', 'o', 'o', 'x', 'o', 'x', 'o']])
        expect(subject.game_over?(cell)).to be false
      end
      it 'A player won' do
        cell = Array.new([
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', 'x', '-', '-', 'x', '-', 'o'],
          ['x', 'o', 'x', 'x', 'o', 'x', 'o'],
          ['o', 'x', 'o', 'x', 'o', 'x', 'x'],
          ['x', 'o', 'o', 'x', 'x', 'o', 'o'],
          ['x', 'o', 'o', 'x', 'o', 'o', 'o']])
        expect(subject.game_over?(cell)).to be true
      end
    end
    context 'victory?' do
      it 'Victory through row(1)' do
        cell = Array.new([
          ['-', '-', '-', 'o', 'o', 'o', 'o'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-']])
        expect(subject.victory?(cell)).to be true
      end
      it 'Victory through row(2)' do
        cell = Array.new([
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['o', 'o', 'o', 'o', 'o', '-', '-']])
        expect(subject.victory?(cell)).to be true
      end
      it 'Victory through column(1)' do
        cell = Array.new([
          ['-', '-', '-', 'o', '-', '-', '-'],
          ['-', '-', '-', 'o', '-', '-', '-'],
          ['-', '-', '-', 'o', '-', '-', '-'],
          ['-', '-', '-', 'o', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-']])
        expect(subject.victory?(cell)).to be true
      end
      it 'Victory through column(2)' do
        cell = Array.new([
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', 'o', '-', '-'],
          ['-', '-', '-', '-', 'o', '-', '-'],
          ['-', '-', '-', '-', 'o', '-', '-'],
          ['-', '-', '-', '-', 'o', '-', '-']])
        expect(subject.victory?(cell)).to be true
      end
      it 'Victory through diagonal down-up(1)' do
        cell = Array.new([
          ['-', '-', '-', '-', '-', '-', 'o'],
          ['-', '-', '-', '-', '-', 'o', '-'],
          ['-', '-', '-', '-', 'o', '-', '-'],
          ['-', '-', '-', 'o', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-']])
        expect(subject.victory?(cell)).to be true
      end
      it 'Victory through diagonal down-up(2)' do
        cell = Array.new([
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', 'o', '-', '-'],
          ['-', '-', '-', 'o', '-', '-', '-'],
          ['-', '-', 'o', '-', '-', '-', '-'],
          ['-', 'o', '-', '-', '-', '-', '-']])
        expect(subject.victory?(cell)).to be true
      end
      it 'Victory through diagonal up-down(1)' do
        cell = Array.new([
          ['-', '-', '-', 'o', '-', '-', '-'],
          ['-', '-', '-', '-', 'o', '-', '-'],
          ['-', '-', '-', '-', '-', 'o', '-'],
          ['-', '-', '-', '-', '-', '-', 'o'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-']])
        expect(subject.victory?(cell)).to be true
      end
      it 'Victory through diagonal up-down(2)' do
        cell = Array.new([
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['o', '-', '-', '-', '-', '-', '-'],
          ['-', 'o', '-', '-', '-', '-', '-'],
          ['-', '-', 'o', '-', '-', '-', '-'],
          ['-', '-', '-', 'o', '-', '-', '-']])
        expect(subject.victory?(cell)).to be true
      end
      it 'No victory(1)' do
        cell = Array.new([
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['-', '-', '-', '-', '-', '-', '-']])
        expect(subject.victory?(cell)).to be false
      end
      it 'No victory(2)' do
        cell = Array.new([
          ['-', '-', '-', 'x', 'o', 'x', 'o'],
          ['o', 'o', 'o', 'x', 'o', 'x', 'x'],
          ['-', '-', '-', '-', '-', '-', '-'],
          ['o', 'x', 'o', 'x', 'o', 'x', 'o'],
          ['x', 'o', 'x', 'o', 'x', 'o', 'x'],
          ['o', 'x', 'o', 'x', 'o', 'x', 'o']])
        expect(subject.victory?(cell)).to be false
      end
      it 'Mess board victory' do
        cell = Array.new([
          ['-', '-', '-', 'x', 'o', 'x', 'o'],
          ['o', 'o', 'o', 'x', 'x', 'x', 'x'],
          ['-', '-', '-', '-', '-', 'o', '-'],
          ['o', 'x', 'o', 'x', 'o', 'x', 'o'],
          ['x', 'o', 'x', 'o', 'x', 'o', 'x'],
          ['o', 'x', 'o', 'x', 'o', 'x', 'o']])
        expect(subject.victory?(cell)).to be true
      end
    end
  end
end
