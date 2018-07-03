# LeaseLabs Engineering Assessment Documentation - App

## Project Notes

This is a continuation of documentation from [the api portion](https://github.com/brandall10/test-engineer).  Please review the notes for part #1 there first.

Regarding the other portions:
- Functionaly speaking, #2 and #3 are complete.  
- #4 is working for the search term only, did not spend time on the category selection.  
- #5 was attempted but it doesn't appear the CSV output is zipped properly.  A zip file is downloaded though.  There are several test csv files in this repo that inadventently were checked-in, sorry! (I should have used Tempfile here as well)
- While tests are mostly addressed for the API, I did not get around to writing tests for the front-end app.  My general approach for testing APIs is to create mocks or use VCR to generate HTTP fixtures from live requests, I would have likely done the latter here. 
- I mostly reused erb templates from the API.  The instructions appeared to focus on functionality, so I elected to skip making it nicer than this.  Time permitting I would have liked to improve styling and layout

As noted in my submission email there was an unfortunate personal issue which took up much of the time I earmarked to get this done.  While I was cleared to finish this by midnight instead of end of business on Monday, this assessment was done under a fair bit of duress and exhaustion.  It's unfortunate, but it is what it is.  If the team finds it helpful I'd be happy to work on another task that can demonstrate my testing skill.  As a rule I don't typically push up PRs without a full complement of tests.

## Task Instructions

### For validating the application
  - Follow instructions from the readme in [the api repository](https://github.com/brandall10/test-engineer) to setup the api and local DNS
  - Pull down latest code here and run ```bundle install```
  - Now start up the server ```bundle exec rails s -p 3001```
  - Optional: a Procfile is present if you would like to use Foreman to startup and bring-down the app in conjunction with the api.  If you do not have Foreman installed and/or subcontractor (allows running executables in different dirs) just run:
    - ```gem install foreman && gem install subcontractor ```
    - And then you can run: ```foreman start```
