<# 
.NOTES
   
   Created By ::          Adam Bobbie
   Created On ::          20251104
   Modified On ::         20261015
   Modification Note ::   Added help and comments segment to facilitate publishing
			  of the function
   Version ::             1.0
   Github ::              github.com/bobbienet

.SYNOPSIS
Retrieves the SID associated with a local Windows user profile.

.DESCRIPTION
Searches the local Windows registry ProfileList for a profile
directory matching the specified username and returns its SID.

This function searches existing local profile registry entries
and does not query Active Directory.

Known limitations:
Certain service identities are excluded by design, as this function
is intended to identify conventional local and domain user profiles.

A profile directory of "C:\users\jsmith.CONTOSO" will not match
"-identity jsmith", because the function determines the username from the profile
directory name rather than the account's actual identity.


.PARAMETER Identity
Mandatory. 
The username to search for, in the local Windows registry.
If omitted, PowerShell will prompt for the username.

.EXAMPLE
Get-UserRegKey -identity jsmith

SID                                          Username
---                                          --------
S-1-5-21-123456789-123456789-123456789-1001  jsmith
#>

function Get-UserRegKey {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Identity
    )

    # Get all user profiles from the registry
    $profiles = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*' | 
        Where-Object { $_.PSChildName -match '^S-1-5-21-\d+-\d+-\d+-\d+$' } |
        Select-Object @{
            Name = "SID"; Expression = { $_.PSChildName }
        }, @{
            Name = "Username"; Expression = { $_.ProfileImagePath -replace '^(.*[\\\/])', '' }
        }

    # Filter for the username provided
    $profiles | Where-Object { $_.Username -ieq $Identity }
}
