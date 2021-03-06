# Flutter-III-myCompany

## Content Table

- [Set up](#set-up)
- [Mock up](#mock-up)
- [Route Map Navigation](#route-map-navigation)
- [User Stories](#user-stories)
- [Data Models](#data-models)
- [Firestore Documentation](#firestore-documentation)

## Set up

This project is divided in two main parts. There is the mobile application and the admin console.

### Mobile Application

You can launch this project using any IDE on Android or iOS. The application concerned is `mycompany` so launch the application from this folder.

### Admin Console

You can launch this project with the command line `flutter run -d chrome`. The folder of this web application is `mycompany_admin`.

## Mock up

To design our application, we decided to go with Figma into a full mock up of our mobile application and our admin console. We didn't take the time to prototype it because of the lack of time and the lack of use in our project.

[Link to our mobile mock up](https://www.figma.com/file/f1hUvDjGJOyvWnQnPnrROc/myCompany?node-id=0%3A1)

[Link to our admin console mock up](https://www.figma.com/file/f1hUvDjGJOyvWnQnPnrROc/myCompany?node-id=184%3A9)

## Route Map Navigation

### Mobile App:

<img width="455" alt="Capture d’écran 2021-12-13 à 12 24 26" src="https://user-images.githubusercontent.com/37048180/145804096-54436795-48be-4ba2-b25e-7c35667a2ee1.png">

### Web App:

<img width="672" alt="Capture d’écran 2021-12-12 à 22 55 01" src="https://user-images.githubusercontent.com/37048180/145731120-9fda7240-47b4-472e-a8c7-673f5022636d.png">

## User Stories

### Mobile App:

#### Account:

As a user I want to login to the mobile app. <br />
As a user I want to register on the mobile app. <br />

#### Company:

As a user I want to create a company. <br />

#### Task:
As a user I want to see all the tasks assigned to me. <br />
As a user I want to see all the tasks linked to my company. <br />
As a user I want to create a task. <br />


#### Meeting:
As a user I want to see all of my next meetings.  <br />
As a user I want to create a meeting.  <br />

#### User:
As a user I want to be able to edit my profile information.


### Web App:

#### Account:
As an admin I want to login to the web app. <br />
As an admin I want to register on the web app. <br />

#### User: 
As an admin I want to create an account for a user. <br />
As an admin I want to modify the information for a user. <br />
As an admin I want to delete a user. <br />
As an admin I want to see all the information linked to a user. <br />

#### Company:
As an admin I want to create a company. <br />
As an admin I want to modify the information concerning my company. <br />
As an admin I want to delete a company. <br />
As an admin I want to see all the information linked to a company. <br />

#### Meetings:
As an admin I want to create a meeting. <br />
As an admin I want to modify the information concerning a meeting. <br />
As an admin I want to delete a meeting. <br />
As an admin I want to see all the information linked to a meeting. <br />

#### Tasks:
As an admin I want to create a task. <br />
As an admin I want to modify the information concerning a task. <br />
As an admin I want to delete a task. <br />
As an admin I want to see all the information linked to a task. <br />

#### Projects:
As an admin I want to create a project. <br />
As an admin I want to modify the information concerning a project. <br />
As an admin I want to delete a project. <br />
As an admin I want to see all the information linked to a project. <br />

#### Pole:

As an admin I want to create a pole. <br />
As an admin I want to modify the information concerning a pole. <br />
As an admin I want to delete a pole. <br />
As an admin I want to see all the information linked to a pole. <br />


## Data Models

- Company
```json
"company": {
  "id": "string",
  "name": "string",
  "address": "string",
  "zipCode": "string",
  "city": "string",
  "country": "string",
  "contact": "string",
  "phoneNumber": "string",
  "users": [
    "string"
  ],
  "poles": [
    "string"
  ]
}
```
- Meeting
```json
"meeting": {
  "id": "string",
  "users": [
    "string"
  ],
  "name": "string",
  "dateStart": "number",
  "duration": "number"
}
```
- Pole
```json
"pole": {
  "id": "string",
  "name": "string",
  "color": "string",
  "companyId": "string"
}
```
- Project
```json
"project": {
  "id": "string",
  "name": "string",
  "description": "string",
  "color": "string",
  "companyId": "string",
  "tasks": [
    "string"
  ]
}
```
- Task
```json
"task": {
  "id": "string",
  "name": "string",
  "description": "string",
  "estimatedTime": "number",
  "state": "string",
  "deadLine": "number",
  "user": "string"
}
```
- User
```json
"user": {
  "id": "string",
  "firstName": "string",
  "lastName": "string",
  "email": "string",
  "address": "string",
  "zipCode": "string",
  "city": "string",
  "country": "string",
  "phoneNumber": "string",
  "role": "string",
  "projects": [
    "string"
  ],
  "poles": [
    "string"
  ],
  "companyId": "string"
}
```

## Firestore Documentation

- Company methods (inside CompanyService) : 
  - setCompany(Company object) -> Create / Update
  - deleteCompany(String companyId) -> Delete
  - readCompany(String companyId) -> Read

- Pole methods (inside PoleService) :
  - setPole(Pole object) -> Create / Update
  - deletePole(String poleId) -> Delete
  - readPole(String poleId) -> Read
  - readPoles(List<String> polesId) -> Read several poles
  - readPolesFromCompany(String companyId) -> Read all poles belonging to one Company
  
- Project methods (inside ProjectService) :
  - setProject(Project object) -> Create / Update
  - deleteProject(String projectId) -> Delete
  - readProject(String projectId) -> Read
  - readProjects(List<String> projectsId) -> Read several projects
  - readProjectsFromCompany(String companyId) -> Read all projects belonging to one Company
  
  
- Task methods (inside TaskService) :
  - setTask(Task object, String projectId) -> Create / Update
  - deleteTask(String taskId) -> Delete
  - readTask(String taskId) -> Read
  - readTasks(List<String> tasksId) -> Read several projects
  - readTasksFromUser(String userId) -> Read all tasks belonging to one user
  
- User methods (inside UserSevice) : 
   - registerUser(String email, String password, UserFront user, String companyId) -> Create User & Register
   - signInUser(String email, String password) -> Sign In User
   - readUser(String userId) -> Read
   - readUsers(List<String> usersId) -> Read several users
   - updateUser(UserFront user) -> Update
  
- Meeting methods (inside MeetingService) :
  - setMeeting(Meeting meeting) -> Create / Update
  - deleteMeeting(String meetingId) -> Delete
  - readMeeting(String meetingId) -> Read
  - readMeetings(List<String> meetingsId) -> Read several meetings
  - readMeetingsFromUser(String userId) -> Read all tasks linked to one user
