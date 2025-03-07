# Amne Project

**Amne** is a full-stack project featuring a Flutter frontend and an Express.js backend. This application demonstrates the seamless integration between Flutter and Express.js, providing user authentication, real-time data synchronization, and more.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Frontend Setup](#frontend-setup)
- [Backend Setup](#backend-setup)
- [Running the Project](#running-the-project)
- [API Endpoints](#api-endpoints)
- [Contributing](#contributing)
- [License](#license)

## Features
- User authentication and registration
- JWT-based authentication
- Real-time data synchronization
- RESTful API communication
- CRUD operations for data entities
- Secure and scalable architecture
- Beautiful and responsive UI

## Installation

### Prerequisites
- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- Node.js and npm: [Installation Guide](https://nodejs.org/)
- MongoDB or any other database of your choice

### Clone the repository
```bash
git clone https://github.com/username/amne.git
cd amne
de frontend

flutter pub get


cd ..
cd backend


npm install

PORT=9000
KEYID='PKZZOUYRJLEWCT8F2VJJ'
SECRETKEY='uBf1zt4fKpQZnAUp3NCidSFbhdlpfngg88fTw2XG'
MONGODB=AKYWkzpcXXLH5ODl
MONGODB_URI=mongodb+srv://contactsesea:AKYWkzpcXXLH5ODl@amne.jl1bl.mongodb.net/?retryWrites=true&w=majority&appName=Amne
CRYPT_KEY='108afFbB90cC34e6'
CRYPT_IV='abcdefghijklmnop'
API_KEY=b8b2a736f5671c6c55e7745b740a0cdc4f280c47d9e353188f126f8625e2303c
INTERMID="0xBB583e59c9D50D1C58be39a98F0397872D9D28fD"

cd backend
npm run dev

cd frontend
flutter run

ser Authentication
POST /api/auth/register

Description: Register a new user

Request Body: { "username": "example", "email": "user@example.com", "password": "password123" }

Response: { "message": "User registered successfully" }

POST /api/auth/login

Description: Log in a user

Request Body: { "email": "user@example.com", "password": "password123" }

Response: { "token": "jwt_token" }

POST /api/auth/logout

Description: Log out a user

Headers: { "Authorization": "Bearer jwt_token" }

Response: { "message": "User logged out successfully" }

CRUD Operations
GET /api/items

Description: Get all items

Response: [{ "id": "1", "name": "Item 1" }, { "id": "2", "name": "Item 2" }]

POST /api/items

Description: Create a new item

Request Body: { "name": "New Item" }

Response: { "id": "3", "name": "New Item" }

PUT /api/items/:id

Description: Update an item

Request Body: { "name": "Updated Item" }

Response: { "id": "1", "name": "Updated Item" }

DELETE /api/items/:id

Description: Delete an item

Response: { "message": "Item deleted successfully" }


