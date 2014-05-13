#Description#

Peppermint is a personal finance site with social features to spice things up.

Users can create budgets, goals, and view transactions.  Users can also follow people, view other users' public goals and budgets as well
as fame/shame (upvote/downvote) users progress on their goals and budgets.

##Features##

###Transactions###

Transactions belong to a merchant category and an account.  Merchant categories are codes that describe what the type of merchant the transaction was done at.  There are a lot of specific merchant categories.  Because of that merchant categories then belong to a Transaction Category.  These transaction categores are what budgets use to track and are fairly generic such as "Food/Entertainment" or "Rent".  These will are not user definable.

###Budgets (app/models/budget.rb)### 

Users can create budgets that track transaction categories.  Users can choose when these budgets "reset".  That is, are they tracked daily, weekly, or monthly, and when in the week or month it should reset.  Example is a user wants to track their Food/Entertainment budget on a weekly basis and have the budget roll over on Mondays, or Tuesdays.  Users can choose Monthly as well and choose Beginnining of Month, Middle of Month, and End of Month.  This is done using metaprogramming to define the periods (see the progress.rb in models/concerns).  Budgets can be marked as public or private.  Public budgets will broadcast the user's progress to every user in the system (discussed in the Shares section).  Private is only visible to the user who defined the budget.

###Goals (app/models/goal.rb)###

Creating a goal will track an account's balance over time.  When the user creates a budget, they will specify 4 things: an account to track, a goal  amount, an end date, and a goal name.  Saving the budget will initiate a callback to calculate the initial account balance.  From there the goal will calculate a montly amount necessary to meet the goal.  Like budgets, goals can be marked as private or public.

###Charts###

There are three types of charts used on this site: Bar, Line, and Pie.  The bar charts are done using a gem called Chartkick.  Line and pie charts are done in JS using Google Charts.

The pie chart has click handlers on each section so the user can click a section of the pie chart and a list of transactions will narrow down to the selection by the user.  Clicking outside the pie chart will reset the transactions back to all of them.  Clicking a section fires off an AJAX request so there is no page refresh.

###Progress (app/models/concerns/progress.rb)###

Goals and models share the progress concern which is responsible for calculating the reset date for budgets and goals.  It is also responsible for calculating if the user is on track to meet their goal or budget.

###Fame/Shame (app/models/concerns/fameable.rb)###

Goals and budgets that are public will broadcast a share to all users in the system.  Users can give fame or shame on the users' progress (upvote and downvote).

###Shares (app/models/concerns/shareable.rb)###

Public goals and budgets will create "Shares" that all users can see in their feed.  When a user logs in the system does a callback to check the status of each of the users goals and budgets and creates a share for the progress.

###Messages (app/models/message.rb)###

Users can message one another.  The messages on the user show page will eventually be moved to Backbone.js.

###Notifications (app/models/concerns/notifiable.rb)###

When the user logs in, during the share callback, if the user is overbudget or under their goal progress, the system creates a notification for the user to check their goal/budget.  Also, when a user comments, or gives fame, a notification is created that the user can see.  The notification creates a URL that brings the user to whichever item the notification applies to.

###Comments (app/models/concerns/commentable.rb)###

Shares can be commented on.  Comments will generate a notificiation for the receiver of the comment.

##Technologies Used##
The backed is written in Ruby on Rails with some JavaScript/jQuery front end elements to allow users to interact with the charts.
Users can click on a section of a pie chart and a table will update with the new category.

Ruby on Rails

JavaScript

jQuery

AJAX

HTML

CSS

The line and pie charts are written using Google charts Javascript library

##Planned updates##
Add backbone.js to messaging and news feed

Add jQuery to Budget creation so that one the monthly/weekly dropdowns appear under certain conditions.

Oauth

Email authenticate/password reset

Add logic to notification and share creation so that it doesn't happen too often.