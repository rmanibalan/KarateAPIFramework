
Feature: Sign Up new user

  Background: Preconditions
    Given url apiUrl
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail();
    * def randomUsername = dataGenerator.getRandomuserName();

  Scenario: New user sign up
    #* def jsFunction =
    #"""
    #function(){
    #var dataGenerator = Java.type('helpers.DataGenerator')
    #var generator = new dataGenerator()
    #return generator.getRandomuserName()
    #}
    #
    #"""
    #* def randomUsername = call jsFunction
    Given path 'users'
    And request
      """
      {
          "user": {
              "email": #(randomEmail),
              "password": "password123",
              "username": #(randomUsername)
          }
      }
      """
    When method Post
    Then status 201
    And match response ==
      """
      {
        "user": {
            "email": #(randomEmail),
            "username": #(randomUsername),
            "bio": null,
            "image": "#string",
            "token": "#string"
        }
      }
      """
	
  Scenario Outline: Sign up Error scenarios
    Given path 'users'
    And request
      """
      {
          "user": {
              "email": "<email>",
              "password": "<password>",
              "username": "<username>"
          }
      }
      """
    When method Post
    Then status 422
    And match response == <error_response>

    Examples: 
      | email             | password    | username          | error_response                                                                        |
      | karate05@test.com | password123 | DemoTest05        | {"errors":{"email":["has already been taken"],"username":["has already been taken"]}} |
      | karate05@test.com | password123 | #(randomUsername) | {"errors":{"email":["has already been taken"]}}                                       |
      | #(randomEmail)    | password123 | DemoTest051       | {"errors":{"username":["has already been taken"]}}                                    |
      |                   | password123 | DemoTest052       | {"errors":{"email":["can't be blank"]}}                                               |
      | #(randomEmail)    |             | DemoTest052       | {"errors":{"password":["can't be blank"]}}                                            |
      | #(randomEmail)    | password123 |                   | {"errors":{"username":["can't be blank"]}}                                            |
      
      
      
      
      
