#Connect-AzAccount
#$Credentials = Get-Credential
#Get-AzVM -Status
#dir

# Create the Policy Definition
#$definition = New-AzPolicyDefinition -Name "contain-resource-group-name" -DisplayName "Resource name contains resource group name" -description "Require resources to contain the resource group's name" -Policy 'https://raw.githubusercontent.com/Azure/azure-policy/master/samples/TextPatterns/contain-resource-group-name/azurepolicy.rules.json' -Mode Indexed

# Show Definition
#$definition

# Create the Policy Assignment
#$assignment = New-AzPolicyAssignment -Name <assignmentname> -Scope <scope> -PolicyDefinition $definition

## Show Assignment
#$assignment

$definition = New-AzPolicyDefinition -Name "enforce-match-pattern" -DisplayName "Ensure resource names match the naming pattern" -description "Ensure resource names match the naming pattern" -Policy 'https://raw.githubusercontent.com/Azure/azure-policy/master/samples/TextPatterns/enforce-match-pattern/azurepolicy.rules.json' -Parameter 'https://raw.githubusercontent.com/Azure/azure-policy/master/samples/TextPatterns/enforce-match-pattern/azurepolicy.parameters.json' -Mode All
$definition
#$assignment = New-AzPolicyAssignment -Name <assignmentname> -Scope <scope> -PolicyDefinition $definition
#$assignment 


$definition = New-AzPolicyDefinition -Name "enforce-like-pattern" -DisplayName "Ensure resource names meet the like condition for a pattern." -description "Ensure resource names meet the like condition for a pattern." -Policy 'https://raw.githubusercontent.com/Azure/azure-policy/master/samples/TextPatterns/enforce-like-pattern/azurepolicy.rules.json' -Parameter 'https://raw.githubusercontent.com/Azure/azure-policy/master/samples/TextPatterns/enforce-like-pattern/azurepolicy.parameters.json' -Mode All
$definition