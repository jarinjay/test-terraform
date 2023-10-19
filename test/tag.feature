Feature: Feature related to applying tags

	related resources: azurerm_storage_account

#Scenario : Used for defining a scenario without any multiple dynamic variables.

	Scenario: Ensure tag is set on Azure Resources
	Given I have azurerm_storage_account defined
        Then it must contain tags
        And its value must not be null

#Scenario Outline : Used for defining a scenario loops by giving multiple dynamic variables.

    Scenario Outline: Ensure that specific tags are defined
        Given I have resource that supports tags defined
        When it has tags
        Then it must contain "<tags>"
        And its value must not be null

        Examples:
        | tags            |
        | resource_type   |
        | environment     |
