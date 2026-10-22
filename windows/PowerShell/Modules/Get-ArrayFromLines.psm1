<# 
	.SYNOPSIS
	Enables you to take multi line strings or "lists" and convert them into an array within PowerShell
	
	Ensure that you add the " to the first entry and the last entry
	
	I recommend -string "<ctrl-v> "
	
	.Description 
	This function will let you take lists of strings and convert them to PowerShell arrays easily. 
	As an example, you can take an email with every user on a new line and use this function to 
	convert that list into a PowerShell array, or after filtering around in excel you can copy and paste
	the selected entries into the PowerShell terminal.
	
	.PARAMETER  VariableName
	The name of the array to be created
	do not specify the "$" when creating this variable.
	
	.PARAMETER String
	The "list" (string) to utilize to create the array, ensure the following:
	1. You are not using a new line before the first entry
	2. Ensure that the entire pasted list is enclosed in weak quotes (double quotation marks) (")
	Placing one immediately before the first entry and immediately after the last

	.Example
    PS> Get-ArrayFromLines -VariableName hosts -String "Jeremy
	>> Richard
	>> James"

	PS> $hosts
	Jeremy
	Richard
	James
	
	PS>  $hosts[1]
	Richard
	
	.Notes
	Created By 		::      Adam Bobbie
	Created On 		::      2026-04-14
	Modified on 	::  	2026-10-19
	Modification 	::  	Added comment-based help headers for public release
	Version 		::      1.1
	GitHub 			::      github.com/bobbienet

#>

	function Get-ArrayFromLines {
		#Define the parameters
		param(
			#The name of the variable to be created (in examples "hosts" will create $hosts)
			[Parameter(Mandatory)]
			[string]$VariableName,
			
			#The multi-line string ("list") to use to create the array
			[Parameter(Mandatory)]
			[string]$String
		)
		#Create the array by splitting the string on each new line and excluding empty entries
		$array = $String -split "\r?\n" | Where-Object { $_ -ne "" }
		
		#Creates the variable in the global scope so that it is available after the function completes
		Set-Variable -Name $VariableName -Value $array -Scope Global
	}
