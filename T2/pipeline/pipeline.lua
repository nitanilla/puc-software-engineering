-- Título:				pipeline.lua		
-- Autor:				Renan Almeida & Gabriel Gomes
-- Última modificação:	03-05-2017
-- Versão: 				1.0
-- Tamanho: 			204 linhas

--[[
Recebe o caminho para um arquivo e retorna
o conteúdo do mesmo em formato de string.

PRE: path é um caminho para um arquivo
válido (verificado por assertiva).

POS: uma string com o conteúdo do arquivo
foi retornada.
--]]
function readFile(path)
	local file = assert(io.open(path, "r"))
	local data = file:read("*all")
	file:close()
	return data
end

--[[
Recebe uma string e retorna uma cópia da
mesma com todos os caracteres não-alfanuméricos
substituídos por espaços e os caracteres
alfanuméricos convertidos para caixa baixa.

PRE: data é uma string válida (verificado
por assertiva e pelas funções que manipulam
strings).

POS: uma string filtrada conforme a descrição
foi retornada.
--]]
function filterCharsAndNormalize(data)
	return data:gsub("%W", " "):lower()
end

--[[
Recebe uma string e retorna uma lista das
palavras contidas na mesma.

PRE: data é uma string válida (verificado
por assertiva e pelas funções que manipulam
strings).

POS: uma lista de palavras conforme a descrição
foi retornada.
--]]
function scan(data)
	assert(data ~= nil)
	local words = {}
	for word in data:gmatch("%S+") do
		table.insert(words, word)
	end
	return words
end

--[[
Recebe uma lista de palavras e retorna uma
cópia da mesma com todas as palavras ignoradas
(stop words) removidas.

PRE: words é uma lista de palavras válida (verificado
por assertiva e pelas funções que manipulam
tabelas) e o caminho "../stop_words.txt" contém
o arquivo com as palavras ignoradas (verificado
por assertiva).

POS: uma lista de palavras conforme a descrição
foi retornada.
--]]
function removeStopWords(words)
	assert(words ~= nil)

	-- Lendo arquivo stop_words.txt
	local file = assert(io.open("../stop_words.txt", "r"))
	local data = file:read("*all")
	file:close()

	-- Criando lista de stopWords
	local stopWords = {}
	for stopWord in data:gmatch("[^,]+") do
		table.insert(stopWords, stopWord:lower())
	end

	-- Criando uma lista filtrada sem stopWords
	local filteredWords = {}
	for _, word in ipairs(words) do
		for _, stopWord in ipairs(stopWords) do
			if word == stopWord then
				goto doNotInsert
			end
		end
		table.insert(filteredWords, word)
		::doNotInsert::
	end

	return filteredWords
end

--[[
Recebe uma lista de palavras e retorna um
dicionário de frequência de palavras, onde
a palavra é a chave e a frequência é o valor.

PRE: words é uma lista de palavras válida
(verificado por assertiva e pelas funções
que manipulam tabelas).

POS: um dicionário de palavras conforme a
descrição foi retornado.
--]]
function frequencies(words)
	assert(words ~= nil)
	local wordFrequencies = {}
	for _, word in ipairs(words) do
		if wordFrequencies[word] == nil then
			wordFrequencies[word] = 1
		else
			wordFrequencies[word] = wordFrequencies[word] + 1
		end
	end
	return wordFrequencies
end

--[[
Recebe um dicionário de frequência de
palavras (onde a palavra é a chave e
a frequência é o valor) e retorna uma
lista ordenada por frequência descendente.
A lista ordenada contém vetores, de forma
que o primeiro elemento é a palavra e
o segundo elemento é a frequência da mesma.

PRE: wordFrequencies é um dicionário de
palavras válido (verificado por assertiva
e pelas funções que manipulam tabelas).

POS: uma lista preenchida conforme a
descrição foi retornada.
--]]
function sort(wordFrequencies)
	assert(wordFrequencies ~= nil)

	-- Criando lista de palavras com frequências (não ordenado)
	local sortedWords = {}
	for word, frequency in pairs(wordFrequencies) do
		table.insert(sortedWords, {word, frequency})
	end

	-- Ordenando lista de palavras com frequências (decrescente)
	table.sort(sortedWords, function(a, b) return a[2] > b[2] end)

	return sortedWords
end

--[[
Recebe uma lista ordenada de vetores com
palavras e frequências. Imprime os x primeiros
elementos da lista no formato "palavra -
frequência", onde x = quantity.

PRE: sortedWords é uma lista válida (verificado
por assertiva e pelas funções que manipulam
tabelas) e quantity é um número inteiro
positivo (verificado por assertiva).

POS: as informações foram impressas conforme
a descrição.
--]]
function printQuantity(sortedWords, quantity)
	assert(sortedWords ~= nil)
	assert(quantity ~= nil)
	assert(quantity > 0)

	local counter = 1
	for _, value in ipairs(sortedWords) do
		print(value[1] .. " - " .. value[2])
		if counter == quantity then
			break
		end
		counter = counter + 1
	end
end

--[[
A função main chama, em sequência, todas as
outras funções que compõe a solução.
--]]
function main()
	local fileData = readFile(arg[1])
	local filteredAndNormalizedData = filterCharsAndNormalize(fileData)
	local words = scan(filteredAndNormalizedData)
	local filteredWords = removeStopWords(words)
	local wordFrequencies = frequencies(filteredWords)
	local sortedWords = sort(wordFrequencies)
	printQuantity(sortedWords, 25)
end

main()
--ver comentarios no pull-request (Roxana)
