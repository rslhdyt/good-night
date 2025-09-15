# Good Night
Good night app is a sleep tracking app that allows users to track their sleep records.

## Functional Requirements
1. Users can clock in and clock out.
2. Users can see their sleep records.
3. Users can see their sleep records of all following users.
 3.1. Sorted based on the duration of all friends sleep length.
 3.2. Filter the records of the previous week.
4. Users can follow and unfollow other users.

## Non-Functional Requirements
1. The system must be efficient and scalable.

## Out of Scope
1. User registration.

## Database Design
### Users
- id: integer
- name: string

### Sleeps
- id: integer
- user_id: integer
- sleep_start: datetime
- sleep_end: datetime
- duration: integer
- created_at: datetime
- updated_at: datetime

### Follows
- id: integer
- follower_id: integer
- followed_id: integer
- created_at: datetime
- updated_at: datetime

## API Design

## Authentication
To determine the user, we will use the following header:
- X-User-Id: integer

### Clock In as a currentuser
- POST /api/v1/me/sleeps

### Clock Out as a current user
- PATCH /api/v1/me/sleeps/:id

### Get Sleep Records as a current user
- GET /api/v1/me/sleeps

### Follow user as a current user
- POST /api/v1/me/follows

### Unfollow user as a current user
- DELETE /api/v1/me/follows/:user_id

### Get sleep records of all current user's followers
- GET /api/v1/me/following/sleeps

### Get sleep records of all followers of users
- GET /api/v1/followers/:user_id/sleeps

