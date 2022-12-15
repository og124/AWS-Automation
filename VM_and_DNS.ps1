# Install AWS Tools for PowerShell if not already installed
if (-not (Get-Module -Name AWS.Tools.EC2)) {
    Install-Module -Name AWS.Tools.EC2
}
if (-not (Get-Module -Name AWS.Tools.Route53)) {
    Install-Module -Name AWS.Tools.Route53
}

# Set AWS credentials and region
Set-AWSCredentials -AccessKey <YOUR_ACCESS_KEY> -SecretKey <YOUR_SECRET_KEY> -StoreAs <PROFILE_NAME>
Set-DefaultAWSRegion -Region <YOUR_REGION> -ProfileName <PROFILE_NAME>

# Spin up a new dev AWS instance
$Instance = New-EC2Instance -ImageId <YOUR_AMI_ID> -InstanceType <YOUR_INSTANCE_TYPE> -SubnetId <YOUR_SUBNET_ID>

# Create a new test Route 53 DNS record for the dev instance
$HostedZoneId = "<YOUR_HOSTED_ZONE_ID>"
$RecordSetName = "<YOUR_RECORD_SET_NAME>"
$RecordSetType = "<YOUR_RECORD_SET_TYPE>"
$RecordSetValue = (Get-EC2Instance -InstanceId $Instance.InstanceId).PublicIpAddress
$VpcId = "<YOUR_VPC_ID>"
Set-R53RecordSet -HostedZoneId $HostedZoneId -RecordSetName $RecordSetName -RecordSetType $RecordSetType -RecordSetValue $RecordSetValue -VpcId $VpcId
