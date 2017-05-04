-- Título:				monolith.lua		
-- Autor:				Renan Almeida & Gabriel Gomes
-- Última modificação:	04-05-2017
-- Versão: 				1.1
-- Tamanho: 			TODO

--[[
Observações

- Como o estilo monolito não permite a criação de
funções auxiliares, não é possível atender o critério da
modularidade.

- O programa ao ser executado demora bastante tempo
para processar todo o livro Pride & Prejudice. Para
um teste rápido é melhor usar o arquivo input_test.txt.

--]] 

-- Criando a lista de stopWords
stopWordsFile = assert(io.open("../stop_words.txt", "r"))
stopWords = {}
for stopWord in string.gmatch(stopWordsFile:read("*all"), "[^,]+") do
	table.insert(stopWords, stopWord:lower())
end
stopWordsFile:close()

-- Abrindo o arquivo principal
file = assert(io.open(arg[1], "r"))

-- Inicializando a lista global de pares [palavra, frequência]
wordsFreqs = {}

-- Itera sobre o arquivo uma linha por vez
while true do
	-- Lendo a linha e checando a condição de parada
	local line = file:read("*l") -- lê uma linha
	if line == nil then
		break
	end
	line = line .. "\n"

	local startChar = 0
    local i = 1

    -- Conferindo caracter por caracter
	for c in line:gmatch(".") do
		-- print("Char: " .. c .. " - i: " .. i)

		local isAlphaNumeric = c:match("%w") ~= nil
		-- print("IsAlpha: " .. tostring(isAlphaNumeric))

		-- Se é início de uma palavra
		if startChar == 0 and isAlphaNumeric then
			-- print("Início de palavra")
			startChar = i

		-- Se é o final de uma palavra
		elseif not isAlphaNumeric then
			-- print("Final: " .. line .. "\nrange: " .. startChar .. "-" .. i - 1)
			local word = string.sub(line, startChar, i - 1):lower()

			-- Conferindo se é stopWord
			local isNotStopWord = true
			for _, stopWord in ipairs(stopWords) do
				if word == stopWord then
					isNotStopWord = false
					break
				end
			end

			-- print("É stopWord: " .. tostring(not isNotStopWord))
			-- print("Palavra: " .. word)

			-- Se não é stopWord então processa a palavra
			if isNotStopWord then
				local pairIndex = 1
				local found = false

				-- Conferindo se a palavra já existe na lista
				for _, pair in ipairs(wordsFreqs) do
					if word == pair[1] then
						pair[2] = pair[2] + 1 -- incrementando frequência
						found = true
						break
					end
					pairIndex = pairIndex + 1
				end

				if not found then
					table.insert(wordsFreqs, {word, 1})
				elseif #wordsFreqs > 1 then
					-- Reordenando
					table.sort(wordsFreqs, function(a, b)
						return a[2] > b[2]
					end)
				end
			end

			-- Resetando
			startChar = 0
			-- print()
		end

		i = i + 1
	end

	-- print()
end

file:close()

for _, v in ipairs(wordsFreqs) do
    print(v[1] .. " - " .. v[2])
    if i == 25 then
    	break
    end
end
