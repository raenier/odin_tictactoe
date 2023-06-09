class Board
  attr_accessor :board

  def initialize
    @board = {
              a: Array.new(3),
              b: Array.new(3),
              c: Array.new(3),
             }
  end

  def record(player_piece, row_letter, column_number)
    return unless cell_exist_and_empty?(row_letter, column_number)

    board[row_letter.to_sym][column_number.to_i - 1] = player_piece
  end

  def cell_exist_and_empty?(row_letter, column_number)
    return if column_number > 3 || row_letter > 'c'
    board.dig(row_letter.to_sym, column_number - 1).nil?
  end

  def full_board?
    board.all? do |_, row|
      row.all? { |cell| !cell.nil? }
    end
  end

  def winner
    horizontal || vertical || diagonal
  end

  def horizontal
    board.select{ |_, row| row.uniq.length == 1 }.values.first&.first
  end

  def vertical
    winner=
      (0..2).reduce('') do |winner, index|
        if [ board[:a][index], board[:b][index], board[:c][index] ].uniq.length == 1 && !board[:a][index].nil?
          winner = board[:a][index]
        end
        winner
      end
    winner.empty? ? nil : winner
  end

  def diagonal
    %w{abc cba}.map do |reference|
      (0..2).map {|index| board[reference[index].to_sym][index]}
    end.select{ |row| row.uniq.length == 1 }.first&.first
  end

  def display
    p '--------------'
    board.each do |row|
      p " #{cell(row, 0)} | #{cell(row, 1)} | #{cell(row, 2)} "
      p '--------------'
    end
  end

  def cell(row, index)
    row.last[index] || row.first.to_s + (index + 1).to_s
  end
end
