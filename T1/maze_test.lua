
-- Imports
dofile "maze.lua"

-- Maze tests
do
	do -- Constructor
		local numberOfRows, numberOfColumns = 4, 4
		local maze = Maze:new(numberOfRows, numberOfColumns)

		-- _numberOfRows
		assert(maze._numberOfRows == numberOfRows, "Maze - Error - _numberOfRows")

		-- _numberOfColumns
		assert(maze._numberOfRows == numberOfColumns, "Maze - Error - _numberOfColumns")

		-- _matrix
		for i = 1, numberOfRows do
			for j = 1, numberOfRows do
				assert(maze._matrix[i][j], "Maze - Error - _matrix " .. i .. j)
			end
		end
	end

	do -- Populate
		do -- OK
			local numberOfRows, numberOfColumns = 4, 4
			local maze = Maze:new(numberOfRows, numberOfColumns)
			local numberOfWumpus, numberOfBats, numberOfPits, numberOfGoldNuggets = 1, 2, 2, 1
			local r = maze:populate(numberOfWumpus, numberOfBats, numberOfPits, numberOfGoldNuggets)
			assert(r == true, "Maze - Error - populate")
			maze:print()
		end

		do -- Quantity of any element is negative
			local numberOfRows, numberOfColumns = 4, 4
			local maze = Maze:new(numberOfRows, numberOfColumns)
			local numberOfWumpus, numberOfBats, numberOfPits, numberOfGoldNuggets = 1, -2, 4, -1
			local r = maze:populate(numberOfWumpus, numberOfBats, numberOfPits, numberOfGoldNuggets)
			assert(r == false, "Maze - Error - populate - Quantity of any element is negative")
		end

		do -- Number of elements is too big
			local numberOfRows, numberOfColumns = 2, 2
			local maze = Maze:new(numberOfRows, numberOfColumns)
			local numberOfWumpus, numberOfBats, numberOfPits, numberOfGoldNuggets = 1, 2, 2, 1
			local r = maze:populate(numberOfWumpus, numberOfBats, numberOfPits, numberOfGoldNuggets)
			assert(r == false, "Maze - Error - populate - Number of elements is too big")
		end
	end
end
