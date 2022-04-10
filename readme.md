# Enable Defender for Endpoint

This repository includes the tools and documentation to use automation to manage your enterprise Microsoft Defender feature enablement.

[![DeployASCPricingPolicyInitiative](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsAzurePolicy.yml/badge.svg)](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettingsAzurePolicy.yml)

[![DeployASCPricingUsingARM](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettings.yml/badge.svg)](https://github.com/nanigan/asc-standard-demo/actions/workflows/deployAscSettings.yml)

[![manage-azure-policy-950cc6d4](https://github.com/nanigan/asc-standard-demo/actions/workflows/manage-azure-policy-950cc6d4.yml/badge.svg)](https://github.com/nanigan/asc-standard-demo/actions/workflows/manage-azure-policy-950cc6d4.yml)

---

## PowerShell Script

```powershell
Set-AzSecurityPricing -Name "virtualmachines" -PricingTier "Standard"
```
---

## Enable Using an ARM Template 
Reource provider: [Microsoft.Security/pricings](https://docs.microsoft.com/en-us/azure/templates/microsoft.security/pricings?tabs=json)

```json
{
 "$schema": "https://schema.management.azure.com/schemas/2018-05-01/subscriptionDeploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "pricingTierVMs": {
            "type": "string",
            "defaultValue": "Standard"
        }
    },
    "resources": [
        {
            "type": "Microsoft.Security/pricings",
            "apiVersion": "2017-08-01-preview",
            "name": "VirtualMachines",
            "properties":{
                "pricingTier": "[parameters('pricingTierVMs')]"
            }
        }      
        
    ],
    "outputs": {}
}
```
---
## Azure Policy
Using a built-in Azure Policy initiative that can be assigned at any scope within Azure that the role assignment permits. This can assigned within the Policy management blade in the Azure Portal, or using source control and automation.

Policy initiative deploying the agent to all image types:

- [[Preview]: [Preview]: Deploy Microsoft Defender for Endpoint agent](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Security%20Center/ASC_MicrosoftDefenderForEndpointAgent.json)


The aforementioned policy initiative will deploy the following vm specific image endpoint agents, which can be done separately, if you choose to not deploy them all at once:


- [[Preview]: [Preview]: Deploy Microsoft Defender for Endpoint agent on Linux hybrid machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F4eb909e7-6d64-656d-6465-2eeb297a1625)

- [[Preview]: [Preview]: Deploy Microsoft Defender for Endpoint agent on Linux virtual machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2Fd30025d0-6d64-656d-6465-67688881b632)

- [[Preview]: [Preview]: Deploy Microsoft Defender for Endpoint agent on Windows Azure Arc machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F37c043a6-6d64-656d-6465-b362dfeb354a)

- [[Preview]: [Preview]: Deploy Microsoft Defender for Endpoint agent on Windows virtual machines](https://portal.azure.com/#blade/Microsoft_Azure_Policy/PolicyDetailBlade/definitionId/%2Fproviders%2FMicrosoft.Authorization%2FpolicyDefinitions%2F1ec9c2c2-6d64-656d-6465-3ec3309b8579)


### Portal Experience
Navigate to: https://portal.azure.com

- Type "policy" in the portal search box
- Select "Policy"
- Select "Policy Definitions"
- In the search box, type "[Preview]: Deploy Microsoft Defender for Endpoint agent"
- Select the policy
- Select the "Assign" button to assign the policy
- Follow wizard to deploy to your desired scope



![alt text](images\policy-initiative-assignment.jpg)



Solution requirements

PowerShell Requirements:
Az
Az.Security

Azure requirements:
Service Principal with the least priveledged role: "Resource Policy Contributor" Other built-in roles with the Microsoft.Authorization and Microsoft.PolicyInsights operations. See: https://docs.microsoft.com/en-us/azure/governance/policy/overview#azure-rbac-permissions-in-azure-policy

