<# 
.NOTES
   
   Created By ::          Adam Bobbie
   Created On ::          20250812
   Version ::             1.0
   Github ::              github.com/bobbienet

.SYNOPSIS          
Quickly terminates all running mRemoteNG processes on the local system.

.DESCRIPTION
mRemoteNG occasionally experiences display scaling issues when moving
between monitors with different resolutions or when restoring the
application from a maximized window.

This function forcibly terminates all matching mRemoteNG processes,
avoiding the need to terminate them manually through Task Manager.

WARNING: Forcibly terminating mRemoteNG may result in unsaved changes being lost.

.EXAMPLE
Kill-mRemoteNG
No mRemoteNG process found.

.EXAMPLE
Kill-mRemoteNG
Killing mRemoteNG PID 12345...
Done.

#>


function Kill-MRemoteNG {
    # Get processes matching mRemoteNG
    $procs = Get-Process -Name mRemoteNG -ErrorAction SilentlyContinue

    if (-not $procs) {
        Write-Host "No mRemoteNG process found." -ForegroundColor Yellow
        return
    }

    foreach ($proc in $procs) {
        Write-Host "Killing mRemoteNG PID $($proc.Id)..." -ForegroundColor Cyan
        taskkill /F /PID $proc.Id | Out-Null

        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Failed to terminate mRemoteNG PID $($proc.Id)."
        }
    }

    Write-Host "Done." -ForegroundColor Green
}
