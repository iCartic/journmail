Feature: Emails

  Emails play a central role in our system, we use them as a
  notification system and for registration.

  In order to train consistency, we notify users every day in the evening that they
  should write a new entry for their day (one sentence).

  Scenario: Registration
    Given I am unregistered user
    When I register with "shime@twobucks.co"
    Then I should receive a registration email
    And the new user should be created

  Scenario: Registration Confirmation
    Given I am unregistered user
    And I go to registration URL
    Then I should become a paying user

  Scenario: Notification Emails
    Given I am a paying user
    When time is 20:00 in my timezone
    And email notification is sent
    Then I should receive an email notification

  Scenario: Email Replies
    Given I am a paying user
    When I respond to email notification
    Then a new log entry should be created
    And last log entry should belong to a current user

  Scenario: Inbound Email Parsing
    Given I am a paying user
    When I post an email to inbound endpoint
    Then server response should be success
    Then a new log entry should be created
    And it should only contain the reply text
