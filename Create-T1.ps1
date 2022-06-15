#Variables for NSX Manager Connection
#General Variables
$description = "Created with VMware PowerCLI"
$tag = "powercli"
#Variables for T1 Router
$t1routerid = "T1-Test-001"
$t1routeradvertisement = @("TIER1_IPSEC_LOCAL_ENDPOINT","TIER1_CONNECTED")
#Connect to NSX Manager
#Connect-NsxtServer -Server $nsxmanagerip -User $nsxuser -Password $nsxpasswd

#Retrieve Router Information
$t1routerdata = Get-NsxtPolicyService -Name com.vmware.nsx_policy.infra.tier1s

#Set Variables
$t1routerspecification = $t1routerdata.Help.patch.tier1.Create()
$t1routerspecification.description = $description
$t1routerspecification.id = $t1routerid
$t1routerspecification.display_name = $t1routerid
# $t1routerspecification.tier0_path = $t1routerpath_to_t0_rtr
$t1routerspecification.route_advertisement_types = $t1routeradvertisement

#Add Tag to the Router
$t1routertag = $t1routerdata.Help.patch.tier1.tags.Element.Create()
$t1routertag.tag = $tag
$t1routerspecification.tags.Add($t1routertag) | Out-Null

#Create T1 Router
$t1routerdata.patch($t1routerspecification.id, $t1routerspecification)
