class Player
  @@all = []

  class << self
    def all
      @@all
    end
  end

  attr_reader :lives, :name, :points
  def initialize(name = "Player")
    @lives  = 3
    @points = 0 
    @name   = name
    @@all << self
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
