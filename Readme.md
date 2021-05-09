Readme for the Github followers app

Project description : iOS GitHubFollowers app built using GitHub APIs to display the followers of a user and to get the user information of a particular user . 

Technical information :
1. Development Language Used : Swift 5
2. Current Version : 1.0
3. Build : 1
4. Deployment target : iOS 14.4
5. XcodeVersion : 12.4
6. Supported Devices : iPhone , iPad
7. Third Party Software : GitHub API
8. Github URL : https://github.com/ramnathsridhar/weather-app.git

Steps to run project :
1. Download proejct from github URL
2. Open GitHubFollowersApp.xcodeproj
3. Run the project

App Usage :
1.  On launching the app , use can enter a github username and click on "Search Username" to get the list of followers of the user
2.  If the user has followers , they are displayed in a collectionview
3.  The user can scroll down to see the list of followers . The maximum number of followers displayed by default is 100 . If there are more follwoers present , user needs to scroll to the bottom following which the next 100 followers are fetched and displayed
4.  User can make use of the search textfield to search for a particular follower 
5.  To get more information about a particular follower , user needs to click on the follower
6.  The name , location , bio , followers , number of public repos , number of public gists are displayed 
7.   If user wants to view the complete profile of the follower , "Git Profile" button needs to be clicked on . The user will be redirected to the Safari browser to view the complete git profile
8.   If the user wants to see the list of followers , for the particualr follower "Get Followers" button needs to be clicked on 
9.   To save a user as a favourtie , the add favourite button "+" on top of the navigation bar needs to be clicked on  
10. If the user is not added as a favourtie , the user is added as a favourtie . If user is already added as a favourtie then the error popup is displayed
11. If the user wished to see the list of favourite users , the "Favourites" tab needs to be selected
12. The list of favourite users is listed in this page , if previously added
13. If user wishes to delete a favourtie user , the user needs to be selected and swiped to the right , to display the delete option . On clicking of delete the favourite user is removed from the list


iOS Development Technologies and Concepts used :
1.   MVVM Architecture
2.   Depenedency Injection
3.   Delegate Protocol Communication Patterns
4.   Network calls using URLSession
5.   Animations
6.   Pagination
7.   CollectionView Diffable Data Source
8.   UIKit
9.   Autolayout
10. Programatic Autolayout Constraints
11. SearchController
12. Persistance using UserDefaults
13. Singleton design pattern
15. Extensions
16. Resuable Views

Project Structure :
1. Extensions : Contains the extensions of String , UIViewController , UIImageView , Date
2. Utilties : Contains constants used in app
3. Managers : Contains the manager classes for networking and persistence
4. ViewModel : Contains the view model of the corresponding view controllers
5. Model : Contains the structures of the response json
6. View : Contains the view controller and the custom views which have been used in the app


Scope of Improvement :

