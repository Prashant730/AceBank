# AceBank

AceBank is a secure full-stack banking web application built using Java Servlets, Spring Boot, JSP, JDBC, and MySQL. The system allows users to register, log in securely, transfer funds, view transaction history, and manage their accounts with proper authentication and session management. It also includes an Admin dashboard for account management.

## System Workflow Map

Here is the step-by-step navigation flow of the application:

- **Visitor Navigates to Application**
  - Lands on **Landing Page** (`/index.jsp`)
  - From the Landing Page, the user can choose one of three actions:

    **1. Sign Up Route**
    - Goes to **Register** (`/signup`)
    - After successful registration, proceeds to **User Login** (`/Login`)

    **2. User Login Route**
    - Goes to **User Login** (`/Login`)
    - **If Success:** Redirected to **User Dashboard** (`/home`)
      - From Dashboard, user can:
        - **Deposit Funds** (`/deposit`)
        - **Apply for Loan** (`/loan`)
        - **Transfer Funds** (Internal Transfer)
        - **Logout** (`/Logout`)
    - **If Failure:** Redirected to **Error Page** (`/error-handler`)

    **3. Admin Login Route**
    - Goes to **Admin Login** (`/admin/login`)
    - **If Success:** Redirected to **Admin Dashboard** (`/admin/dashboard`)
      - From Admin Dashboard, admin can:
        - **Toggle Account Status** (`/admin/toggle-status`)
        - **Admin Logout** (`/admin/logout`)

### Workflow Details

1. **Public Access:** Users visit the landing page (`/`) and can choose to log in, sign up, or recover a forgotten password.
2. **Authentication:**
   - The `/Login` servlet handles user authentication using JDBC.
   - If successful, the user is redirected to the `/home` dashboard.
   - If a user forgets their password, they use the `/ForgotPasswordServlet`.
3. **User Dashboard:** From the dashboard, authenticated users can:
   - Deposit money (`/deposit`).
   - Apply for a loan (`/loan`).
   - Terminate their session securely (`/Logout`).
4. **Admin Module:**
   - Administrators have a dedicated Spring MVC Controller (`/admin/login`).
   - Once logged in, they can access the Admin Dashboard (`/admin/dashboard`) to view overall bank statistics and user accounts.
   - Admins can activate or suspend user accounts via (`/admin/toggle-status`).

## Application Endpoints

### Public Endpoints

- `GET /` - Index/Landing Page (forwards to `index.jsp`)
- `POST /signup` - User Registration
- `POST /Login` - User Authentication
- `POST /ForgotPasswordServlet` - Password Recovery
- `GET /error-handler` - Global error handling page

### User Endpoints (Requires Session)

- `GET/POST /home` - User Dashboard / Main Hub
- `POST /deposit` - Process a deposit transaction
- `POST /loan` - Loan application request
- `GET /Logout` - Ends the user session

### Admin Endpoints (Requires Admin Session)

- `GET /admin/login` - Admin Login Page
- `POST /admin/login` - Admin Authentication
- `GET /admin/dashboard` - Admin Dashboard displaying system statistics
- `POST /admin/toggle-status` - Activate or Suspend a user's account
- `GET /admin/logout` - Ends the admin session

## Testing & CRUD Operations (Postman / Browser Guide)

Because AceBank uses session-based authentication (Servlets/JSP), testing these endpoints via API testing tools like **Postman** or **Insomnia** is highly recommended. These tools will automatically save and manage your session cookies when you log in.

### 1. Create (Register a User)

- **URL:** `http://localhost:8081/signup`
- **Method:** `POST`
- **Body Type:** `x-www-form-urlencoded`
- **Parameters:**
  - `fname`: John
  - `lname`: Doe
  - `email`: john.doe@example.com
  - `dob`: 1990-01-01
  - `gender`: Male
  - `password`: password123
  - `phone`: 1234567890
  - `address`: 123 Main St

### 2. Read (Login & Access Profile/Dashboard)

**Step A: Login**

- **URL:** `http://localhost:8081/Login`
- **Method:** `POST`
- **Body Type:** `x-www-form-urlencoded`
- **Parameters:**
  - `username`: john.doe@example.com
  - `password`: password123

_(Note: If the login is successful, Postman automatically saves the session cookie for your next requests)_

**Step B: View Dashboard**

- **URL:** `http://localhost:8081/home`
- **Method:** `GET`

_(Requires the session cookie obtained from Step A)_

### 3. Update (Deposit Funds)

- **URL:** `http://localhost:8081/deposit`
- **Method:** `POST`
- **Body Type:** `x-www-form-urlencoded`
- **Parameters:**
  - `amount`: 500

_(Requires an active user session from Step 2)_

### 4. Admin Update/Delete (Toggle Account Status)

**Step A: Admin Login**

- **URL:** `http://localhost:8081/admin/login`
- **Method:** `POST`
- **Body Type:** `x-www-form-urlencoded`
- **Parameters:**
  - `username`: admin
  - `password`: admin123

**Step B: Suspend/Activate User**

- **URL:** `http://localhost:8081/admin/toggle-status`
- **Method:** `POST`
- **Body Type:** `x-www-form-urlencoded`
- **Parameters:**
  - `userId`: 1
  - `action`: suspend

## Getting Started

1. Set up a MySQL server on `localhost:3306`.
2. Create an empty database: `CREATE DATABASE acebank;`
3. Check `src/main/resources/application-dev.properties` to ensure your database credentials match.
4. Run the project: `mvn spring-boot:run`
5. Visit `http://localhost:8081` in your browser. The application will automatically create the required database tables on the first connection!

## Project Structure and File Descriptions

### Core Application

- `src/main/java/com/acebank/lite/AceBankApplication.java` - The main Spring Boot entry point class that boots up the application.

### Controllers (`src/main/java/com/acebank/lite/controllers/`)

- `AdminController.java` - Spring MVC controller handling admin functionalities like login, viewing the dashboard, and toggling user account status.
- `Deposit.java` - Servlet processing user deposit transactions.
- `ErrorHandler.java` - Servlet responsible for catching exceptions and forwarding users to an appropriate error page.
- `ForgotPasswordServlet.java` - Servlet managing the password recovery flow, including OTP generation and validation.
- `Home.java` - Servlet responsible for loading user and account data to render the main user dashboard.
- `IndexController.java` - Controller for mapping the root URL (`/`) to the landing page.
- `LoanServlet.java` - Servlet processing loan applications submitted by users.
- `Login.java` - Servlet handling user authentication and session creation.
- `Logout.java` - Servlet responsible for securely invalidating user sessions.
- `SignUp.java` - Servlet managing new user account registration.

### Data Access Object (DAO) (`src/main/java/com/acebank/lite/dao/`)

- `BankUserDao.java` - Interface defining the contract for database operations related to users and accounts.
- `BankUserDaoImpl.java` - JDBC implementation of `BankUserDao` to execute SQL operations on the MySQL database.

### Filters (`src/main/java/com/acebank/lite/filters/`)

- `AuthFilter.java` - Web filter that intercepts requests to protected routes, ensuring that only authenticated users can access them.

### Models (`src/main/java/com/acebank/lite/models/`)

- `Account.java` - Entity class representing bank account details (balance, account number, status).
- `AccountRecoveryDTO.java` - Data Transfer Object used to hold state during the password recovery process.
- `AdminStats.java` - Model encapsulating aggregate statistics displayed on the admin dashboard (total users, total balance, etc.).
- `LoginResult.java` - Wrapper class encapsulating the result of a login attempt, including user info or error messages.
- `ServiceResponse.java` - Generic response wrapper for standardizing output from the service layer.
- `Transaction.java` - Entity representing financial transactions (deposits, transfers, loans).
- `User.java` - Entity representing user personal details and authentication credentials.
- `UserAccountInfo.java` - Composite model combining user and account data for dashboard presentation.

### Services (`src/main/java/com/acebank/lite/service/`)

- `BankService.java` - Interface defining the core business logic of the application.
- `BankServiceImpl.java` - Implementation of the business logic, orchestrating calls to the DAO layer and enforcing banking rules.

### Utilities (`src/main/java/com/acebank/lite/util/`)

- `ConfigKeys.java` - Stores constants for configuration property keys to avoid magic strings.
- `ConfigLoader.java` - Utility to load and parse configuration files.
- `ConnectionManager.java` & `DBConnection.java` - Utilities for establishing and managing JDBC connections to the database.
- `MailUtil.java` - Utility class for sending emails, heavily used in the OTP password recovery flow.
- `PasswordUtil.java` - Utility handling secure hashing of passwords and verification using algorithms like BCrypt.
- `QueryLoader.java` - Utility responsible for loading SQL queries dynamically from external YAML files.

### Resources (`src/main/resources/`)

- `application.properties` & `application-dev.properties` - Spring Boot and custom application configuration properties.
- `application-dev.properties.template` - A template file to help developers set up their local configuration.
- `sql/queries.yaml` - Centralized file containing all SQL queries used by the application, separating SQL from Java code.
- `sql/schema_initializer.sql` - SQL script executed on startup to create necessary database tables if they do not exist.

### Web Views (`src/main/webapp/`)

- `index.jsp` - Public landing page.
- `login.jsp` - User login interface.
- `sign-up.jsp` - New user registration interface.
- `admin-login.jsp` - Administrator login interface.
- `verify-otp.jsp`, `reset-password.jsp`, `newPassword.jsp` - Views related to the password recovery process.
- `error.jsp` - Standard error display page.
- `WEB-INF/web.xml` - Deployment descriptor defining servlets, mappings, and filters for the web application.
- `WEB-INF/views/AdminDashboard.jsp` - Secured view for the administrator dashboard.
- `WEB-INF/views/Home.jsp` - Secured view for the user's main banking dashboard.
