Feature: Creating orders

  Scenario: Create a valid order
    Given the item "Beef" exists with a price of 5000
    And I sign in with valid credentials
    And I am on the create an order page
    When I select the only available item
    And I create the order
    Then I should see a confirmation page showing the "Beef" item and my username
