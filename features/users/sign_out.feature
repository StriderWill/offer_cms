Feature: Sign out
  As a user
  I want to sign out
  So I can protect my account from unauthorized access

  Scenario: User signs out successfully
    Given I am signed in
    When I sign out
    Then I see the login form
