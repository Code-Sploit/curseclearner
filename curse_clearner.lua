curses = {"shit"}

function calculate_replace_tokens(curse)
	local tokens = ""
	local curselength = string.len(curse)

	for i = 1, curselength do
		tokens = tokens .. "*"
	end
	
	return tokens
end

function file_exists(filename)
	local file = io.open(filename, "r")

	if not file then return false end

	file:close()

	return true
end

function file_readlines(filename)
	if not file_exists(filename) then return end

	local lines = {}

	for line in io.lines(filename) do
		lines[#lines + 1] = line
	end

	return lines
end

function write_final_lines(filename, lines)
	if not file_exists(filename) then return end

	local file = io.open(filename, "w")

	file:write("")

	file:close()
	
	local file2 = io.open(filename, "a")

	for index, line in pairs(lines) do
		file2:write(line)
		file2:write("\n")
	end

	file2:close()
end

function main(filename, cursefile)
	if not filename or cursefile then return end

	local lines = file_readlines(filename)
	local final_lines = {}

	for index, line in pairs(lines) do
		for cindex, curse in pairs(curses) do
			if string.match(line, curse) then
				local replace_data = calculate_replace_tokens(curse)

				local cleaned_line = line:gsub(curse, replace_data)

				final_lines[#final_lines + 1] = cleaned_line
			else
				final_lines[#final_lines + 1] = line
			end
		end
	end

	write_final_lines(filename, final_lines)
end

main(arg[1], arg[2])
