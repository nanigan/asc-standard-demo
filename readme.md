# Enable Defender for Endpoint

This repository includes the tools and documentation to use automation to manage your enterprise Microsoft Defender feature enablement.

[![deployAscSettingsARM](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsARM.yaml/badge.svg)](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsARM.yaml)

[![deployAscSettingsAzureMonitor](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsAzureMonitor.yml/badge.svg)](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsAzureMonitor.yml)

[![deployAscSettingsAzurePolicySet](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsAzurePolicySet.yml/badge.svg)](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsAzurePolicySet.yml)

[![deployAscSettingsDefenderForEndpoint](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsDefenderForEndpoint.yml/badge.svg)](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsDefenderForEndpoint.yml)

[![deployAscSettingsPowerShell](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsPowerShell.yml/badge.svg)](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsPowerShell.yml)

[![deployAscSettingsSecurityMonitoringAgents](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsSecurityMonitoringAgents.yml/badge.svg)](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsSecurityMonitoringAgents.yml)

[![deployAscSettingsVulnerabilityAssessment](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsVulnerabilityAssessment.yml/badge.svg)](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsVulnerabilityAssessment.yml)



# Setting Pricing Value for Defender for Cloud

## Using PowerShell Script

```powershell
Set-AzSecurityPricing -Name "virtualmachines" -PricingTier "Standard"
```
---

## Using an ARM Template 
Reource provider: [Microsoft.Security/pricings](https://docs.microsoft.com/en-us/azure/templates/microsoft.security/pricings?tabs=json) This template will also auto-provisioning security settings.

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "pricingTierVMs": {
            "type": "string",
            "defaultValue": "Standard"
        },
        "autoProvisioning": {
            "type": "string",
            "defaultValue": "on"
        }
    },
    "resources": [
        {
            "type": "Microsoft.Security/autoProvisioningSettings",
            "name": "default",
            "apiVersion": "2017-08-01-preview",
            "properties": {
                "autoProvision": "[parameters('autoProvisioning')]"
            }
        },
        {
            "type": "Microsoft.Security/workspaceSettings",
            "apiVersion": "2017-08-01-preview",
            "name": "default",
            "properties": {
                "workspaceId": "/subscriptions/805b1035-89ad-44e4-9f1d-d27d67305a2b/resourcegroups/rg-demo-resources/providers/microsoft.operationalinsights/workspaces/sneff-law",
                "scope": "[subscription().id]"
            }
        },
        {
            "type": "Microsoft.Security/pricings",
            "apiVersion": "2018-06-01",
            "name": "VirtualMachines",
            "properties": {
                "pricingTier": "[parameters('pricingTierVMs')]"
            }
        }
    ],
    "outputs": {
    }
}
```

## Using Azure Policy
Using a built-in Azure Policy initiative that can be assigned at any scope within Azure that the role assignment permits. This can assigned within the Policy management blade in the Azure Portal, or using source control and automation.

Original built-in policy set:

- [[Preview]: [Preview]: Deploy Microsoft Defender for Endpoint agent](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Security%20Center/ASC_MicrosoftDefenderForEndpointAgent.json)

The original built-in policy initiative was cloned and exported. This is now listed as a custom policy intiative

The new customer policy initiative is called: "Deploy Defender for Endpoint Agent" and includes the folowing built-in policies that deploy the agent to all VM types:

Policy initiative deploying the agent to all image types (you may deploy the policies separately, if you choose to not deploy them all at once:

- [[Preview]: [Preview]: Deploy Microsoft Defender for Endpoint agent on Linux hybrid machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F4eb909e7-6d64-656d-6465-2eeb297a1625)

- [[Preview]: [Preview]: Deploy Microsoft Defender for Endpoint agent on Linux virtual machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fd30025d0-6d64-656d-6465-67688881b632)

- [[Preview]: [Preview]: Deploy Microsoft Defender for Endpoint agent on Windows Azure Arc machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F37c043a6-6d64-656d-6465-b362dfeb354a)

- [[Preview]: [Preview]: Deploy Microsoft Defender for Endpoint agent on Windows virtual machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1ec9c2c2-6d64-656d-6465-3ec3309b8579)



## Using the Policy Portal Experience
Navigate to: https://portal.azure.com

- Type "policy" in the portal search box
- Select "Policy"
- Select "Policy Definitions"
- In the search box, type "[Preview]: Deploy Microsoft Defender for Endpoint agent"
- Select the policy
- Select the "Assign" button to assign the policy
- Follow wizard to deploy to your desired scope

![Policy Assignment Screen Shot](images\policy-initiative-assignment.jpg)

# Deploy Log Analytics Agent on Azure VMs
This will automatically on-boards Azure VMs by installing the Azure Log Analytics Agent



