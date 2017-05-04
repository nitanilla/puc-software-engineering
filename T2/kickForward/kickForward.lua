#!/usr/bin/env lua

-- Título:				Kick Forward		
-- Autor:				Renan Almeida & Gabriel Gomes
-- Última modificação:	02-05-2017
-- Versão: 				1.0
-- Tamanho: 			156 linhas

-- Número de palavas mais frequentes que serão impressas
TOP = arg[2] or 25

-- Função lê um arquivo de entrada e retorna seu conteúdo em uma string.
-- PRE: O arquivo está presente no sistema de diretórios.
-- POS: O arquivo foi lido com sucesso e seu conteúdo foi retornado.
function readFile(path, func)
	local f = assert(io.open(path, "r"))
	local data = f:read("*all")
	f:close()
	func(data, normalize)
end

-- Função recebe uma string e retorna uma cópia com todos os caracteres
-- não alfanuméricos substituídos por um espaço em branco cada.
-- PRE: A string recebida por patâmetro representa o conteúdo de um arquivo e é não
-- vazia.
-- POS: A string recebida de entrada foi reformatada com sucesso.
function filterChars(data, func)
	func(data:gsub("%W+", " "), scan)
end

-- Função deixa todas as letras minúsculas.
-- PRE: A string a ser normalizada.
-- POS: A string já normalizada.
function normalize(data, func)
	func(data:lower(), removeStopWords)
end

-- Função recebe uma string e busca por palavras, retornando uma tabela com as
-- palavras encontradas.
-- PRE: A string recebida está formatada para ter apenas palavras em lowercase e
-- separadas por espaços.
-- POS: A tabela indexada pelas paravras foi criada.
function scan(data, func)
	local words = {}
	for word in data:gmatch("%S+") do
		table.insert(words, word)
	end
	func(words, frequencies)
end

-- Função retira as stop words de uma tabela de palavras.
-- PRE: Recebe uma tabela indexada por palavras.
-- POS: Retorna uma cópia da entrada com as stop words removidas.
function removeStopWords(words, func)
	local file = assert(io.open("../stop_words.txt", "r"))
	local data = file:read("*all")
	file:close()

	local stopWords = {}
	for stopWord in data:gmatch("[^,]+") do
		table.insert(stopWords, stopWord:lower())
	end

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

	func(filteredWords, sort)
end

-- Função recebe uma tabela de palavras e retorna um dicionário associando
-- palavras com suas frequências de ocorrência.
-- PRE: A tabela recebida têm as palavras a seren contadas.
-- POS: As palavras agora têm suas respectivas ordens de ocorrência.
function frequencies(word_list, func)
	local word_freqs = {}
	local word_freq = {}

	for _, word in pairs(word_list) do
		if word_freqs[word] then
			word_freqs[word] = word_freqs[word] + 1
		else
			word_freqs[word] = 1
		end
	end

	for word, freq in pairs(word_freqs) do
		local pair = {word = word, freq = freq}
		table.insert(word_freq, pair)
	end

	func(word_freq, printText)
end

-- Função recebe um dicionário de palavras e suas frequências e retorna um
-- dicionário de pares ordenados pela frequência.
-- PRE: O input é um dicionário que apresenta palavras e suas frequências, em
-- qualquer ordem.
-- POS: O dicionário está ordenado pela frequência.
function sort(word_freq, func)
	table.sort(word_freq, function(a, b) return a.freq > b.freq end)
	func(word_freq, noOp)
end

-- Função recebe um dicionário de pares em que as estradas estão ordenadas
-- por frequência e as imprime.
-- PRE: O dicionário de pares tem as palavras ordenadas pela frequência e o índice
-- da recursção.
-- POS: Terão sido impressos na tela as palavras e os suas frequências.
function printText(word_freqs, func)
    local i = 0
    
    for _, w in ipairs(word_freqs) do
    	if i == TOP then
    		break
    	end
    	print(w.word .. " - " .. w.freq)
    	i = i + 1
    end
    func(nil)
end

-- Funcão "base", fim das passagens de função.
-- PRE: Função sendo passada.
-- POS: Fim do empilhamento.
function noOp(func)
	return
end

readFile(arg[1], filterChars)
