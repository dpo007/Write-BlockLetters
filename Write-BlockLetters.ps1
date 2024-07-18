<#
.SYNOPSIS
    A script to write text in block letters.

.DESCRIPTION
    This script takes a string of text and displays it in block letters.
    It allows the user to specify the alignment (left, center, right) and the foreground and background colors for the text. Also, the user can specify the number of blank padding lines to add to the top and bottom of the text.

.PARAMETER Text
    The text to be displayed in block letters.

.PARAMETER Align
    The alignment of the text. Valid options are "Left", "Center", and "Right".
    Default is "Left".

.PARAMETER ForegroundColor
    The color of the text. Default is Gray.

.PARAMETER BackgroundColor
    The color of the background. Default is Black.

.PARAMETER VerticalPadding
    The number of blank lines to add to the top and bottom of the text. Default is 0.

.EXAMPLE
    PS C:\> .\Write-BlockLetters.ps1 -Text "Hello!" -Align "Center" -ForegroundColor "White" -BackgroundColor "Blue"
    This will display the text "Hello!" in block letters, centered, with white text on a blue background.

.NOTES
    Version:    1.7
    Author:     DPO
    Updated:    July 2024
#>
param (
    [Parameter(Mandatory = $true)]
    [string]$Text,
    [ValidateSet("Left", "Center", "Right")]
    [string]$Align = "Left",
    [ConsoleColor]$ForegroundColor = $Host.UI.RawUI.ForegroundColor,
    [ConsoleColor]$BackgroundColor = $Host.UI.RawUI.BackgroundColor,
    [int]$VerticalPadding = 0
)

# Define the mapping of characters to their block letter representations
$blockLetters = @{
    'A'  = @(
        "  #  ",
        " # # ",
        "#####",
        "#   #",
        "#   #"
    )
    'B'  = @(
        "#### ",
        "#   #",
        "#### ",
        "#   #",
        "#### "
    )
    'C'  = @(
        " ### ",
        "#   #",
        "#    ",
        "#   #",
        " ### "
    )
    'D'  = @(
        "#### ",
        "#   #",
        "#   #",
        "#   #",
        "#### "
    )
    'E'  = @(
        "#####",
        "#    ",
        "#### ",
        "#    ",
        "#####"
    )
    'F'  = @(
        "#####",
        "#    ",
        "#### ",
        "#    ",
        "#    "
    )
    'G'  = @(
        " ### ",
        "#    ",
        "#  ##",
        "#   #",
        " ### "
    )
    'H'  = @(
        "#   #",
        "#   #",
        "#####",
        "#   #",
        "#   #"
    )
    'I'  = @(
        "#####",
        "  #  ",
        "  #  ",
        "  #  ",
        "#####"
    )
    'J'  = @(
        "#####",
        "   # ",
        "   # ",
        "#  # ",
        " ##  "
    )
    'K'  = @(
        "#   #",
        "#  # ",
        "###  ",
        "#  # ",
        "#   #"
    )
    'L'  = @(
        "#    ",
        "#    ",
        "#    ",
        "#    ",
        "#####"
    )
    'M'  = @(
        "#   #",
        "## ##",
        "# # #",
        "#   #",
        "#   #"
    )
    'N'  = @(
        "#   #",
        "##  #",
        "# # #",
        "#  ##",
        "#   #"
    )
    'O'  = @(
        " ### ",
        "#   #",
        "#   #",
        "#   #",
        " ### "
    )
    'P'  = @(
        "#### ",
        "#   #",
        "#### ",
        "#    ",
        "#    "
    )
    'Q'  = @(
        " ### ",
        "#   #",
        "# # #",
        "#  # ",
        " ## #"
    )
    'R'  = @(
        "#### ",
        "#   #",
        "#### ",
        "# #  ",
        "#  ##"
    )
    'S'  = @(
        " ####",
        "#    ",
        " ### ",
        "    #",
        "#### "
    )
    'T'  = @(
        "#####",
        "  #  ",
        "  #  ",
        "  #  ",
        "  #  "
    )
    'U'  = @(
        "#   #",
        "#   #",
        "#   #",
        "#   #",
        " ### "
    )
    'V'  = @(
        "#   #",
        "#   #",
        "#   #",
        " # # ",
        "  #  "
    )
    'W'  = @(
        "#   #",
        "#   #",
        "# # #",
        "## ##",
        "#   #"
    )
    'X'  = @(
        "#   #",
        " # # ",
        "  #  ",
        " # # ",
        "#   #"
    )
    'Y'  = @(
        "#   #",
        " # # ",
        "  #  ",
        "  #  ",
        "  #  "
    )
    'Z'  = @(
        "#####",
        "   # ",
        "  #  ",
        " #   ",
        "#####"
    )
    '0'  = @(
        " ### ",
        "#   #",
        "# # #",
        "#   #",
        " ### "
    )
    '1'  = @(
        " # ",
        "## ",
        " # ",
        " # ",
        "###"
    )
    '2'  = @(
        " ### ",
        "#   #",
        "  ## ",
        " #   ",
        "#####"
    )
    '3'  = @(
        " ### ",
        "#   #",
        "  ## ",
        "#   #",
        " ### "
    )
    '4'  = @(
        "#  # ",
        "#  # ",
        "#####",
        "   # ",
        "   # "
    )
    '5'  = @(
        "#####",
        "#    ",
        "#### ",
        "    #",
        "#### "
    )
    '6'  = @(
        " ### ",
        "#    ",
        "#### ",
        "#   #",
        " ### "
    )
    '7'  = @(
        "#####",
        "   # ",
        "  #  ",
        " #   ",
        "#    "
    )
    '8'  = @(
        " ### ",
        "#   #",
        " ### ",
        "#   #",
        " ### "
    )
    '9'  = @(
        " ### ",
        "#   #",
        " ####",
        "    #",
        " ### "
    )
    '.'  = @(
        "   ",
        "   ",
        "   ",
        "   ",
        " # "
    )
    '?'  = @(
        " ### ",
        "#   #",
        "   # ",
        "     ",
        "  #  "
    )
    '!'  = @(
        "##",
        "##",
        "##",
        "  ",
        "##"
    )
    '$'  = @(
        " ### ",
        "# #  ",
        " ### ",
        "  # #",
        " ### "
    )
    '-'  = @(
        "    ",
        "    ",
        "####",
        "    ",
        "    "
    )
    '+'  = @(
        "   ",
        " # ",
        "###",
        " # ",
        "   "
    )
    '='  = @(
        "    ",
        "####",
        "    ",
        "####",
        "    "
    )
    '_'  = @(
        "    ",
        "    ",
        "    ",
        "    ",
        "####"
    )
    ' '  = @(
        "  ",
        "  ",
        "  ",
        "  ",
        "  "
    )
    '<'  = @(
        "  #",
        " # ",
        "#  ",
        " # ",
        "  #"
    )
    '>'  = @(
        "#  ",
        " # ",
        "  #",
        " # ",
        "#  "
    )
    '@'  = @(
        " ### ",
        "#   #",
        "# ###",
        "# # #",
        "# ###"
    )
    '#'  = @(
        " # # ",
        "#####",
        " # # ",
        "#####",
        " # # "
    )
    '%'  = @(
        "#   #",
        "   # ",
        "  #  ",
        " #   ",
        "#   #"
    )
    '^'  = @(
        " # ",
        "# #",
        "   ",
        "   ",
        "   "
    )
    '&'  = @(
        " ##  ",
        "#  # ",
        " ##  ",
        "#  # ",
        " ## #"
    )
    '*'  = @(
        "  #  ",
        "# # #",
        " ### ",
        "# # #",
        "  #  "
    )
    '('  = @(
        " #",
        "# ",
        "# ",
        "# ",
        " #"
    )
    ')'  = @(
        "# ",
        " #",
        " #",
        " #",
        "# "
    )
    ':'  = @(
        " ",
        "#",
        " ",
        "#",
        " "
    )
    ';'  = @(
        "  ",
        " #",
        "  ",
        " #",
        "# "
    )
    ','  = @(
        "  ",
        "  ",
        "  ",
        " #",
        "# "
    )
    '''' = @(
        " #",
        "# ",
        "  ",
        "  ",
        "  "
    )
    '"'  = @(
        " # # ",
        " # # ",
        "     ",
        "     ",
        "     "
    )
}

# Convert the input text to block letters and create an array of lines containing the block letters
$TextUpper = $Text.ToUpper()
$lines = for ($i = 0; $i -lt 5; $i++) {
    $line = foreach ($char in [char[]]$TextUpper) {
        $char = $char.ToString()
        if ($blockLetters.ContainsKey($char)) {
            $blockLetters[$char][$i] + " "
        }
        else {
            $blockLetters['?'][$i] + " "
        }
    }
    # Join the line array into a string and trim the last character
    $joinedLine = $line -join ""
    $joinedLine.Substring(0, $joinedLine.Length - 1)
}

# Get width of the longest line (as integer)
$longestLine = ($lines | Measure-Object -Property Length -Maximum).Maximum

# Add blank vertical padding lines to the top and bottom $lines array that are as wide as the longest line.
for ($i = 0; $i -lt $VerticalPadding; $i++) {
    $lines = @(" " * $longestLine) + $lines + @(" " * $longestLine)
}

# Get the console width
$consoleWidth = $Host.UI.RawUI.WindowSize.Width

# Calculate the padding based on the chosen alignment and console width
switch ($Align) {
    "Left" {
        $leftPadding = 0
    }
    "Center" {
        $leftPadding = [Math]::Floor(($consoleWidth - $longestLine) / 2)
        if ($leftPadding -lt 0) {
            $leftPadding = 0
        }
        $rightPadding = $consoleWidth - $longestLine - $leftPadding
        if ($rightPadding -lt 0) {
            $rightPadding = 0
        }
    }
    "Right" {
        $leftPadding = $consoleWidth - $longestLine
    }
}

if ($consoleWidth -lt ($longestLine + 2)) {
    # If the console width is less than the longest line plus 2, return false
    return $false
}
else {
    # Write the text to the console as block characters, line by line.
    $lines | ForEach-Object {
        $line = $_

        if ($Align -eq "Center") {
            # Right padding is added so we can fill it with spaces/background colour when using centered alignment.
            $line = (" " * $leftPadding) + $line + (" " * $rightPadding)
        }
        else {
            $line = (" " * $leftPadding) + $line
        }

        # If $line is empty (i.e. all spaces), write the line as a whole
        if ($line.Trim().Length -eq 0) {
            Write-Host $line -NoNewline -BackgroundColor $BackgroundColor
        }
        else {
            # Write the line to the console, character by character
            for ($i = 0; $i -lt $line.Length; $i++) {
                $char = $line[$i]

                # If the character is a space, write a space with the background color, otherwise write a space with the foreground color (to represent a lit pixel in the character).
                if ($char -eq " ") {
                    Write-Host " " -NoNewline -BackgroundColor $BackgroundColor
                }
                else {
                    Write-Host " " -NoNewline -BackgroundColor $ForegroundColor
                }
            }
        }

        # Add New Line to end.
        Write-Host
    }
}