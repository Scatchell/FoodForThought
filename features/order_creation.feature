Feature: Creating orders

  Scenario: Create a valid order
    Given the item "Beef" exists with a price of 5000
    And the user is on the create an order page
    When the user inputs a valid name
    And selects the "Beef" item
    And creates the order
    Then they should see a confirmation page showing the "Beef" item
