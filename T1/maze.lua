-- TITLE:		Maze
-- AUTHOR:		Renan Almeida
-- DATE:		09/04/2017
-- VERSION: 	1.1
-- CONTENT: 	~120 lines  

-- Maze class
Maze = {}

--[[

Construtor da classe Maze.

PRE-CONDIÇÕES: Os parâmetros passados são números inteiros maiores que zero.

POS-CONDIÇÕES: Uma instância da classe maze foi correntamente inicializada.

--]]
function Maze:new(numberOfRows, numberOfColumns)
	-- Basic initialization
	local matrix = {}
	for i = 1, numberOfRows do
		matrix[i] = {}
		for j = 1, numberOfColumns do
			matrix[i][j] = " "
		end
	end

	-- Variables
	local instance = {
		-- Variables with underline are to be accessed outside this module
		-- at the programmers own risk. They are considered private by the
		-- Maze class.
		_numberOfRows = numberOfRows,
		_numberOfColumns = numberOfColumns,
		_matrix = matrix,
		_startingPosition = {
			i = 1,
			j = 1
		}
	}

	-- Lua class implementation
	setmetatable(instance, self)
	self.__index = self

	return instance
end

--[[

Função responsável por inserir a quantidade dada de morcegos, abismos e
diamantes em posições randômicas no labirinto.

PRE-CONDIÇÕES: O labirinto foi corretamente inicializado e os parâmetros
passados são números inteiros não negativos.

POS-CONDIÇÕES: O labirinto possuirá a quantidade passada de morcegos, abismos
e diamantes.

--]]
function Maze:populate(bats, pits, diamonds)
	-- If the quantity of any element is negative, returns false
	if bats < 0 or pits < 0 or diamonds < 0 then
		return false
	end

	-- If the maze is not large enough, returns false
	local numberOfElements = bats + pits + diamonds
	if (numberOfElements >= self._numberOfRows * self._numberOfColumns) then
		return false
	end

	local elements, index = {}, 1

	-- Auxiliary function used to fill the maze
	local fill = function (number, symbol)
		for i = 1, number do elements[index] = symbol; index = index + 1 end
	end

	fill(bats, "B")
	fill(pits, "P")
	fill(diamonds, "D")

	-- Fills the maze with bats, pits and diamonds
	math.randomseed(os.time())
	for i = 1, numberOfElements do
		local randomRow = math.random(self._numberOfRows)
		local randomColumn = math.random(self._numberOfColumns)
		self._matrix[randomRow][randomColumn] = elements[i]
	end
end

--[[

Função responsável por imprimir o estado corrente do labirinto.

PRE-CONDIÇÕES: O labirinto foi corretamente inicializado.

POS-CONDIÇÕES: Uma representação ASCII do labirinto será imprimida na tela.

--]]
function Maze:print()
	for i = 1, self._numberOfRows do
		for j = 1, self._numberOfColumns do
			io.write(self._matrix[i][j])
			if j ~= self._numberOfColumns then io.write("-") end
		end
		io.write("\n")
		if i ~= self._numberOfRows then
			for j = 1, 2 * self._numberOfColumns do
				if j % 2 ~= 0 then
					io.write("|")
				else
					io.write(" ")
				end
			end
			io.write("\n")
		end
	end
end
