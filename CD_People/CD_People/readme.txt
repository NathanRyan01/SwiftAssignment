Name: Nathan Ryan O’ Heir
Student Number: 110385567
Assignment: 2

HistoryTableViewController
This contains all the items that the user has purchased.

PeopleTableViewController
This will display all the items in the users shopping cart. It also allows each user to edit or delete an item form the shopping cart.

AddPersonViewController
This allows a user to add to the shopping cart or update an existing item.

statisticsViewContoller
This will take all the contents from the HistoryInfo table and get the following statistics:
-Total number of items purchased
-Average amount spent
-Total spending
This file also contains a pound to euro/ euro to pound converter.

mainViewContoller
This is the initial view controller
I added background music using functionality provided by the AVFoundation import
Contains background image 
5 buttons
-History -> This goes to HistoryTableViewController.
-Complete Purchase -> This will complete your purchase and add items in your cart to the 
HistoryInfo table and remove them from the add and PersonInfo table. This will also display an alert box letting the user now the purchase has been completed and where to go to see this.
-Add to Cart-> This goes to PeopleTableViewController.
-Statistics-> This goes to statisticsViewController.
-Review> This goes to to ReviewTableViewController.

ReviewTableViewController
This displays all the reviews the user has has submitted. These reviews can be edited or deleted.

AddUpdateDeleteReviewViewController
This allows the user to add a review about the shopping cart or edit an existing review.
This also has an animation on the screen, once the user clicks to button to view the animation. the animation also contains a subview with text.

MusicViewController
This controller allows users to play or stop any of the songs displayed on the screen.
