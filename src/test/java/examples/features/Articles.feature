@debug
Feature: Articles

  Background: Define login token
    Given url apiUrl
    
#	@ignore
  Scenario: Create New Article
    Given path 'articles'
    And request {"article": {"tagList": [],"title": "Delete Article","description": "test test","body": "something to write"}}
    When method Post
    Then status 201
    And match response.article.title == 'Delete Article'
    
 Scenario: Delete Article - articleId
    
    Given path 'articles'
    And params {limit:10, offset:0, author:userName}
    When method Get
    Then status 200
    And match response.articles[0].title == 'Delete Article'
    * def articleId = response.articles[0].slug
    
    Given path 'articles', articleId
    When method Delete
    Then status 204
    
    Given path 'articles'
    And params {limit:10, offset:0, author:userName}
    When method Get
    Then status 200
    And match response.articles == '#[0]'
    
