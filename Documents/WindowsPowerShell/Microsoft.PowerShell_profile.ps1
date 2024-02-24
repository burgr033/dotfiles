using namespace System.Management.Automation
#Import-Module PSFzf
Import-Module PSReadLine   #, PSfzf

#Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
#Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Register-ArgumentCompleter -CommandName ssh,scp,sftp -Native -ScriptBlock {
	param($wordToComplete, $commandAst, $cursorPosition)


	function Get-SSHHostList($sshConfigPath)
	{
		Get-Content -Path $sshConfigPath `
		| Select-String -Pattern '^Host ' `
		| ForEach-Object { $_ -replace 'Host ', '' } `
		| ForEach-Object { $_ -split ' ' } `
		| Sort-Object -Unique `
		| Select-String -Pattern '^.*[*!?].*$' -NotMatch
	}
	
	function Get-SSHConfigFileList ($sshConfigFilePath)
 {
		$sshConfigDir = Split-Path -Path $sshConfigFilePath -Resolve -Parent
	
		$sshConfigFilePaths = @()
		$sshConfigFilePaths += $sshConfigFilePath
	
		Get-Content -Path $sshConfigFilePath `
		| Select-String -Pattern '^Include ' `
		| ForEach-Object { $_ -replace 'Include ', '' }  `
		| ForEach-Object { $_ -replace '~', $Env:USERPROFILE } `
		| ForEach-Object { $_ -replace '\$Env:USERPROFILE', $Env:USERPROFILE } `
		| ForEach-Object { $_ -replace '\$Env:HOMEPATH', $Env:USERPROFILE } `
		| ForEach-Object { 
			$sshConfigFilePaths += $(Get-ChildItem -Path $sshConfigDir\$_ -File -ErrorAction SilentlyContinue -Force).FullName `
			| ForEach-Object { Get-SSHConfigFileList $_ } 
		}
	
		if (($sshConfigFilePaths.Length -eq 1) -and ($sshConfigFilePaths.item(0) -eq $sshConfigFilePath) )
		{
			return $sshConfigFilePath
		}
	
		return $sshConfigFilePaths | Sort-Object -Unique
	}

	$sshPath = "$Env:USERPROFILE\.ssh"
	$hosts = Get-SSHConfigFileList "$sshPath\config" `
	| ForEach-Object { Get-SSHHostList $_ } `

	# For now just assume it's a hostname.
	$textToComplete = $wordToComplete
	$generateCompletionText = {
		param($x)
		$x
	}
	if ($wordToComplete -match "^(?<user>[-\w/\\]+)@(?<host>[-.\w]+)$")
	{
		$textToComplete = $Matches["host"]
		$generateCompletionText = {
			param($hostname)
			$Matches["user"] + "@" + $hostname
		}
	}

	$hosts `
	| Where-Object { $_ -like "${textToComplete}*" } `
	| ForEach-Object { [CompletionResult]::new((&$generateCompletionText($_)), $_, [CompletionResultType]::ParameterValue, $_) }
}

Set-Alias ll ls
remove-alias r
function batcat
{
	bat --plain $args
}

function Randomize-List
{
	Param(
		[array]$InputList
	)
	if (!$InputList)
	{
		[array]$InputList = @()
		do
		{
			$inp = Read-Host "Input"
			if ($inp -ne "")
			{
				$inputlist += $inp
			}
		}while($inp -ne "")
		
	}
	return $InputList | Get-Random -Count $InputList.Count;
}

# PSReadLine
if($PSVersionTable.PSEdition -ne "Desktop"){
	Import-Module Terminal-Icons
	Set-PSReadLineOption -EditMode Windows
	Set-PSReadLineOption -BellStyle None
	Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
	Set-PSReadLineOption -PredictionSource History
	Set-PSReadlineKeyHandler -Chord UpArrow   -Function HistorySearchBackward
	Set-PSReadlineKeyHandler -Chord DownArrow -Function HistorySearchForward
	Set-PSReadLineKeyHandler -Chord Ctrl+f    -Function ForwardWord
	Set-PSReadLineKeyHandler -Chord Ctrl+k    -Function CaptureScreen
	Set-PSReadlineKeyHandler -Chord Ctrl+Tab  -Function Complete
	Set-PSReadlineKeyHandler -Chord Ctrl+q    -Function YankLastArg
	Set-PSReadLineKeyHandler -Chord Ctrl+u    -Function RevertLine
}
# Fzf
#Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

$prompt_user = $ENV:USERNAME
$prompt_host = $($ENV:COMPUTERNAME).tolower()
$global:last_dir = ""
$global:last_prompt = ""
$global:repro_commands = @("git","nvim")
function prompt
{
	$curpath = ""
	$curpath = $PWD -replace [Regex]::Escape((Get-PsProvider 'FileSystem').Home), "~"
	if (($curpath -ne $global:last_dir) -or ($^ -in $global:repro_commands))
	{
		$isgitdir = git rev-parse --is-inside-work-tree 2>$Null
		$prompt_col = @(
			[PSCustomObject]@{
				String = "╭─"
				Colour = "White"
			},
			[PSCustomObject]@{
				String = "$prompt_user@$prompt_host"
				Colour = "Green"
			},
			[PSCustomObject]@{
				String = " $curpath "
				Colour = "Blue"
			}
		)
		if($isgitdir -eq "true")
		{
			$git_branch = $(git branch --show-current)
	
			$prompt_col += [PSCustomObject]@{
				String = "‹$git_branch"
				Colour = "Yellow"
			}	
		
			if($(git status --porcelain))
			{
		
				$prompt_col += [PSCustomObject]@{
					String = "●"
					Colour = "Red"
				}	
		
			}
		
			$prompt_col += [PSCustomObject]@{
				String = "›"
				Colour = "Yellow"
			}	
		}
		$prompt_col += [PSCustomObject]@{
			String = " `n╰─`$"
			Colour = "White"
		}
		$global:last_prompt = $prompt_col
		foreach($item in $prompt_col)
		{ Write-Host $item.String -ForegroundColor $item.Colour -NoNewLine
		}
	} else
	{
		foreach($item in $global:last_prompt)
		{ Write-Host $item.String -ForegroundColor $item.Colour -NoNewLine
		}

	}
	$global:last_dir = $curpath
	return " "
}
