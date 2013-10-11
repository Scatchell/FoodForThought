
Feature: Admin account
  Scenario: View all orders page
    Given an admin user exists
    And I sign in as an admin user
    When I go to the view all orders page
    Then I should see the all orders page