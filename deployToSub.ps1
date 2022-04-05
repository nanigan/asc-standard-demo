New-AzSubscriptionDeployment `
  -Name deploypricings `
  -Location eastus2 `
  -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/emptyrg.json" `
  -rgName demoResourceGroup `
  -rgLocation centralus


  https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/emptyrg.json