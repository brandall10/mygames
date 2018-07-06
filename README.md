# LeaseLabs Engineering Assessment Documentation - App

## Project Notes

This is a continuation of documentation from [the api portion](https://github.com/brandall10/test-engineer).  Please review the notes for part #1 there first.

Regarding the other portions:
- General site functionality (#2 and #3) are complete per the spec.  
- #4 is working for the search term only, did not spend time on the category selection.  
- #5, the download of categories, works well. It is worth noting that I was able to get this to work without hitting the filesystem on the server. 

Other notes:
- Integration tests are present, spec requests using rspec with capybara. VCR is used to generate http fixtures from a live api server.  In general I'm a fan of simulating a live system as closely as possible and VCR does a good job of it, but there are some drawbacks (chiefly index redirects after objects are created/updated/destroyed).  I tend to use mock objects for complex stateful interactions and stub trivial requests.
- I mostly reused erb templates from the API.  The instructions appeared to focus on functionality, so I elected to skip making it nicer than this.
- Forms are using tag builders as there is no ORM present, the controllers interface directly with the client-side GameLibrary API.  One could elect to use ActiveModel to wrap the API calls and use object based form builders.   

## Task Instructions

### For validating the application
  - Follow instructions from the readme in [the api repository](https://github.com/brandall10/test-engineer) to setup the api and local DNS
  - Pull down latest code here and run ```bundle install```
  - Run tests: ```bundle exec rspec```
  - Now start up the server ```bundle exec rails s -p 3001```
  - Optional: a Procfile is present if you would like to use Foreman to startup and bring-down the app in conjunction with the api.  If you do not have Foreman installed and/or subcontractor (allows running executables in different dirs) just run:
    - ```gem install foreman && gem install subcontractor```
    - And then you can run: ```foreman start```
