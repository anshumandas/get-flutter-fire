Route Guarding-Added AuthGuard class to control access to routes based on authentication status and user role.
Dynamic Role-Based Routing: Introduced a secureRoute method to enforce role-based access control dynamically. For example, only admins can access the admin dashboard.
Security Enhancements-Added a basic AuthService class to validate tokens, which can be expanded to include JWT validation, token expiration checks, and more.
Logging and Monitoring: Added a method in AuthService to log route access, which can be useful for monitoring unauthorized access attempts.
These changes not only improve security but also make the code more flexible and ready for production use, where different user roles and permissions are common.
Removed Unnecessary Comments: Commented-out code sections were removed to keep the file clean.


Name - Shreyash Bhatt
Prn -1032210735 
MIT WPU
