# AdoptMe App

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description

This app will be used by people who want to adopt pets from animal welfare programs near them. The PetFinder API will be used to accomplish this.
  

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** LifeStyle
- **Mobile:** Maps, Location, Real-Time
- **Story:** This app will be able to be used by animal lovers who want to adopt a new pet from a shelter near them.
- **Market:** People who are in the market for adopting a new pet.
- **Habit:** People might want to look at pictures of cute pets near them.
- **Scope:** This app will be pretty technically challenging, however we do have different aspects and features of the app that we do have in mind to complete that are feasible, and then others that will make the app better albeit are not as feasible. The stripped down version will still be interesting to build. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [x] - Setup initial project
* [x] - Setup launch screen and show app logo
* [ ] - Setup backend
* [ ] - Create login/register/continue as guest screen
* [ ] - User stays logged in when exiting app
* [ ] - User can update their password
* [ ] - User can logout from their account
* [ ] - Input or grab the location of user
* [ ] - Spit out a list of pets, their characteristics, and the distance from your current location
* [ ] - Get access to Dog API
* [ ] - Implement the dog swiping page
* [ ] - Implement the dog collection view page


**Optional Stories**

* [ ] - Automatically find location using user location
* [ ] - Display locations on MapKit (or similar)
* [ ] - New UI Implementation or Fixes


### 2. Screen Archetypes
* Login
   * Login to account or continue as guest
* Register - User signs up or logs in
   * When opening the app, the user is prompted to login if they have an account, register if they do not have an account, or to continue as a guest.
* Creation
   * Input the location(zip code or address)for parking
* Stream
   * Spit out a list of pets and their addresses in a table
* Map View
    * View locations of pets on a map
* Settings
    * Change your password

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [fill out your first tab]
* [fill out your second tab]
* [fill out your third tab]

**Flow Navigation** (Screen to Screen)

* Login/Register screen
   * Create login/register/continue as guest screen
   * ...
* Search Parking Screen
   * Input or grab the location for parking
* List View
    * View parking locations as a list
* Map View
    * View parking locations on a map
* Settings View
    * Users can change password
* Logout
    * Brings user back to login screen

## Wireframes
[Add picture of your wireframes in this section]
<iframe style="border: 1px solid rgba(0, 0, 0, 0.1);" width="800" height="450" src="https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Ffile%2FwOTzwrtGpIHSoKkD0b0WQM%2FParkMe%3Fnode-id%3D0%253A1" allowfullscreen></iframe>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype
<iframe style="border: 1px solid rgba(0, 0, 0, 0.1);" width="800" height="450" src="https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Fproto%2FqUYxTevhReyp9MqNDNSShi%2FAdoptMe%3Fnode-id%3D1%253A6%26scaling%3Dscale-down%26page-id%3D0%253A1%26starting-point-node-id%3D1%253A6" allowfullscreen></iframe>

## Schema 
[This section will be completed in Unit 9]
### Models

| Model: User       |                 |                                          |
|-------------------|-----------------|------------------------------------------|
| Property          | Type            | Description                              |
| bookmarked | Array[Pet] | A list of pets up for consideration                  |
| history           | Array[Pet] | The history of pets looked at                 |
|                   |                 |                                          |
| Model: Pet         |               |                                                           |
|--------------------|---------------|-----------------------------------------------------------|
| Property           | Type          | Description                                               |
| breed              | String        | The breed of the pet                                      |
| size               | String        | Animal size (small, medium, large, xlarge)                |
| gender             | String        | Gender of pet (male, female, unknown)                     |
| age                | String        | (Baby, young adult, senior)                               |
| color              | Animal Type   | Returns Animal Type                                       |
| coat               | String        | Return results matching annimal coat                      |
| status             | String        | Returns pets adoption status                              |
| good_with_children | bool          | true or false (1 or 0)                                    |
| good_with_dogs     | bool          | true or false (1 or 0)                                    |
| good_with_cats     | bool          | true or false (1 or 0)                                    |
| house_trained      | bool          | true or false (1 or 0)                                    |
| special_needs      | bool          | true or false (1 or 0)                                    |
| location           | String        | city, state; latitude, longitude, or postal code          |
| organizationn      | array[String] | Returns results assocaiated with specific organization(s) |

### Networking

- Login Screen
    - (Create/POST) a User
    ```swift
    PFObject *pfUser = [PFObject objectWithClassName:"User"]
    pfUser["bookmarked"] = []
    pfUser["history"] = []
    pfUser.saveInBackground { (succeeded, error)  in
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }
    ```
- Home Feed
    - (Read/GET) List of dogs nearby

- Location Page
    - (Read/GET) Location and its data values
    - (Update/PUT) Locations into History
    ```swift
    let location = {SELECTEDLOCATIONHERE}
    let favorite = true;
    let query = PFQuery(className:"User")
    query.getObjectInBackground(withId: {USERIDHERE}) { (pfUser: PFObject?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
        } else if let pfUser = pfUser {
            pfUser["history"] += {LOCATIONHERE}
            pfUser.saveInBackground()
        }
    }
    ```

    - (Update/PUT) Locations into Favorites feed
    ```swift
    let location = {SELECTEDLOCATIONHERE}
    let favorite = true;
    let query = PFQuery(className:"User")
    query.getObjectInBackground(withId: {USERIDHERE}) { (pfUser: PFObject?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
        } else if let pfUser = pfUser {
            pfUser["favorites"] += {LOCATIONHERE}
            pfUser.saveInBackground()
        }
    }
    ```


- History Feed
    - (Read/GET) List of location histories

    ```swift
    // iOS
    // (Read/GET) Query all posts where user is author
    let query = PFQuery(className:"History")
    query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
       if let error = error {
          print(error.localizedDescription)
       } else if let locations = locations {
          print("Successfully retrieved \(posts.count) posts.")
          // TODO: Do something with posts...
       }
    }
    ```


    - (Delete) certain locations off the feed

    ```swift
    let query = PFQuery(className:"History")
    query.deleteAll(inBackground: [{LOCATIONTODELETE}]) { (succeeded, error) in
        if (succeeded) {
            // The array of objects was successfully deleted.
        } else {
            // There was an error. Check the errors localizedDescription.
        }
    }
    ```

   
   
- Favorites Feed
    - (Read/GET) List of location favorites
    ```swift
    // iOS
    // (Read/GET) Query all posts where user is author
    let query = PFQuery(className:"Favorites")
    query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
       if let error = error {
          print(error.localizedDescription)
       } else if let locations = locations {
          print("Successfully retrieved \(posts.count) posts.")
          // TODO: Do something with posts...
       }
    }
    ```

    - (Delete) certain locations off the feed
    
    ```swift
    let query = PFQuery(className:"Favorites")
    query.deleteAll(inBackground: [{LOCATIONTODELETE}]) { (succeeded, error) in
        if (succeeded) {
            // The array of objects was successfully deleted.
        } else {
            // There was an error. Check the errors localizedDescription.
        }
    }
    ```

## Sprint 1
<img src='https://github.com/Alankvuong/ParkMe/blob/main/ParkMe-Sprint1-ShowLaunchScreen.gif?raw=true' />

## Sprint 2
<img src='https://github.com/zekekim/AdoptMe/blob/release/AdoptMe-Sprint2.gif?raw=true' />


