# Book Review App

## Overview
The Book Review App is a full-stack application that enables users to review books, rate them, and manage their reviews. The application is divided into two main parts: the *frontend, built using **Flutter, and the **backend, built using **Node.js*.

---

## Project Structure

### Frontend
The frontend, developed with Flutter, manages the user interface (UI) and provides functionalities such as:
- Displaying book reviews.
- Adding new reviews.
- Editing and deleting existing reviews.
- User authentication.


/frontend
    /lib
        /screens       # Contains different screens for the app like HomeScreen, LoginScreen, etc.
        /widgets       # Reusable UI components (buttons, forms, etc.)
        /models        # Data models (Review model, User model, etc.)
    pubspec.yaml       # Flutter project configuration


### Backend
The backend, built using Node.js, handles business logic, database interactions, and API endpoints for the application.


/backend
    /models            # Contains Mongoose models for Reviews, Users, etc.
    /routes            # API route definitions (reviews.js, auth.js, etc.)
    /controllers       # Business logic for handling requests
    /middleware        # Custom middlewares (authentication, validation, etc.)
    /config            # Configuration files (MongoDB, environment variables, etc.)
    server.js          # Entry point for the server
    package.json       # Node.js project dependencies


---

## Frontend Setup (Flutter)

### Prerequisites
- *Flutter*: Ensure Flutter is installed on your machine. Follow the installation guide [here](https://flutter.dev/docs/get-started/install).
- *Dart*: Installed as part of the Flutter installation.

### Setup Instructions
1. Clone the repository to your local machine:
   bash
   git clone <repository-url>
   cd frontend
   
2. Install dependencies:
   bash
   flutter pub get
   
3. Run the application:
   bash
   flutter run
   

### Features
- User authentication and login.
- View a list of books and their reviews.
- Add, edit, and delete book reviews.
- Search functionality for books.

---

## Backend Setup (Node.js)

### Prerequisites
- *Node.js*: Download and install Node.js from [here](https://nodejs.org/).
- *MongoDB*: Set up MongoDB locally or use a cloud service like MongoDB Atlas.

### Setup Instructions
1. Navigate to the backend directory:
   bash
   cd backend
   
2. Install dependencies:
   bash
   npm install
   
3. Create a .env file for environment variables:
   env
   PORT=5000
   MONGO_URI=<your-mongodb-connection-string>
   
4. Start the server:
   bash
   npm start
   

### Features
- User authentication (register, login, logout).
- CRUD operations for book reviews.
- Validation and error handling for API requests.

---

## Additional Notes
- Ensure both the frontend and backend are running simultaneously to test the full application.
- Use a tool like Postman or Insomnia to test backend API routes independently.
- Follow best practices for securing environment variables and sensitive data.

---

## Future Enhancements
- Implement a recommendation system for books.
- Add social sharing options for reviews.
- Introduce notifications for user activity.