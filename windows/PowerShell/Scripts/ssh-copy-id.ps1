<# Based on work by Christopher Hart https://chrisjhart.com/Windows-10-ssh-copy-id/

   Created by   ::  Adam Bobbie (just adding the args to utilize as script)
   
   Created on   ::  2023-03-02 (2nd March 2023)
 
   Version      ::  1.0
   Description  ::  Emulates the ssh-copy-id command from Linux for PowerShell / Windows Terminal environments
                    NOTE: this will only copy the public key from the $env:USERPROFILE\.ssh\id_rsa.pub location
                    it cannot accept the -i to specify key file or any other of the original options.
                    This is done with the expectation that Microsoft will implement the ssh-copy-id functionality
                    in later releases of either PowerShell or Windows
                    
                    Add ssh-copy-id to your PowerShell profile
   
   Example      ::  PS> ssh-copy-id username@<IP-Address or FQDN>
                        username@<IP-Address or FQDN>'s password:
                    PS>

 
#>

$param1=$args[0] #this will hold the username@IP-OR-FQDN

#type is similar to get-content, if this breaks replace with get-content, after the content is retrieved pipe it into the ssh session (prompt for creds first)
#then append into the .ssh/authorized_keys file.

type $env:USERPROFILE\.ssh\id_rsa.pub | ssh $param1 "cat >> .ssh/authorized_keys"
