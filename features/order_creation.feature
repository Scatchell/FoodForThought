@javascript
Feature: Creating orders

  Background:
    Given the following items exist:
    |name |price |
    |Rice |0     |
    |Beans|3000  |
    And a valid user exists
    When I sign in
    And I go to the order creation page
    And I select two items on the menu
    And I create the order

  Scenario: Create a valid order
    Then I should see the order I created
    And the order should exist

  Scenario: Cancel an order
    And I cancel the order
    Then I should see the new order page
    And the order should not exist
