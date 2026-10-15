<#
.NOTES
   
   Created By ::          Adam Bobbie
   Created On ::          20260218
   Version ::             1.0
   Github ::              github.com/bobbienet

.SYNOPSIS
Proof of concept demonstrating how to set the Windows clipboard contents using PowerShell.

.DESCRIPTION
When called, the function replaces the current clipboard contents
with the shrug emoticon ¯\_(ツ)_/¯.

The function produces no pipeline output.

.EXAMPLE
Set-Shrug

#>

function set-shrug {
set-clipboard "¯\_(ツ)_/¯"
}
