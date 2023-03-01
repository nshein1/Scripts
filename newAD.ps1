Import-Module activedirectory

$ADUsers = Import-csv c:\betterPass.csv

$UPN = "robotics.rome"

foreach ($User in $ADUsers)
{

$Role = $User.Role
$Firstname = $User.FirstName
$Lastname = $User.LastName
$Username = $User.AccountName
$Password = $User.Password

if (Get-ADUser -F {SamAccountName -eq $Username})
{
Write-Warning "User with username $Username already exists"
}
else
{

New-ADUser `
    -SamAccountName $Username `
    -UserPrincipalname "$Username@$UPN" `
    -Name "$Firstname, $Lastname" `
    -GivenName $firstname `
    -Enabled $True `
    -AccountPassword (ConvertTo-secureString $Password -AsPlainText -Force) -ChangePasswordAtLogon $False

}
}

Read-Host -Prompt "Press Enter to exit"