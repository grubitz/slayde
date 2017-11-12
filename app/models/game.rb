class Game

  SOLUTION = (1..9).to_a

  def self.riddle
    SOLUTION.shuffle
  end

  def self.check(user_solution)
    user_solution == SOLUTION
  end
end
