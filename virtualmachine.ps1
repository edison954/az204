Connect-AzAccount
$Credentials = Get-Credential
$RG2 = New-AzureRmResourceGroup -Name "Az100RG2" -Location "Southcentral US"

#CREAR MAQUINA VIRTUAL 1
$ASet = New-AzureRmAvailabilitySet -ResourceGroupName $RG2.ResourceGroupName -Name "aset1" -Location $RG2.Location -Sku "Aligned" -PlatformFaultDomainCount 1 -platformUpdateDomainCount 1
#$AvailabilitySet = Get-AzureRmAvailabilitySet -ResourceGroupName $RG2.ResourceGroupName -Name "aset1"
$VMConfig1 = New-AzureRmVMConfig -VMName "VMAz101" -VMSize "Standard_A1" -AvailabilitySetId $ASet.Id
$VMConfig1 = Set-AzureRmVMOperatingSystem -VM $VMConfig1 -Linux -ComputerName "VMAz101" -Credential ($Credentials)
$VMConfig1 = Set-AzureRmVMSourceImage -VM $VMConfig1 -PublisherName "Canonical" -Offer "UbuntuServer" -Skus "14.04.2-LTS" -Version "latest"
$VMConfig1 = Set-AzureRmVMOSDisk -VM $VMConfig1 -Name "DiskOS2" -Caching ReadWrite -CreateOption FromImage -Linux
$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -Name "Subnet3" -AddressPrefix "172.16.3.0/24"
$subnet2 = New-AzureRmVirtualNetworkSubnetConfig -Name "Subnet4" -AddressPrefix "172.16.4.0/24"
$vnet = New-AzureRmVirtualNetwork -Name "VNet2" -ResourceGroupName $RG2.ResourceGroupName -Location $RG2.Location -AddressPrefix "172.16.0.0/16" -Subnet ($subnet1,$subnet2)
$pip = New-AzureRmPublicIpAddress -ResourceGroupName $RG2.ResourceGroupName -Name "PIP2" -Location $RG2.Location -AllocationMethod Static
$nic = New-AzureRmNetworkInterface -Name "NIC2" -ResourceGroupName $RG2.ResourceGroupName -Location $RG2.Location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id
$VMConfig1 = Add-AzureRmVMNetworkInterface -VM $VMConfig1 -Id $nic.Id -Primary

New-AzureRmVM -ResourceGroupName $RG2.ResourceGroupName -Location $RG2.Location -VM $VMConfig1
