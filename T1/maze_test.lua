-- TITLE:		Maze Test
-- AUTHOR:		Renan Almeida
-- DATE:		10/04/2017
-- VERSION: 	1.0
-- CONTENT: 	~25 lines  

dofile "maze.lua"

-- O teste cria três labirintos de tamanhos diferentes e imprime eles na tela.

io.write("\nTrês labirintos de diferentes tamanhos encontram-se\n" ..
	"imprimidos abaixo:\n\n")

io.write("Legenda:\n" ..
	"- B: morcego (bat)\n" ..
	"- P: abismo (pit)\n" ..
	"- D: diamante (diamond)\n\n")

-- Auxiliary function that prints the maze
function printmaze(i, maze, n, bats, pits, diamonds)
	io.write("Labirinto " .. i .. " (" .. n .. "x" .. n .. ") com " .. bats ..
		" morcego(s), " .. pits .. " abismo(s) e " .. diamonds ..
		" diamante(s):\n")
	maze:print()
	io.write("\n")
end

-- Maze 1
local maze = Maze:new(3, 3)
local bats, pits, diamonds = 5, 2, 1
local r = maze:populate(bats, pits, diamonds)
printmaze(1, maze, 3, bats, pits, diamonds)


-- Maze 2
local maze = Maze:new(10, 10)
local bats, pits, diamonds = 10, 12, 1
local r = maze:populate(bats, pits, diamonds)
printmaze(2, maze, 10, bats, pits, diamonds)

-- Maze 3
local maze = Maze:new(7, 7)
local bats, pits, diamonds = 1, 1, 1
local r = maze:populate(bats, pits, diamonds)
printmaze(3, maze, 7, bats, pits, diamonds)
