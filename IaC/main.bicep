param storageAccountName string
param location string = resourceGroup().location
param containerName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource fileservice 'Microsoft.Storage/storageAccounts/fileServices@2023-05-01' = {
  parent: storageAccount
  name: 'default'
}

// Create a blob container inside the storage account
resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: containerName
  parent: fileservice
  properties: {
    publicAccess: 'None' // Optional: set to 'Blob' or 'Container' for public access
  }
}

