# Feature draws the overall picture of the feature file that may consist several scenarios
# Scenario will define a test that might include multiple steps with BDD directives

Feature: Feature related to Storage Accounts

	related_resources: azurerm_storage_account
	
	Scenario: Ensure that 'Secure transfer required' is set to 'Enabled'
		Given I have azurerm_storage_account defined
		Then it must have enable_https_traffic_only
		And its value must be true

	Scenario: Ensure that 'public_network_access_enabled' is set to 'Disabled'
		Given I have azurerm_storage_account defined
		Then it must have public_network_access_enabled
		And its value must be false

	Scenario: Ensure that 'cross_tenant_replication_enabled' is set to 'Disabled'
		Given I have azurerm_storage_account defined
		Then it must have cross_tenant_replication_enabled
		And its value must be false

