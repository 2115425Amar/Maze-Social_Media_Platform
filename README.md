# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions



Here are the URLs generated by your Rails routes file:

---

### **Authentication (Devise)**
1. **User Registration**:
   - Sign up: `/users/sign_up` (GET)
   - Create user: `/users` (POST)

2. **User Sessions**:
   - Login: `/users/sign_in` (GET)
   - Create session: `/users/sign_in` (POST)
   - Logout: `/users/sign_out` (DELETE)

---

### **Posts**
1. **Posts**:
   - List all posts: `/posts` (GET)
   - Create a new post: `/posts` (POST)
   - Show a specific post: `/posts/:id` (GET)
   - Edit a post: `/posts/:id/edit` (GET)
   - Update a post: `/posts/:id` (PATCH/PUT)
   - Delete a post: `/posts/:id` (DELETE)

2. **Comments on Posts**:
   - Create a comment: `/posts/:post_id/comments` (POST)
   - Delete a comment: `/posts/:post_id/comments/:id` (DELETE)

3. **Likes on Posts**:
   - Like a post: `/posts/:post_id/likes` (POST)
   - Unlike a post: `/posts/:post_id/likes/:id` (DELETE)

---

### **Comments**
1. **Likes on Comments**:
   - Like a comment: `/comments/:comment_id/likes` (POST)
   - Unlike a comment: `/comments/:comment_id/likes/:id` (DELETE)

---

### **Profile**
1. **User Profile**:
   - View profile: `/profile` (GET)

---

### **Reports**
1. **Reports**:
   - List reports: `/reports` (GET)
   - Download report: `/reports/download_report` (GET)

---

### **Manage Users**
1. **Manage Users**:
   - List users: `/manage_users` (GET)
   - Create a new user: `/manage_users` (POST)
   - Toggle user status: `/manage_users/:id/toggle_status` (PATCH)

2. **Bulk Upload**:
   - Show upload form: `/manage_users/upload` (GET)
   - Upload users: `/manage_users/upload_users` (POST)

---

### **Home**
1. **Home**:
   - Root: `/` (GET)
   - Landing page: `/landing` (GET)

---

### **Sidekiq**
1. **Sidekiq Web UI**:
   - Access Sidekiq dashboard: `/sidekiq` (GET)

---

### **Summary of URLs**
| **URL**                              | **HTTP Method** | **Controller#Action**           |
|--------------------------------------|-----------------|---------------------------------|
| `/users/sign_up`                     | GET             | `users/registrations#new`       |
| `/users`                             | POST            | `users/registrations#create`    |
| `/users/sign_in`                     | GET             | `users/sessions#new`            |
| `/users/sign_in`                     | POST            | `users/sessions#create`         |
| `/users/sign_out`                    | DELETE          | `users/sessions#destroy`        |
| `/posts`                             | GET             | `posts#index`                   |
| `/posts`                             | POST            | `posts#create`                  |
| `/posts/:id`                         | GET             | `posts#show`                    |
| `/posts/:id/edit`                    | GET             | `posts#edit`                    |
| `/posts/:id`                         | PATCH/PUT       | `posts#update`                  |
| `/posts/:id`                         | DELETE          | `posts#destroy`                 |
| `/posts/:post_id/comments`           | POST            | `comments#create`               |
| `/posts/:post_id/comments/:id`       | DELETE          | `comments#destroy`              |
| `/posts/:post_id/likes`              | POST            | `likes#create`                  |
| `/posts/:post_id/likes/:id`          | DELETE          | `likes#destroy`                 |
| `/comments/:comment_id/likes`        | POST            | `likes#create`                  |
| `/comments/:comment_id/likes/:id`    | DELETE          | `likes#destroy`                 |
| `/profile`                           | GET             | `users#profile`                 |
| `/reports`                           | GET             | `reports#index`                 |
| `/reports/download_report`           | GET             | `reports#download_report`       |
| `/manage_users`                      | GET             | `manage_users#index`            |
| `/manage_users`                      | POST            | `manage_users#create`           |
| `/manage_users/:id/toggle_status`    | PATCH           | `manage_users#toggle_status`    |
| `/manage_users/upload`               | GET             | `manage_users#upload`           |
| `/manage_users/upload_users`         | POST            | `manage_users#upload_users`     |
| `/`                                 | GET             | `home#index`                    |
| `/landing`                           | GET             | `home#landing`                  |
| `/sidekiq`                           | GET             | `Sidekiq::Web`                  |

---

This table provides a clear overview of all the URLs, their corresponding HTTP methods, and the controller actions they map to. Let me know if you need further clarification!