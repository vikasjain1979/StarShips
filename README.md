# Starship Application 

# Requirements

⁃	Master page with all starship details + 2 additional properties

⁃	Detail page to show detail of each starship

⁃	Favourite the starship from Master/Detail page

⁃	List the favourite items

⁃	Sorting options

⁃	Navigation

⁃	Error handling



# MVVM architecture
For this application, I have used the MVVM. For this application even MVC would have been good as its very small and very less integration points.
But comsidering the scalability, flexibility and clean architecture I opted for MVVM.

# View/Controller
   * Master view : Load the starships detail with 2 properties + Sorting + Favorites tab
   * Detail View 

# View Model
   * GetStarshipData
   * ManageFavorite
   * IsFavorite
    
# Model
   * Codable Data Objects
   * Error object


•	For API calls I have integrated with Alamofire(v5.4.3) using SPM

•	Unit Tests: Added unit tests for all public methods of ViewModel

•	Error Handling: Handling error for any API failures using the StarShipError object 

•	Sorting: Have added options to sort by name and cost as of now based on properties shown on master view. 


# NFRs

- Device orientation support
  * Supports both portrait and landscape mode

- Device Size check
   * Tested on iPhone 8 and iPhone 12
   * Have used constraints so should be good on other devices as well
   * Runs on iPad as well

- Supported OS Version
   * iOS 13 and above 

- Accessibility
   * Supports and tested for voiceover accessibility


