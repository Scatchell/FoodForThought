Feature: User Sign Up

    Background:
        Given no user with username "mjuser" exists:
        When I go to the sign up page

    Scenario: Successful User signup
        When I fill in "mjuser" for "user[username]"
        And I fill in "mjemail@mail.com" for "user[email]"
        And I fill in "mjusersecret" for "user[password]"
        And I fill in "mjusersecret" for "user[password_confirmation]"
        And I follow the "Sign up" button
        Then I should see "Welcome! You have signed up successfully."
    Scenario: Sign up fails if passwords do not match
        When I fill in "mjuser" for "user[username]"
        And I fill in "mjemail@mail.com" for "user[email]"
        And I fill in "mjusersecret" for "user[password]"
        And I fill in "m" for "user[password_confirmation]"
        And I follow the "Sign up" button
        Then I should see "Password confirmation doesn't match Password"
     Scenario: Sign up fails if username is empty
        When I fill in "" for "user[username]"
        And I fill in "mjemail@mail.com" for "user[email]"
        And I fill in "mjusersecret" for "user[password]"
        And I fill in "mjusersecret" for "user[password_confirmation]"
        And I follow the "Sign up" button
        Then I should see "Username can't be blank"
