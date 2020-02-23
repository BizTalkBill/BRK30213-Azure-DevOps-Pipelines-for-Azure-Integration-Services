[cmdletbinding()]
Param (
    [string]$keyvaultName
)

$KeyVaultSecretList = Get-AzKeyVaultSecret -VaultName $keyvaultName 

foreach($secret in $KeyVaultSecretList)
{
    #Write-Host "$($secret.Name)"
	$contentType = $secret.ContentType
    $secretValue = (Get-AzKeyVaultSecret -VaultName $keyvaultName -Name $($secret.Name)).SecretValueText
	$value = $secretValue
    #Write-Host "$($secretValue)"
    #Write-Host "##vso[task.setvariable variable=$($secret.Name);]$($value)"
	if ($contentType -eq "text/plain")
	{
		Write-Host "##vso[task.setvariable variable=$($secret.Name);]$($value)"
	}
	else
		{
		Write-Host "##vso[task.setvariable variable=$($secret.Name);issecret=true;]$($value)"
	}
}
