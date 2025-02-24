-- theme identification file

themeInfo = {
	Name = "Kolili (etterna 0.74.0)",
	Version = "0.1.2", -- a.b.c, a for complete overhauls, b for major releases, c for minor additions/bugfix.
	Date = "20241225",
}

function getThemeName()
	return themeInfo["Name"]
end

function getThemeVersion()
	return themeInfo["Version"]
end

function getThemeDate()
	return themeInfo["Date"]
end
