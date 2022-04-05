New-AzSubscriptionDeployment `
  -Name deploypricings `
  -Location eastus2 `
  -TemplateUri "https://raw.githubusercontent.com/nanigan/asc-standard-demo/main/ASC-Settings/azuredeploy.json" `
  -rgName RG-DEMO-RESOURCES-TEST `
  -rgLocation eastus2
