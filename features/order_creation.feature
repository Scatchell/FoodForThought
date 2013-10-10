Feature: Creating orders

  Scenario: Create a valid order
    Given the item "Rice" exists with a price of 0
    And the item "Beans" exists with a price of 3000
    And I am signed in
    And I am on the order creation page
    And I select two items on the menu
    And I create the order
    Then I should see the order I created
