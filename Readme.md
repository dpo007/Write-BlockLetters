# Write-BlockLetters.ps1

This PowerShell script prints out block letters on the console. It takes a string of text and prints it out in block letters on the console. The alignment, forground and background colours can be customized.

## Parameters

- `Text`: The text to be printed in block letters.
- `Align`: The alignment of the text. Can be "Left", "Center", or "Right". Default is "Left".
- `VerticalPadding`: The number of blank lines to add to the top and bottom of the output. Default is 0.
- `ForegroundColor`: The colour of the text. Default is Gray.
- `BackgroundColor`: The background colour of the text. Default is Black.

## Example Usage

```powershell
.\Write-BlockLetters.ps1 -Text "Go PowerShell!" -Align Center -ForegroundColor White -BackgroundColor Blue
```

## Example Output

!["Go PowerShell" example output](OutputExample.png)