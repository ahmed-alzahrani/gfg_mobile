##Changelog

__01/08/18__

- Added login / account registration through Firebase via e-mail and password

- Added validation for e-mail (password regex still to add)

- Including updated states for logging in / creating an account

- Added flow to a main page if the user is succesfully logged in

- Routed account creation upon Firebase Auth registration through GFG-Webapp, a user is now created in the DB when an auth user is created

- Configured Firebase project with Android on client (iOS still to add)

__02/08/18__

- Added password reset request to login page

- Added data_service and migrated responsibilities of collecting allPlayer, all charities, matches, playerMatches and specific
players to data_service

__03/08/18__

- Added basic implementation of all subscription_service responsibilities

- This includes adding, removing, updating, verifying and querying user subscriptions through the node js backend

__08/08/18__

- Added tab bar controller to Main page that toggles through Profile, Players, Charities, Matches, and About

- Added page for each view and set up toggling between each view on click

- Setup Players page as a basic list view that pulls the info from the server and displays each player

- Added Charity table view on load

- Removed extra prints from players page

- Set all titles to centre title

- Added models for Player and Charity information

- Added two new pages, Charity Details and Player Details page to show detailed information on Player/Charity information once it has been clicked on from the list

- Set up Navigation from Players / Charities to detailed view and back