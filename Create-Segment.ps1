#Variables for NSX Manager Connection
#$nsxmanagerip = "192.168.110.201"
#$nsxuser = "admin"
#$nsxpasswd = "VMware1!Vmware1!"
#General Variables
$description = "Created with VMware PowerCLI"
$tag = "powercli"
#Variables for Segment
$segmentid = "Seg-Test-PowerCLI"
$transportzone = "/infra/sites/default/enforcement-points/default/transport-zones/TRANSPORTZONEID"
$path_to_t1_rtr = "/infra/tier-1s/T1ROUTERNAME"
$defaultgateway = "IP-ADDRESS/MASK"
#Connect to NSX Manager
#Connect-NsxtServer -Server $nsxmanagerip -User $nsxuser -Password $nsxpasswd
#Retrieve Segment Information
$segmentdata = Get-NsxtPolicyService -Name com.vmware.nsx_policy.infra.segments
#Set Variables
$segmentdata = Get-NsxtPolicyService -Name com.vmware.nsx_policy.infra.segments
$segmentspecification = $segmentdata.Help.patch.segment.Create()
$segmentspecification.description = $description
$segmentspecification.id = $segmentid
$segmentspecification.transport_zone_path = $transportzone
$segmentspecification.connectivity_path = $path_to_t1_rtr
#Set Default Gateway Variables
$subnetSpec = $segmentdata.help.patch.segment.subnets.Element.Create()
$subnetSpec.gateway_address = $defaultgateway
$segmentspecification.subnets.Add($subnetSpec) | Out-Null
#Add Tag to the Segment
$segmenttag = $segmentdata.help.patch.segment.tags.Element.Create()
$segmenttag.tag = $tag
$segmentspecification.tags.Add($segmenttag) | Out-Null
#Create Segment
$segmentdata.patch($segmentid, $segmentspecification)
