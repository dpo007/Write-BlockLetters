<#
.SYNOPSIS
    This script prints out block letters on the console.

.DESCRIPTION
    The script takes a string of text and prints it out in block letters on the console. 
    The block glyph, alignment, and color can be customized.

.PARAMETER Text
    The text to be printed in block letters.

.PARAMETER BlockGlyph
    The character to be used for the block letters. Default is "▓".

.PARAMETER UseCharacterAsGlyph
    If this switch is provided, each character in the text will be used as its own glyph (overrides the BlockGlyph parameter).

.PARAMETER Align
    The alignment of the text. Can be "Left", "Center", or "Right". Default is "Left".

.PARAMETER ForegroundColor
    The color of the text. Default is Gray.

.EXAMPLE
    .\Write-BlockLetters.ps1 -Text "Hello" -BlockGlyph "#" -Align "Center" -ForegroundColor "Yellow"
    This will print the text "Hello" in block letters, using "#" as the block glyph, centered, and in yellow color.

.NOTES
    Version:    1.0
    Author:     DPO
    Updated:    Nov. 2023

#>
param (
    [Parameter(Mandatory = $true)]
    [string]$Text,
    [string]$BlockGlyph = "▓",
    [switch]$UseCharacterAsGlyph,
    [ValidateSet("Left", "Center", "Right")]
    [string]$Align = "Left",
    [ConsoleColor]$ForegroundColor = [ConsoleColor]::Gray
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
        "# ## ",
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
        " ## ",
        " ## ",
        " ## ",
        "    ",
        " ## "
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
}

# Convert the input text to block letters and create an array of lines containing the block letters
$TextUpper = $Text.ToUpper()
$lines = for ($i = 0; $i -lt 5; $i++) {
    $line = foreach ($char in [char[]]$TextUpper) {
        $char = $char.ToString()
        $blockLine = if ($blockLetters.ContainsKey($char)) {
            $blockLetters[$char][$i] + " "
        }
        else {
            $blockLetters['?'][$i] + " "
        }
        $glyph = if ($UseCharacterAsGlyph) { $char } else { $BlockGlyph }
        $blockLine -replace "#", $glyph
    }
    $line -join ""
}

# Get the console width
$consoleWidth = $Host.UI.RawUI.WindowSize.Width

# Calculate the padding based on the chosen alignment and console width
switch ($Align) {
    "Left" {
        $leftPadding = 0
    }
    "Center" {
        $leftPadding = [Math]::Floor(($consoleWidth - ($Text.Length * 6)) / 2)
    }
    "Right" {
        $leftPadding = $consoleWidth - ($Text.Length * 6)
    }
}

# Write the lines to the console with the padding
$lines | ForEach-Object {
    $line = $_
    $line = ((" " * $leftPadding) + $line).TrimEnd()
    Write-Host $line -ForegroundColor $ForegroundColor
}