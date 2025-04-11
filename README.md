# iOS Native Coding Challenge


## Requirements:
- Build a native iOS app written in Swift
- Use this repo and commit often
- Styling is not important, but try and make it aesthetically pleasing. 
- Use best practices of clean code


## Minimum Expected Functionality:

1. Login functionality:
   1. Take input from the user and process it.
   2. Validate credentials against `username: user_good` and `pw: pass_good`
   3. Validate username: it should only accept letters and underscore.
   4. If login is successful, take them to post-login screen
   5. If not, Please Display meaningful error message
2. Logout functionality: Takes them back to login screen
3. Make GET requests to `https://dummyapi.io/ ` to pull required details.

## Minimum Expected Screens:
1. Login Screen: has two fields and CTA button
2. Post-login Screen: 
   1. display list of users from https://dummyapi.io/ (graphql preferred but REST is ok)
   2. logout button 

- - - -

## Bonus Functionalities:
1. Display users with their images
2. Load more users on scroll (dummyapi has data pagination where it takes page number as a query param in the API, example:  https://dummyapi.io/data/api/user?page=1&limit=10)

## Bonus Screen:
- User detailed Screen: When a user from the list is tapped on, a new screen is displayed with their full profile. 


