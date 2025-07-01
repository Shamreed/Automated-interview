# Automated Interview Platform

An advanced web-based application designed to streamline and automate the hiring process with secure authentication and role-based authorization.

## Features

### Authentication & Authorization
- ✅ Secure user registration and login
- ✅ JWT token-based authentication
- ✅ BCrypt password hashing
- ✅ Role-based access control (Admin, HR, Candidate)
- ✅ Protected routes based on user roles

### Technologies Used
- **Backend**: Spring Boot 3.2.0
- **Security**: Spring Security with JWT
- **Database**: H2 (in-memory for development)
- **ORM**: Spring Data JPA
- **Password Encoding**: BCrypt
- **JWT Library**: JJWT 0.12.3

## Project Structure

```
src/
├── main/
│   ├── java/com/interview/
│   │   ├── config/
│   │   │   └── WebSecurityConfig.java
│   │   ├── controller/
│   │   │   ├── AuthController.java
│   │   │   └── TestController.java
│   │   ├── dto/
│   │   │   ├── JwtResponse.java
│   │   │   ├── LoginRequest.java
│   │   │   ├── MessageResponse.java
│   │   │   └── SignupRequest.java
│   │   ├── entity/
│   │   │   ├── Role.java
│   │   │   └── User.java
│   │   ├── repository/
│   │   │   └── UserRepository.java
│   │   ├── security/
│   │   │   ├── AuthEntryPointJwt.java
│   │   │   ├── AuthTokenFilter.java
│   │   │   ├── CustomUserDetailsService.java
│   │   │   ├── JwtUtils.java
│   │   │   └── UserPrincipal.java
│   │   └── AutomatedInterviewPlatformApplication.java
│   └── resources/
│       └── application.properties
```

## Getting Started

### Prerequisites
- Java 17 or higher
- Maven 3.6+

### Running the Application

1. Clone the repository
2. Navigate to the project directory
3. Run the application:
   ```bash
   mvn spring-boot:run
   ```

The application will start on `http://localhost:8080`

## API Endpoints

### Authentication Endpoints

#### Register User
```http
POST /api/auth/register
Content-Type: application/json

{
  "username": "john_doe",
  "email": "john@example.com",
  "password": "password123",
  "role": "CANDIDATE"
}
```

**Response:**
```json
{
  "message": "User registered successfully!"
}
```

#### Login User
```http
POST /api/auth/login
Content-Type: application/json

{
  "username": "john_doe",
  "password": "password123"
}
```

**Response:**
```json
{
  "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "tokenType": "Bearer",
  "id": 1,
  "username": "john_doe",
  "email": "john@example.com",
  "roles": ["ROLE_CANDIDATE"]
}
```

### Protected Endpoints

#### Public Access
```http
GET /api/test/all
```

#### Candidate Access (Requires CANDIDATE, HR, or ADMIN role)
```http
GET /api/test/candidate
Authorization: Bearer <jwt_token>
```

#### HR Access (Requires HR or ADMIN role)
```http
GET /api/test/hr
Authorization: Bearer <jwt_token>
```

#### Admin Access (Requires ADMIN role)
```http
GET /api/test/admin
Authorization: Bearer <jwt_token>
```

## User Roles

1. **ADMIN**: Full access to all resources
2. **HR**: Access to HR and candidate resources
3. **CANDIDATE**: Access to candidate-specific resources

## Security Features

### Password Security
- Passwords are hashed using BCrypt with salt
- Minimum password length: 6 characters
- Maximum password length: 40 characters

### JWT Token Security
- Tokens expire after 24 hours (86400000 ms)
- Tokens are signed using HMAC SHA-256
- Base64 encoded secret key for enhanced security

### Route Protection
- Public routes: `/api/auth/**`, `/h2-console/**`
- Role-based route protection using Spring Security
- JWT token validation on each request
- Automatic token parsing from Authorization header

## Database Access

H2 Console is available at: `http://localhost:8080/h2-console`
- JDBC URL: `jdbc:h2:mem:testdb`
- Username: `sa`
- Password: `password`

## Testing the API

### Using cURL

1. **Register a new user:**
```bash
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin_user",
    "email": "admin@example.com",
    "password": "password123",
    "role": "ADMIN"
  }'
```

2. **Login:**
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin_user",
    "password": "password123"
  }'
```

3. **Access protected endpoint:**
```bash
curl -X GET http://localhost:8080/api/test/admin \
  -H "Authorization: Bearer <your_jwt_token>"
```

## Configuration

Key configuration properties in `application.properties`:

```properties
# JWT Configuration
jwt.secret=<base64-encoded-secret>
jwt.expiration=86400000

# Database Configuration
spring.datasource.url=jdbc:h2:mem:testdb
spring.h2.console.enabled=true

# Server Configuration
server.port=8080
```

## Next Steps

This foundation provides:
- ✅ Secure authentication with JWT
- ✅ Role-based authorization
- ✅ Protected API endpoints
- ✅ Password hashing with BCrypt
- ✅ Database integration

Future enhancements for the interview platform:
- Interview template management
- Candidate invitation system
- Real-time interview sessions
- AI-powered response evaluation
- Reporting and analytics
- Email notifications
- File upload for resumes
- Calendar integration

## Troubleshooting

### Common Issues

1. **JWT Token Invalid**: Ensure the token is properly formatted and included in the Authorization header as "Bearer <token>"

2. **Access Denied**: Verify that the user has the required role for the endpoint

3. **Database Connection**: Check H2 console if data is not persisting correctly

4. **CORS Issues**: CORS is configured to allow all origins for development. Adjust in production.

## Security Notes

- This configuration is for development purposes
- In production, use a strong, unique JWT secret
- Consider using a persistent database instead of H2
- Implement proper CORS configuration
- Add rate limiting and additional security headers
- Use HTTPS in production
