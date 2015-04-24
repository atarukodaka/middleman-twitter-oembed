Feature: basic

  Scenario: convert
    Given a fixture app "basic-app"
    And a file named "source/index.html.erb" with:
      """
      ---
      ---
      foo
      http://twitter.com/ataru_kodaka/status/591598644421242880
      bar
      """
    And the Server is running at "basic-app"
    When I go to "/index.html"
    Then I should see "test"
    And I should see:
      """
      <script async src="//platform.twitter.com/widgets.js" charset="utf-8">
      """

  Scenario: non-convert
    Given a fixture app "basic-app"
    And a file named "source/index.html.erb" with:
      """
      ---
      ---
      foo
       http://twitter.com/ataru_kodaka/status/591598644421242880 
      bar
      """
    And the Server is running at "basic-app"
    When I go to "/index.html"
    Then I should not see "test"
    And I should not see:
      """
      <script async src="//platform.twitter.com/widgets.js" charset="utf-8">
      """
    And I should see " http://twitter.com/ataru_kodaka/status/591598644421242880 "


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

  Scenario: helper by url
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :twitter_oembed do |twitter|
        twitter.enable_convert = false
      end
      """      
    And a file named "source/index.html.erb" with:
      """
      ---
      ---
      <% url = "http://twitter.com/ataru_kodaka/status/591598644421242880" %>
      <%= twitter_oembed_by_url(url) %>
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
    
  Scenario: omit script
    Given a fixture app "basic-app"
    And a file named "config.rb" with:
      """
      activate :twitter_oembed do |twitter|
        twitter.omit_script = true
      end
      """
    And a file named "source/index.html.erb" with:
      """
      ---
      ---
      http://twitter.com/ataru_kodaka/status/591598644421242880
      """
    And the Server is running at "basic-app"
    When I go to "/index.html"
    Then I should see "test"
    Then I should not see:
      """
      <script src="//platform.twitter.com/widgets.js" charset="utf-8">
      """


