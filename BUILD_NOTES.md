# Build & Verification Notes

The FinTech Lending Platform has been verified with a multi-module Maven build lifecycle across all 6 microservices.

## Build Verification Status

- **Status**: PASSED (`./mvnw clean verify`)
- **Modules Verified**:
  - `fintech-lending-platform` (root POM, Java 17, UTF-8 source & output encoding)
  - `auth-service` (JWT auth, RBAC, PasswordEncoder, JwtAuthenticationFilter, `/me` endpoint, Flyway migrations)
  - `customer-service` (profile creation, KYC management, safe JWT role parsing, `/error` permitted)
  - `loan-service` (public catalog `/products`, applications, EMI calculation, Kafka events, `/error` permitted)
  - `api-gateway` (Spring Cloud Gateway routing, Global CORS enabled)
  - `payment-service` (idempotency, Kafka events, payment history, get payment by ID, `/error` permitted)
  - `notification-service` (Kafka event consumer with null-safety, in-app notifications REST API with query params & getById)

## Key Fixes Applied

1. **Authentication & Bean Injection**:
   - Switched from concrete `BCryptPasswordEncoder` to standard Spring `PasswordEncoder` interface in `AuthController` and `SecurityConfig` to eliminate IDE autowiring warnings.
   - Added `JwtAuthenticationFilter` and `/api/v1/auth/me` endpoint in `auth-service` with `JwtService.parseClaims()` and `validateToken()`.
2. **Spring Security 6 `/error` Dispatch**:
   - Added `/error` to `permitAll()` across all secured services (`auth-service`, `customer-service`, `loan-service`, `payment-service`) so that `@RestControllerAdvice` error payloads are never masked by Spring Security with empty 401/403 responses.
   - Made `GET /api/v1/loans/products` public (`permitAll()`) so visitors/clients can browse loan catalog without needing an authentication token first.
3. **Robust JWT Role Handling**:
   - Normalized `ROLE_` prefix handling in `JwtAuthenticationFilter` across all services to prevent duplicate prefixes (e.g. `ROLE_ROLE_ADMIN`) or null pointer exceptions when roles are missing or already prefixed.
4. **API Gateway Global CORS**:
   - Configured `globalcors` in `api-gateway/src/main/resources/application.yml` to allow browser clients (such as React/Vue/Angular frontend apps) to call endpoints across any origin.
5. **Notification & Event Consumer Safety**:
   - Added null guards in `EventConsumer` for `loanId`, `paymentId`, and `customerId` to prevent Kafka listener `NullPointerException`s.
   - Added query param support `GET /api/v1/notifications?recipient=...` alongside `/recipient/{recipient}` and `GET /api/v1/notifications/{id}`.
6. **IDE & Build Consistency**:
   - Added `project.build.sourceEncoding` and `project.reporting.outputEncoding` set to `UTF-8` in root `pom.xml`.
   - Updated `.idea/compiler.xml` with `bytecodeTargetLevel 17` and `.idea/misc.xml` with `languageLevel JDK_17`.

## Build Commands

```bash
# Run unit tests across all services
./mvnw clean test

# Build and package all executable fat JARs
./mvnw clean package

# Run complete verification lifecycle
./mvnw clean verify

# Start full multi-service stack with MySQL, Redis, Kafka, and API Gateway
docker compose up --build
```

## Pre-seeded Test Credentials

- **Admin Account**: `admin@lending.com` / `AdminPassword123` (Role: `ADMIN`)
- **Loan Officer Account**: `officer@lending.com` / `OfficerPassword123` (Role: `LOAN_OFFICER`)
- **Customer Account**: Register any email via `POST /api/v1/auth/register` (Role: `CUSTOMER`)
