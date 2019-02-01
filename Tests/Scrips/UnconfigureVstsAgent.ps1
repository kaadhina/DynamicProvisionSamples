# Downloads the Visual Studio Team Services Build Agent and installs on the new machine
# and registers with the Visual Studio Team Services account and build agent pool

# Enable -Verbose option
[CmdletBinding()]
Param
(
	[Parameter(Mandatory=$true)]
	[string]$PersonalAccessToken,

	[Parameter(Mandatory=$true)]
	[int]$AgentCount,

	[Parameter(Mandatory=$true)]
	[string]$AgentName
)

Write-Verbose "Entering UnconfigureVSOAgent.ps1" -verbose

for ($i=0; $i -lt $AgentCount; $i++)
{
	$Agent = ($AgentName + "-" + $i)

	# Construct the agent folder under the main (hardcoded) C: drive.
	$agentInstallationPath = Join-Path "C:" $Agent

	# Set the current directory to the agent dedicated one previously created.
	Push-Location -Path $agentInstallationPath

	# Call the agent with the remove command 
	Write-Verbose "Unconfiguring agent '$($Agent)'" -Verbose		
	.\config.cmd remove --unattended --auth PAT --token $PersonalAccessToken
	
	Write-Verbose "Agent uninstall output: $LASTEXITCODE" -Verbose
	
	Pop-Location
}

Write-Verbose "Exiting UnconfigureVSTSAgent.ps1" -Verbose