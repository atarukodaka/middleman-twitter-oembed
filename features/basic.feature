Feature: basic

  Scenario: convert
    Given a fixture app "basic-app"
    And a file named "source/index.html.erb" with:
      """
      ---
      ---
      http://twitter.com/ataru_kodaka/status/591598644421242880
      """
    And the Server is running at "basic-app"
    When I go to "/index.html"
    Then I should see "test"

  Scenario: helper by id
    Given a fixture app "basic-app"
    And a file named "source/index.html.erb" with:
      """
      ---
      ---
      <%= twitter_oembed("591598644421242880") %>
      """
    And the Server is running at "basic-app"
    When I go to "/index.html"
    Then I should see "test"

  Scenario: option for regex
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :twitter_oembed do |twitter|
        twitter.convert_regex = %r{\[\[twitter\:\s*(\d+)\]\]}
      end
      """
    And a file named "source/index.html.erb" with:
      """
      ---
      ---
      [[twitter: 591598644421242880]]
      """
    And the Server is running at "basic-app"
    When I go to "/index.html"
    Then I should see "test"
    

