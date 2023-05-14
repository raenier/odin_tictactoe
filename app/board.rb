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
    winninghash = board.select{ |_, row| row.compact.uniq.length == 1 }
  end
end