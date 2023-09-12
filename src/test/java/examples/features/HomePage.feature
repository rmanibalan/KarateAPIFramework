#@debug
Feature: Test for Home page

  Background: Define variables
    Given url apiUrl
    #hooks
    * call read('classpath:helpers/Hooks.feature@first')
    * callonce read('classpath:helpers/Hooks.feature@second')
    * configure afterScenario = function () {karate.log('executed after Scenario')}
    * configure afterFeature = function () {karate.log('executed after feature')}

  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['welcome', 'ipsum']
    And match response.tags contains any ['fish', 'aqua', 'introduction']
    And match response.tags !contains 'truck'
    And match response.tags == "#array"
    And match each response.tags == "#string"

  Scenario: Get 10 articles from the page
    #Given param limit = 10
    #Given param offset = 0
    * def timeValidator = read('classpath:helpers/timeValidator.js')
    Given params {limit:10, offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    #And match response.articles == '#[10]'
    And match response == {"articles": "#array", "articlesCount": "#number"}
    And match response.articles[0].createdAt contains '2023'
    And match response.articles[*].favoritesCount contains 0
    And match response..bio contains null
    And match each response..following == false
    #schema validation
    And match each response.articles ==
      """
      {
              "slug": "#string",
              "title": "#string",
              "description": "#string",
              "body": "#string",
              "tagList": "#array",
              "createdAt": "#? timeValidator(_)",
              "updatedAt": "#? timeValidator(_)",
              "favorited": "#boolean",
              "favoritesCount": "#number",
              "author": {
                  "username": "#string",
                  "bio": "##string",
                  "image": "#string",
                  "following": "#boolean"
              }
          }
      """
	
	
  Scenario: Comdition logic
    Given params {limit:10, offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    * def favoritesCount = response.articles[0].favoritesCount
    * def article = response.articles[0]
    
    #* if(favoritesCount == 0) karate.call('classpath:helpers/AddLike.feature', article)
    
    * def result = favoritesCount == 0 ? karate.call('classpath:helpers/AddLike.feature', article).likeCount : favoritesCount
    
    Given params {limit:10, offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == 1
    
  @test1
  Scenario: Retry and Sleep
  * configure retry = {count: 10, interval: 5000}
  * def sleep = function(pause) { java.lang.Thread.sleep(pause)}
  
    Given params {limit:10, offset:0}
    Given path 'articles'
    And retry until response.articles[0].favoritesCount == 1
    When method Get
    * eval sleep(5000)
    Then status 200
    
    
    
