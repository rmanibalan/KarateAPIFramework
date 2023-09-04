@debug
Feature: Articles

  Background: Define login token
    Given url apiUrl
    * def articleRequest = read('classpath:json/ArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * set articleRequest.article.title = dataGenerator.getRandomArticle().title;
    * set articleRequest.article.description = dataGenerator.getRandomArticle().description;
    * set articleRequest.article.body = dataGenerator.getRandomArticle().body;

  #@ignore
  Scenario: Create New Article
    Given path 'articles'
    And request articleRequest
    When method Post
    Then status 201
    And match response.article.title == articleRequest.article.title
	
	@parallel=false
  Scenario: Delete Article
  	#create
    Given path 'articles'
    And request articleRequest
    When method Post
    Then status 201
    And match response.article.title == articleRequest.article.title
    #get
    Given path 'articles'
    And params {limit:10, offset:0, author:'#(userName)'}
    When method Get
    Then status 200
    And match response.articles[0].title == articleRequest.article.title
    * def articleId = response.articles[0].slug
    #delete
    Given path 'articles', articleId
    When method Delete
    Then status 204
    #get
    Given path 'articles'
    And params {limit:10, offset:0, author:'#(userName)'}
    When method Get
    Then status 200
    And match response.articles[*].title != articleRequest.article.title
