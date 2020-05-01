# SlavaGo

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)
5. [App-Pitch-Presentation](#App-Pitch-Presentation)
6. [Authors](#Authors)
7. [Future Emplementations](#Future-Emplementations)

## Overview
### Description
An app targeted to runner where they can find fellow runners and conversate.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Excerise
- **Mobile:** App will only be for mobile since Runners usually have their phone with them. Desktop functionality in the future.
- **Story:** Helps users track their progress, allows them to meet other runners and find fellow running events.
- **Market:** This app is for all age groups.
- **Habit:** This app could be used daily since excerise is a part of every healthy indivual's life. 
- **Scope:** This is particulary for runners, but it can be used for other activities in the future such a gym meets, walking, hiking, etc..

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User can log in using email and password
- [x] User can sign up using email, password and upload avatar photo
- [X] As a logged-in user, I want to be able to send instant messages to my friend.
- [x] As a logged-in user, I can see the whole conversation with my friend.
- [X] As a logged-in user, I create a run

**Optional Nice-to-have Stories**

* As a logged-in, I want to be able to track my miles and stats to see my progress.
* As a logged-in user, I want to like any status that any of my friends posted regarding accomplishments/activities.
* As a logged-in user, I want to be able to gain “achievements” whenever I do specific tasks.
* As a logged-in user, I want to be able to update my profile.

### 2. Screen Archetypes

* Login
   * User can use email and password to login into app
* Sign Up
    * User can sign up with username, email and password 
* Home/feed
   * User can see what fellow runners are up to
   * Users can post status in this page.
* Profile
    * User can see his profile, friends and achievements
* Messages
    * User can see messages here and create/send messages to fellow runners
* Create Run
    * User can create a run here 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home
* Upload Run
* Messages

**Flow Navigation** (Screen to Screen)

* Landing Page
   * Login Screen
   * Sign Up
* Home
   * Profile
   * My Notifications
   * Notifications
* Messages
   * My Messages
   * Messages
*Create Run

## Wireframes
<img src="images/Slava.png" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
### Models
Main User
| Property | Type | Description |
| ------ | ------ | ------ |
| Objectid | string | id for main user
| Username| string | string for username
| Avatar | file | file that holds user avatar
| Email | string | string for email
| Password | string | string for password

Status
| Property | Type | Description |
| ------ | ------ | ------ |
| Objectid | string | unique id for user post
| Content | string | content of status
| Author | pointer to user | author of status
| createdOn | DateTime | creation time
| updatedOn | DateTime | updated time

Run
| Property | Type | Description |
| ------ | ------ | ------ |
| Objectid | string | unique id for run
| Title | string | Title of run
| Time & Date | TimeDate | time of run
| Place | string | location of run
| Pace | DateTime | Pace of run

Message
| Property | Type | Description |
| ------ | ------ | ------ |
| Objectid | string | unique id for messafe
| Content | string | content of message
| avatar | pointer to user | image of sender
| time | DateTime | Time of message sent.

Friend
| Property | Type | Description |
| ------ | ------ | ------ |
| Objectid |pointer to parse object | pointer to object
| avatar | pointer to parse object | pointer to object
### Networking
Feed/home
- (Read/Get) Query all posts
- (Create/Post) Create a new status/ comment on a status
- (Delete) Remove existing status

Profile
- (Read/Get)Query logged in user object
- (UpdatePut) Update user avatar
- (Read/Get) Query logged user’s friends 

Create an account
- (Create/Post) Create a new user

Upload Run
- (Create/post) Create a new run

## App Walkthrough

### Sign-Up/Login

#### Walkthrough of the following user stories:
- [x] User can log in using email and password
- [x] User can sign up using email, password and upload avatar photo
<div class="row">
    <img src="http://g.recordit.co/Sd1sOtg6OI.gif" title='Video Walkthrough' width='' alt='Video Walkthrough'>
    <img src="http://g.recordit.co/MJjAYR7jvM.gif" title='Video Walkthrough' width='' alt='Video Walkthrough'>
</div>

### Sending Messages

#### Walkthrough of the following user stories:
- [X] As a logged-in user, I want to be able to send instant messages to my friend.
- [x] As a logged-in user, I can see the whole conversation with my friend.
<img src='http://g.recordit.co/cgS1Z0RHUP.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### Uploading New Runs

#### Walkthrough of the following user stories:
- [X] As a logged-in user, I can create a new run
<img src='http://g.recordit.co/Lr3uwiXsB1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

## Video Walkthrough Of SlavaGo
<video src="Main.mp4" width="320" height="200" controls preload></video>

## App-Pitch-Presentation
Link to our slideshow: <a href="https://docs.google.com/presentation/d/1350gQv4JotZXGFgQBTsFjrFjYaGA0-SRtwOb0bJmhx8/edit#slide=id.g76d1842c48_1_3" target="_blank">SlavaGo</a>  

## Authors

* Eduardo Garcia - <a href="https://github.com/egarcia135" target="_blank">egarcia135</a>
* Eduardo Garcia - <a href="https://github.com/weordaz" target="_blank">weordaz</a>

## Future-Emplementations
* Connecting specifically with Garmin to allow users to see real time posts without having to manual upload.
* Will be able to see where they ran by implementing a map to their posts.
* Send image messages
* Creating a profile that will show personally achievements, followers/followings, achievements, and weekly mileage.
* Adding videos and photo to your run
* Adding likes, comments, and shared functionalities.
* Creating a notifications bar allowing the user to see who liked, commented, or shared their run.
