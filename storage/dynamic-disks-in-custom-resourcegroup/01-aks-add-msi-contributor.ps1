# When you want to deploy dynamic disks in another resource group, the AKS cluster needs to have contributor permissions on that
# resource group. This code will assign the contributor role to the system MSI of the AKS cluster.

$aksClusterName = 'testaks01' # Name of the cluster.
$aksResourceGroupName = 'test-aks' # Name of the resource group in which the AKS cluster is deployed ( so NOT the MC_ rsg ).
$storageResourceGroup = 'aksstorage' # Resource Group in which you want to deploy dynamic disks.

$params = @{
    RoleDefinitionName = 'Contributor'
    ObjectId           = ( Get-AzAksCluster -Name $aksClusterName -ResourceGroupName $aksResourceGroupName).Identity.PrincipalId
    Scope              = ( Get-AzResourceGroup -Name $storageResourceGroup ).ResourceId
}

New-AzRoleAssignment @params