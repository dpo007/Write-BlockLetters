# Write-BlockLetters.ps1

This PowerShell script prints out block letters on the console. It takes a string of text and prints it out in block letters on the console. The block glyph, alignment, and color can be customized.

## Parameters

- `Text`: The text to be printed in block letters.
- `BlockGlyph`: The character to be used for the block letters. Default is "▓".
- `UseCharacterAsGlyph`: If this switch is provided, each character in the text will be used as its own glyph (overrides the BlockGlyph parameter).
- `Align`: The alignment of the text. Can be "Left", "Center", or "Right". Default is "Left".
- `ForegroundColor`: The color of the text. Default is Gray.

## Example Usage

```powershell
.\Write-BlockLetters.ps1 -Text "Go PowerShell!" -BlockGlyph "#" -Align "Center" -ForegroundColor "Yellow"
```

## Example Output

```
 ▓▓▓   ▓▓▓     ▓▓▓▓   ▓▓▓  ▓   ▓ ▓▓▓▓▓ ▓▓▓▓   ▓▓▓▓ ▓   ▓ ▓▓▓▓▓ ▓     ▓      ▓▓
▓     ▓   ▓    ▓   ▓ ▓   ▓ ▓   ▓ ▓     ▓   ▓ ▓     ▓   ▓ ▓     ▓     ▓      ▓▓
▓  ▓▓ ▓   ▓    ▓▓▓▓  ▓   ▓ ▓ ▓ ▓ ▓▓▓▓  ▓▓▓▓   ▓▓▓  ▓▓▓▓▓ ▓▓▓▓  ▓     ▓      ▓▓
▓   ▓ ▓   ▓    ▓     ▓   ▓ ▓▓ ▓▓ ▓     ▓ ▓       ▓ ▓   ▓ ▓     ▓     ▓
 ▓▓▓   ▓▓▓     ▓      ▓▓▓  ▓   ▓ ▓▓▓▓▓ ▓  ▓▓ ▓▓▓▓  ▓   ▓ ▓▓▓▓▓ ▓▓▓▓▓ ▓▓▓▓▓  ▓▓
```