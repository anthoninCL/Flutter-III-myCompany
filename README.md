# Flutter-III-myCompany

## Data Models

- Company
```
company: {
  id: string,
  name: string,
  address: string,
  zipCode: string,
  city: string,
  country: string,
  contact: string,
  phoneNumber: string,
  users: [
    id: string // id of an item from the users collection
  ],
  poles: [
    id: string // id of an item from the poles collection
  ]
}
```
- Meeting
```
meeting: {
  id: string,
  users: [
    id: string // id of an item from the users collection
  ],
  name: string,
  dateStart: number,
  duration: number
}
```
- Pole
```
pole: {
  id: string,
  name: string,
  color: string,
  companyId: string
}
```
- Project
```
project: {
  id: string,
  name: string,
  description: string,
  color: string,
  companyId: string // id of a company,
  tasks: [
    id: string // id of an item from the tasks collection
  ]
}
```
- Task
```
task: {
  id: string,
  name: string,
  description: string,
  estimatedTime: number,
  state: string,
  deadLine: number,
  user: string // id of a user
}
```
- User
```
userFront: {
  id: string,
  firstName: string,
  lastName: string,
  email: string,
  address: string,
  zipCode: string,
  city: string,
  country: string,
  phoneNumber: string,
  role: string,
  projects: [
    id: string // id of an item from the projects collection
  ],
  poles: [
    id: string // id of an item from the poles collection
  ],
  companyId: string
```

## Firestore documentation

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
  
  
  
  
  
  
  
  
  
