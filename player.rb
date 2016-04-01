class Player
  @@players = []

  class << self
    def players
      @@players
    end
  end

  attr_reader :lives, :name, :points
  def initialize(name = "Player")
    @lives  = 3
    @points = 0 
    @name   = name
    @@players << self
  end

  def points_string
    "#{points} #{points == 1 ? "point" : "points"}"
  end

  def revive
    @lives = 3
  end

  def kill
    @lives -= 1
  end

  def add_point
    @points += 1
  end

  def alive?
    lives > 0
  end
end
