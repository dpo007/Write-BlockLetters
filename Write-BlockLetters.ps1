<#
.SYNOPSIS
    A script to write text in block letters.

.DESCRIPTION
    This script takes a string of text and displays it in block letters. 
    It allows the user to specify the alignment (left, center, right) and the foreground and background colors for the text.

.PARAMETER Text
    The text to be displayed in block letters.

.PARAMETER Align
    The alignment of the text. Valid options are "Left", "Center", and "Right". 
    Default is "Left".

.PARAMETER ForegroundColor
    The color of the text. Default is Gray.

.PARAMETER BackgroundColor
    The color of the background. Default is Black.

.EXAMPLE
    PS C:\> .\Write-BlockLetters.ps1 -Text "Hello!" -Align "Center" -ForegroundColor "White" -BackgroundColor "Blue"
    This will display the text "Hello!" in block letters, centered, with white text on a blue background.

.NOTES
    Version:    1.3
    Author:     DPO
    Updated:    Nov. 2023
#>
param (
    [Parameter(Mandatory = $true)]
    [string]$Text,
    [ValidateSet("Left", "Center", "Right")]
    [string]$Align = "Left",
    [ConsoleColor]$ForegroundColor = [ConsoleColor]::Gray,
    [ConsoleColor]$BackgroundColor = [ConsoleColor]::Black
)

# Define the mapping of characters to their block letter representations
$blockLetters = @{
    'A' = @(
        "  #  ",
        " # # ",
        "#####",
        "#   #",
        "#   #"
    )
    'B' = @(
        "#### ",
        "#   #",
        "#### ",
        "#   #",
        "#### "
    )
    'C' = @(
        " ### ",
        "#   #",
        "#    ",
        "#   #",
        " ### "
    )
    'D' = @(
        "#### ",
        "#   #",
        "#   #",
        "#   #",
        "#### "
    )
    'E' = @(
        "#####",
        "#    ",
        "#### ",
        "#    ",
        "#####"
    )
    'F' = @(
        "#####",
        "#    ",
        "#### ",
        "#    ",
        "#    "
    )
    'G' = @(
        " ### ",
        "#    ",
        "#  ##",
        "#   #",
        " ### "
    )
    'H' = @(
        "#   #",
        "#   #",
        "#####",
        "#   #",
        "#   #"
    )
    'I' = @(
        "#####",
        "  #  ",
        "  #  ",
        "  #  ",
        "#####"
    )
    'J' = @(
        "#####",
        "   # ",
        "   # ",
        "#  # ",
        " ##  "
    )
    'K' = @(
        "#   #",
        "#  # ",
        "###  ",
        "#  # ",
        "#   #"
    )
    'L' = @(
        "#    ",
        "#    ",
        "#    ",
        "#    ",
        "#####"
    )
    'M' = @(
        "#   #",
        "## ##",
        "# # #",
        "#   #",
        "#   #"
    )
    'N' = @(
        "#   #",
        "##  #",
        "# # #",
        "#  ##",
        "#   #"
    )
    'O' = @(
        " ### ",
        "#   #",
        "#   #",
        "#   #",
        " ### "
    )
    'P' = @(
        "#### ",
        "#   #",
        "#### ",
        "#    ",
        "#    "
    )
    'Q' = @(
        " ### ",
        "#   #",
        "# # #",
        "#  # ",
        " ## #"
    )
    'R' = @(
        "#### ",
        "#   #",
        "#### ",
        "# #  ",
        "#  ##"
    )
    'S' = @(
        " ####",
        "#    ",
        " ### ",
        "    #",
        "#### "
    )
    'T' = @(
        "#####",
        "  #  ",
        "  #  ",
        "  #  ",
        "  #  "
    )
    'U' = @(
        "#   #",
        "#   #",
        "#   #",
        "#   #",
        " ### "
    )
    'V' = @(
        "#   #",
        "#   #",
        "#   #",
        " # # ",
        "  #  "
    )
    'W' = @(
        "#   #",
        "#   #",
        "# # #",
        "## ##",
        "#   #"
    )
    'X' = @(
        "#   #",
        " # # ",
        "  #  ",
        " # # ",
        "#   #"
    )
    'Y' = @(
        "#   #",
        " # # ",
        "  #  ",
        "  #  ",
        "  #  "
    )
    'Z' = @(
        "#####",
        "   # ",
        "  #  ",
        " #   ",
        "#####"
    )
    '0' = @(
        " ### ",
        "#   #",
        "# # #",
        "#   #",
        " ### "
    )
    '1' = @(
        "  #  ",
        " ##  ",
        "  #  ",
        "  #  ",
        "#####"
    )
    '2' = @(
        " ### ",
        "#   #",
        "  ## ",
        " #   ",
        "#####"
    )
    '3' = @(
        " ### ",
        "#   #",
        "  ## ",
        "#   #",
        " ### "
    )
    '4' = @(
        "#  # ",
        "#  # ",
        "#####",
        "   # ",
        "   # "
    )
    '5' = @(
        "#####",
        "#    ",
        "#### ",
        "    #",
        "#### "
    )
    '6' = @(
        " ### ",
        "#    ",
        "#### ",
        "#   #",
        " ### "
    )
    '7' = @(
        "#####",
        "   # ",
        "  #  ",
        " #   ",
        "#    "
    )
    '8' = @(
        " ### ",
        "#   #",
        " ### ",
        "#   #",
        " ### "
    )
    '9' = @(
        " ### ",
        "#   #",
        " ####",
        "    #",
        " ### "
    )
    '.' = @(
        "   ",
        "   ",
        "   ",
        "   ",
        " # "
    )
    '?' = @(
        " ### ",
        "#   #",
        "   # ",
        "     ",
        "  #  "
    )
    '!' = @(
        "##",
        "##",
        "##",
        "  ",
        "##"
    )
    '$' = @(
        " ### ",
        "# #  ",
        " ### ",
        "  # #",
        " ### "
    )
    '-' = @(
        "    ",
        "    ",
        "####",
        "    ",
        "    "
    )
    ' ' = @(
        "  ",
        "  ",
        "  ",
        "  ",
        "  "
    )
    '<' = @(
        "  #",
        " # ",
        "#  ",
        " # ",
        "  #"
    )
    '>' = @(
        "#  ",
        " # ",
        "  #",
        " # ",
        "#  "
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
    # Join the line array into a string once and trim the last character
    $joinedLine = $line -join ""
    $joinedLine.Substring(0, $joinedLine.Length - 1)
}

# Get width of the longest line (as integer)
$longestLine = ($lines | Measure-Object -Property Length -Maximum).Maximum

# Get the console width
$consoleWidth = $Host.UI.RawUI.WindowSize.Width

# Calculate the padding based on the chosen alignment and console width
switch ($Align) {
    "Left" {
        $leftPadding = 0
    }
    "Center" {
        $leftPadding = [Math]::Floor(($consoleWidth - $longestLine) / 2)
        $rightPadding = $consoleWidth - $longestLine - $leftPadding
    }
    "Right" {
        $leftPadding = $consoleWidth - $longestLine
    }
}

# Write the lines to the console with the padding
$lines | ForEach-Object {
    $line = $_
    if ($Align -eq "Center") {
        # Right padding is added so we can fill it with spaces/background colour when using centered alignment.
        $line = (" " * $leftPadding) + $line + (" " * $rightPadding)
    }
    else {
        $line = (" " * $leftPadding) + $line
    }

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

    # Add New Line to end.
    Write-Host
}