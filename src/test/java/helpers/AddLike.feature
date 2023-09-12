Feature: Add Like

Background:
Given url apiUrl

Scenario: Like an Article
Given path 'articles', slug, 'favorite'
And request {}
When method Post
Then status 200
* def likesCount = response.article.favoritesCount