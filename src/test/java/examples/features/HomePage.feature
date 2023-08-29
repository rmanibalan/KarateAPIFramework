Feature: Test for Home page

Background: Define variables
Given url apiUrl

  Scenario: Get all tags
    Given path 'tags'
    When method Get
    Then status 200
    And match response.tags contains ['welcome', 'ipsum']
    And match response.tags !contains 'truck'
    And match response.tags == "#array"
    And match each response.tags == "#string"
	
	
  Scenario: Get 10 articles from the page
    #Given param limit = 10
    #Given param offset = 0
    Given params {limit:10, offset:0}
    Given path 'articles'
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 197
