### 🧠 Core Pages

1. **Login & Authentication (Admin, Member roles)**  
2. **Home (Team List View)**  
3. **Team Detail (Project List per Team)**  
4. **Project Detail Page**  
5. **Member Profile Page (on hover/click)**  
6. **Admin Dashboard (to manage users, projects, teams)**

---

### 🔐 Authentication & Role System

#### Roles:
- **Admin**: Can add/update/delete team, projects, assign members
- **Member**: Can only view assigned projects and update messages/status

Use **JWT-based Auth** for backend:
- `POST /auth/register` → for admin
- `POST /auth/login` → for both
- Middleware to verify role: `authMiddleware("admin")`

---

### 🗃 MongoDB Collections (Schemas)

#### 1. User
```ts
{
  _id,
  name,
  email,
  passwordHash,
  role: "admin" | "member",
  profileImage,
  designation,
  skills: [String]
}
```

#### 2. Team
```ts
{
  _id,
  name,
  members: [ObjectId], // User references
  projects: [ObjectId]  // Project references
}
```

#### 3. Project
```ts
{
  _id,
  name,
  clientName,
  groupName,
  googleSheetUrl,
  assignedMembers: [ObjectId], // user IDs
  currentPhase: "design" | "development" | "deployment" | "uiux" | "research",
  deadline: Date,
  totalBudget: Number,
  phaseBudget: Number,
  teamId: ObjectId,
  lastUpdate: {
    message: String,
    updatedAt: Date
  },
  about: String,
  phaseAssignments: {
    design: [ObjectId],
    development: [ObjectId],
    deployment: [ObjectId],
    uiux: [ObjectId],
    research: [ObjectId]
  }
}
```

---

### 📦 Backend Routes (Express.js)

#### Auth
- `POST /auth/login`
- `POST /auth/register` (admin only)

#### Teams
- `GET /teams` – list all teams (for homepage)
- `GET /teams/:id` – get specific team (project list)
- `POST /teams` – create team (admin only)
- `PATCH /teams/:id` – update team

#### Projects
- `GET /projects/:id` – project detail
- `POST /projects` – create project
- `PATCH /projects/:id` – update deadline, members, phase, etc.
- `GET /projects` – optional, get all (with sort by deadline)

#### Users
- `GET /users/:id` – for hover profile info
- `GET /members` – list members (for assignment UI)

---

### 🖼 Frontend Page Flow

#### 1. Home Page (Team List)
- Card per team: Name, total projects, $ delivery, workload, work done, and nearest deadline project.
- `GET /teams` API

#### 2. Team Detail Page
- List of projects under this team
- Sort by deadline urgency
- Project card info:
  - Name, client, clickable group link, sheet link, assigned avatars (on hover show name/designation), current phase, time left, budgets, last update

#### 3. Project Detail Page
- Full info: about, all phases (with parallel flags), amount split, editable fields for deadline, assigned users, last message
- Show phase-wise member names

#### 4. Member Detail Popup
- On hover or click of avatar → show name, role, skills, email, profile pic

---

### ✅ Additional Features

| Feature                         | Purpose                            |
|----------------------------------|-------------------------------------|
| Sort by Deadline                | Show urgent projects at top        |
| Phase Assignments               | Track who's doing what             |
| Parallel Phase Support          | For multiple active areas          |
| Budget Split by Phase           | Phase-based funding                |
| Role-based Access               | Security & clarity                 |
| Update Logs / Last Message      | Real-time updates tracking         |

---

### 🛠 Tools You Can Use as a Beginner

| Feature             | Tool                                      |
|---------------------|-------------------------------------------|
| UI Design           | **Figma** or **Framer**                  |
| Frontend            | **Next.js** or **React + Tailwind**     |
| Backend             | **Node.js + Express + MongoDB**         |
| No-code Admin Panel | **Retool**, **Appsmith**, or **Forest Admin** |
| Hosting             | **Render**, **Railway**, **Vercel**     |
| Authentication      | **Auth0**, **Firebase Auth**, or custom JWT |

---

### 🛠 Project Setup Steps

1. **Backend**
   - `npm init -y`
   - Install: `express`, `mongoose`, `bcrypt`, `jsonwebtoken`, `dotenv`, `cors`
   - Create folders: `routes`, `controllers`, `models`, `middleware`
   - Connect MongoDB using Mongoose
   - Add Auth + CRUD routes as listed

2. **Frontend**
   - Use React (or even no-code builder for first version)
   - Pages:
     - `/login`, `/home`, `/teams/:id`, `/projects/:id`
   - Fetch and display data using `axios` or `fetch`

3. **Deploy**
   - Backend: Use Render or Railway
   - Frontend: Deploy to Vercel
   - MongoDB: Use MongoDB Atlas (cloud)

---

### 🌱 Naming Suggestion

Call your app something like:

- **TeamPulse**
- **WorkFlowX**
- **PulseTrack**
- **SquadBase**

---

Let me know if you want the full folder structure + boilerplate backend setup, or a simple frontend layout to get started fast!
