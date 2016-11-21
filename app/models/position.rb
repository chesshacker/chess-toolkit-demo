class Position < ActiveRecord::Base
  has_many :moves, -> { includes :position }, :foreign_key => "from_position_id"
  # has_many :preceding_moves, :class_name => "Move", :foreign_key => "to_position_id"

  def Position.find_ct_position(ct_position)
    Position.where(:zhash => ct_position.hash, :fen => ct_position.to_fen).first
  end

  def black
    return self.total - self.white - self.draw
  end

  def white_percent
    100.0 * self.white / self.total
  end

  def black_percent
    100.0 * self.black / self.total
  end

  def draw_percent
    100.0 * self.draw / self.total
  end

  # strength = (2*w+d)/sqrt(5)
  # sharpness = (w-2*d)/sqrt(5)

  def strength(for_white)
    return nil if self.total == 0
    100.0 * (2.0 * (for_white ? self.white : self.black) + self.draw) / self.total / Math.sqrt(5)
  end

  def sharpness(for_white)
    return nil if self.total == 0
    100.0 * ((for_white ? self.white : self.black) - 2.0 * self.draw) / self.total / Math.sqrt(5)
  end

	def moves_sorted
	  @moves_sorted ||= self.moves.sort { |a,b| b.total <=> a.total }
  end

	def move_to_position(to_position)
	  Move.find_from_to(self,to_position)
  end

  def white_elo
    (self.white_elo_total.to_f / self.total).round;
  end

  def black_elo
    (self.black_elo_total.to_f / self.total).round;
  end

end
