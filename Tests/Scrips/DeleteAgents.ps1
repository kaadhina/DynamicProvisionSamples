[CmdletBinding()]
Param
(
	[Parameter(Mandatory=$true)]
	[string]$PersonalAccessToken,

	[Parameter(Mandatory=$true)]
	[string]$AccountUrl,

	[Parameter(Mandatory=$true)]
	[string]$PoolName
)

Write-Host "Entering delete agents"

$encodedPat = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes(":$PersonalAccessToken"))
$poolsuri = $uri = $AccountUrl + "_apis/distributedtask/pools"
$resp = Invoke-RestMethod -Uri $poolsuri -Headers @{Authorization = "Basic $encodedPat"}

foreach( $pool in $resp.value)
{
    Write-Host "Entering $($pool.name)"
    if($($pool.name) -eq $PoolName)
    {
        Write-Host "Found pool $($pool.name)"
        $agentsUri = $AccountUrl + "_apis/distributedtask/pools/$($pool.id)/agents"
        $resp = Invoke-RestMethod -Uri $agentsUri -Headers @{Authorization = "Basic $encodedPat"}
        foreach($agent in $resp.value)
        {
            Write-Host "Deleting agent $($agent.name)"
            $deleteUri = $AccountUrl + "_apis/distributedtask/pools/$($pool.id)/agents/$($agent.id)?api-version=5.1-preview.1"
            Invoke-RestMethod -Uri $deleteUri -Method Delete -Headers @{Authorization = "Basic $encodedPat"}
        }
    }
}
