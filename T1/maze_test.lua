-- TITLE:		Maze Test
-- AUTHOR:		Renan Almeida
-- DATE:		10/04/2017
-- VERSION: 	1.0
-- CONTENT: 	~25 lines  

dofile "maze.lua"

-- O teste cria três labirintos de tamanhos diferentes e imprime eles na tela.

-- Maze 1
local maze = Maze:new(5, 5)
local bats, pits, diamonds = 5, 2, 1
local r = maze:populate(bats, pits, diamonds)
maze:print()

-- Maze 2
local maze = Maze:new(10, 10)
local bats, pits, diamonds = 10, 12, 1
local r = maze:populate(bats, pits, diamonds)
maze:print()

-- Maze 3
local maze = Maze:new(15, 15)
local bats, pits, diamonds = 1, 1, 1
local r = maze:populate(bats, pits, diamonds)
maze:print()
