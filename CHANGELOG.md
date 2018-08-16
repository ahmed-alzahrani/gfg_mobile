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

__09/08/18__

- Added subscription / unsubscription from Detailed Player view page

- When a detailed player page is loaded, there is a cupertino picker with all of the charities in it

- If a user is subscribed to the player, an unsubscribe button populates the app bar and vice versa

- When pressed, the subscribe button creates a subscription through the backend in Firestore with the relevant player/charity

- Added a trim() to the email submitted in userValidator to protect against erroneous white spaces

- Used Navigator to fix logout flow from Players page, needs to be replicated across all pages

- Updated Player model

- Added logout route to main.dart

- Added imagePath to charity objects as they arrive from the backend

__10/08/18__

- Added photos, description and raised button with link to external website on each Charity Details Page

__11/08/18__

- Added individual asset paths to assets in pubspec.YAML to supress IDE warning

- Added Themes class to serialize theme info across all pages such as textColor, style etc

- Created new dark theme across the app with background color as Colors.grey[850], a black secondary color for the tab bar and app bar, and Colors.limeAccent[700]

- Changed Charity Details Page from a container to a column of containers

- Wrapped BottomNavigatorBar to a theme in order to change its background by specifying a canvas color

- Added leading iconButton to detail pages in order to override default iconButton and change its color

__12/08/18__

- Added numbers and statistics information to player model in order to populate detailedPlayer page

- Added null check in auth service for when the app starts up and we check for a logged in user so we don't try access null.uid

- Minor UI updates to login page

- Added drop down menu to detailed players page that is populated with the charity names, and is linked to subscription logic to add subscription with that charity

- Added playerBarTitle to theme object

__14/08/18__

- Added search bar functionality to players page that filters by team / name / league, and shows a subsection of the total players based on that search data

- Added injured (true/false) to player model (Football API does NOT accurately report this)

- Simplified constructors for Player and Stats class as well as Charity class

- Changed CircleAvatar child from letter representing position to player's number

- Added basic player info to detailed page (age / position / team / league)

- Added player information to Detailed Player Page (limited info as the detailed player queries are not working)

- Made Logout button persistent across all screens of tab bar

- Implemented Profile page as a stateful widget instead of a stateless one

- Added search bar to charities page

- Fixed keyboard overflow in players and charities page by setting resizeToAvoidBottomPadding to false in the scaffold on each page

__15/08/18__

- Swapped Subscriptions page for My Matches so Subscriptions is a main page in the bottom tab bar controller and Matches is reachable through user profile

- Set up navigation in between Profile and Matches

- Set up retrieval of Profile information from the server using current user uid

- Added Models for Profile / Stats / Goal to work with incoming profile information from Firestore

- Added all icons to theme and took them off home page

- Now incoming request for usr profile info successfully serializes the response.data into a Profile object

- Tweaked typing in Profile class

- Implemented Subscriptions page as a searchable page of subscriptions by charity or player name

- Setup mock About Page with Lorem Ipsum un-formatted text

- Profile Page has been started, although currently the form collapses whenever the keyboard is opened

- Added Subscription model and set up navigation to and from Subscription Details Page from Subscriptions

__16/08/18__

- Added in a picker for the subscription details page to update a subscription that is already in place

- Also added a button to delete subscriptions and re-navigate back to the Subscriptions page with the deleted subscription removed

- Fixed case where user backs from sub details to subs after either editing the sub or leaving it alone

- Added Matches Page showing the next month worth of matches the user has players featured in

- Loading time for matches from back end is very slow, so i added in a circular progress indicator for the user so they understand it is loading

- Added a new alert Dialog when the user clicks on a match in Matches, it shows them all the players they are subcribed to that are playing in that match