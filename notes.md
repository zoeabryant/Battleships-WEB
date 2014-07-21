#### Running new code in IRB/Pry, thought process

`````
require './lib/game.rb'
game = Game.new

# This bit needs to be automated
# player1 = Player.new
# player1 = Player.new(:name => 'Zoe')

player1 = Player.new(:name => 'Zoe', :board => Board.new)
player2 = Player.new(:name => 'Jenny', :board => Board.new)

# got water to be automatic now...
player1 = Player.new(:name => 'Zoe', :board => Board.new(content: Water.new))
player2 = Player.new(:name => 'Jenny', :board => Board.new(content: Water.new))

player1.board.render_display
# should nil be like that??

player1.board.grid
# basic hash view...

player1.ships
# shows the ships that we have

# Place Horizontal / Vertical??

player1.board.place(player1.ships[0], Coordinates.new(['A1', 'A2']))
# locations error
# is it supposed to remove the ship from player's use here?
# can allow to set twice
# can specify less cells/coords than the ship requires
# can overwrite other ships / can overlap other ships

# give player2 some ships as well

player1.shoot_at(player2.board, 'A1')

# if you shoot at water, it should be at Water.new class rather than :water
# that has been changed

`````