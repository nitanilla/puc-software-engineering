
-- Maze class
Maze = {}

-- Constructor
function Maze:new(numberOfRows, numberOfColumns)
	-- Basic initialization
	local matrix = {}
	for i = 1, numberOfRows do
		matrix[i] = {}
		for j = 1, numberOfColumns do
			matrix[i][j] = {}
		end
	end

	-- Variables
	local instance = {
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

-- Populates de maze
function Maze:populate(numberOfWumpus, numberOfBats, numberOfPits, numberOfGoldNuggets)
	-- If the quantity of any element is negative, returns false
	local numberOfElements = numberOfWumpus + numberOfBats + numberOfPits
	if numberOfWumpus < 0 or numberOfBats < 0 or numberOfPits < 0 or numberOfGoldNuggets < 0 then
		return false
	end

	-- If the maze is not large enough, returns false
	if (numberOfElements >= self._numberOfRows * self._numberOfColumns) then
		return false
	end

	local elementArray, number = {}, 1

	-- Wumpus
	for i = 1, numberOfWumpus do
		elementArray[number] = "W"
		number = number + 1
	end

	-- Bats
	for i = 1, numberOfBats do
		elementArray[number] = "B"
		number = number + 1
	end

	-- Pits
	for i = 1, numberOfPits do
		elementArray[number] = "P"
		number = number + 1
	end

	-- Fills the maze with wumpus, bats and pits
	for i = 1, numberOfElements do
		local randomRow, randomColumn
		repeat
			randomRow = math.random(self._numberOfRows)
			randomColumn = math.random(self._numberOfColumns)
		until (length(self._matrix[randomRow][randomColumn]) > 0) or
			(randomRow == self._startingPosition.i and
			randomColumn == self._startingPosition.j)

		local room = self._matrix[randomRow][randomColumn]
		room[length(room) + 1] = elementArray[i]
	end

	return true
end

-- Prints the maze
function Maze:print()
	for i = 1, self._numberOfRows do
		for j = 1, self._numberOfColumns do
			-- print(self._matrix[i][j])
			for k, v in pairs(self._matrix[i][j]) do
			   print(k, v)
			end
		end
		io.write("\n")
	end
end

-- Auxialiary

-- Table length
function length(t)
	local counter = 0
	for _, _ in ipairs(t) do counter = counter + 1 end
	return counter
end


