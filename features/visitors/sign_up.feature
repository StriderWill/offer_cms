Feature: Sign up
  As a visitor
  I want to sign up
  So I can visit protected areas of the site

  Scenario: Visitor can sign up with valid email address and password
    Given I am not signed in
    When I sign up with valid data
    Then I see a successful sign up message

  Scenario: Visitor cannot sign up with invalid email address
    Given I am not signed in
    When I sign up with an invalid email address
    Then I see an invalid email message

  Scenario: Visitor cannot sign up without password
    Given I am not signed in
    When I sign up without a password
    Then I see a missing password message

  Scenario: Visitor cannot sign up with a short password
    Given I am not signed in
    When I sign up with a short password
    Then I see a 'too short password' message

  Scenario: Visitor cannot sign up without password confirmation
    Given I am not signed in
    When I sign up without a password confirmation
    Then I should see a mismatched password message

  Scenario: Visitor cannot sign up with mismatched password and confirmation
    Given I am not signed in
    When I sign up with a mismatched password confirmation
    Then I should see a mismatched password message
