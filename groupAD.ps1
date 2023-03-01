Import-Module activedirectory
        
        $users = Import-Csv c:\UserV2.csv

foreach ($User in $users) 
{
    $group = $User.Group
    $username = $User.User

    if (Get-ADUser -Filter "SamAccountName -eq '$($username)'") {
        Add-ADGroupMember `
        -Identity $group `
        -Members $username
        Write-Host "$username added to $group"
    }
    else
    {

        Write-Warning "$username not found in Active Directory"
    }
}