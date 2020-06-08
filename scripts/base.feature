Feature: Base Campaign
         Background:
          Given Navigate to the "homepage"

	 Scenario Outline: Scenario 1 Verify fields on page
          Then Verify that text "<phrase>" exists
           Examples:
            | phrase |
            | The greatest factorial calculator! |
	    | Terms and Conditions     |
	    | Privacy |
	    | Qxf2 Services   |

	 Scenario Outline: Scenario 2 Verify calculation correctness
       	  When Inputing value "<input>" into Calculate form
           And Click on "Calculate!"
          Then Result message is "The factorial of <input> is: <result>"
       	  Examples:
       	   | input    | result                 |
       	   | 0        | 1                      |
       	   | 23       | 2.585201673888498e+22  |
       	   | 170      | 7.257415615307999e+306 |

	 Scenario Outline: Scenario 3 Verify calculation error message
       	  When Inputing value "<input>" into Calculate form
           And Click on "Calculate!"
       	  Then Result message is "<resultmsg>"
       	  Examples:
           | input  | resultmsg				|
           | aaa    | Please enter an integer		|
           | -1     | Value out of bounds 		|
           | 171    | The factorial of 171 is: Infinity |

	 Scenario Outline: Scenario 4 Verify links
       	  When Click on "<link>"
          Then Verify that text "<pagetext>" exists 
          Examples:         
           | link		 | pagetext										 |
           | Privacy		 | This is the privacy document. We are not yet ready with it. Stay tuned! 		 |
           | Terms and Conditions| This is the terms and conditions document. We are not yet ready with it. Stay tuned!  |
           | Qxf2 Services   	 | QA for startups   	 	    	      	     	     	   	    	 	 |

	 Scenario: Scenario 5 Verify layout on the page
          Then Verify layout
