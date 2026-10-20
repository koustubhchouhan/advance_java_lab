<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <title>ShopSphere - Register</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        background: #f4f6f9;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
      }
      .register-card {
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        width: 320px;
      }
      .register-card h2 {
        margin-bottom: 20px;
        color: #1a237e;
        text-align: center;
      }
      .form-group {
        margin-bottom: 15px;
      }
      .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
      }
      .form-group input {
        width: 100%;
        padding: 8px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
      }
      .btn {
        width: 100%;
        padding: 10px;
        background: #0d6efd;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 16px;
      }
      .btn:hover {
        background: #0b5ed7;
      }
    </style>
  </head>
  <body>
    <div class="register-card">
      <h2>Register</h2>
      <form action="RegisterServlet" method="POST">
        <div class="form-group">
          <label>Full Name</label>
          <input
            type="text"
            name="fullname"
            placeholder="Enter your name"
            required
          />
        </div>
        <div class="form-group">
          <label>Email</label>
          <input
            type="email"
            name="email"
            placeholder="Enter your email"
            required
          />
        </div>
        <div class="form-group">
          <label>Password</label>
          <input
            type="password"
            name="password"
            placeholder="Create password"
            required
          />
        </div>
        <button type="submit" class="btn">Sign Up</button>
      </form>
    </div>
  </body>
</html>
