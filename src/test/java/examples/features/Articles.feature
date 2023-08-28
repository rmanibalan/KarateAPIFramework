@debug
Feature: Articles

  Background: Define login token
    Given url 'https://api.realworld.io/api/'
    Given path 'users/login'
    And request {"user": {"email": "karate01@test.com", "password": "password123"}}
    When method Post
    Then status 200
    * def token = response.user.token
#	@ignore
  Scenario: Create New Article
    Given path 'articles'
    And header Authorization = 'Token ' +token
    And request {"article": {"tagList": [],"title": "Delete Article","description": "test test","body": "something to write"}}
    When method Post
    Then status 201
    And match response.article.title == 'Delete Article'
    
 Scenario: Delete Article - articleId
    
    Given path 'articles'
    And header Authorization = 'Token ' +token
    And params {limit:10, offset:0, author:'DemoTest'}
    When method Get
    Then status 200
    And match response.articles[0].title == 'Delete Article'
    * def articleId = response.articles[0].slug
    
    Given path 'articles', articleId
    And header Authorization = 'Token ' +token
    When method Delete
    Then status 204
    
    Given path 'articles'
    And header Authorization = 'Token ' +token
    And params {limit:10, offset:0, author:'DemoTest'}
    When method Get
    Then status 200
    And match response.articles[0].title != 'Delete Article'
    
