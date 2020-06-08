Feature: Smoke campaign
	 Background:
	  Given Navigate to the "homepage"

	 Scenario: Scenario 1 Check if main page loads
	  Then Verify that homepage is loaded

	 Scenario Outline: Scenario 2 Check if links load
	  Then Verify that <page> is loaded
	   Examples:
	     | page |
	     | http:\\qainterview.pythonanywhere.com\privacy  |
	     | http:\\qainterview.pythonanywhere.com\terms  |
	     | https:\\qxf2.com\?utm_source=qa-interview&utm_medium=click&utm_campaign=From%20QA%20Interview  |

	 Scenario: Scenario 3 Verify if calculate is working
	  When Inputing value "1" into Calculate form
	   And Click on "Calculate!"
	  Then Verify that text "The factorial of" exists 
