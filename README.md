# College Management System

A full-stack Node.js/Express web application for managing college complaints, feedback, and user authentication with PostgreSQL database.

![Node.js](https://img.shields.io/badge/Node.js-18-green)
![Express](https://img.shields.io/badge/Express-5.0-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-latest-blue)
![License](https://img.shields.io/badge/License-ISC-blue)

## 🎯 Features

- ✅ User authentication (signup, login, email verification)
- ✅ Password reset with email verification
- ✅ Complaint redressal system with file uploads
- ✅ Feedback management
- ✅ Admin dashboard for managing complaints & feedback
- ✅ Email notifications
- ✅ Session management
- ✅ Role-based access control (User/Admin)

## Tech Stack

- **Backend**: Node.js, Express.js
- **Frontend**: EJS, Bootstrap CSS
- **Database**: PostgreSQL
- **ORM**: Sequelize
- **Authentication**: bcrypt, express-session

## Local Development

### Prerequisites

- Node.js (v14 or higher)
- PostgreSQL (v12 or higher)
- npm or yarn

### Installation

1. Clone the repository
```bash
git clone <your-repo-url>
cd college-management
```

2. Install dependencies
```bash
npm install
```

3. Create a `.env` file (copy from `.env.example`)
```bash
cp .env.example .env
```

4. Update `.env` with your local configuration
```
SESSION_SECRET=your_secret_key
DB_HOST=localhost
DB_NAME=college_management
DB_USER=postgres
DB_PASSWORD=your_password
DB_PORT=5432
EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_app_password
BASE_URL=http://localhost:5000
PORT=5000
NODE_ENV=development
ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD=admin123
```

5. Start the development server
```bash
npm run dev
```

Visit `http://localhost:5000`

## Deployment on Render

### Steps to Deploy

1. **Push to GitHub**
   ```bash
   git add .
   git commit -m "Initial commit"
   git push origin main
   ```

2. **Connect to Render**
   - Go to [render.com](https://render.com)
   - Sign up/login with GitHub
   - Click "New +" → "Web Service"
   - Select your GitHub repository
   - Fill in the details:
     - **Name**: college-management
     - **Environment**: Node
     - **Build Command**: `npm install`
     - **Start Command**: `npm start`
     - **Plan**: Free (or select as needed)

3. **Set Environment Variables**
   In Render Dashboard → Environment Variables:
   ```
   SESSION_SECRET=your_random_secret_key
   DB_DIALECT=postgres
   DB_HOST=<from-render-postgres>
   DB_NAME=college_management
   DB_USER=<from-render-postgres>
   DB_PASSWORD=<from-render-postgres>
   DB_PORT=5432
   EMAIL_USER=your_email@gmail.com
   EMAIL_PASS=your_app_password
   BASE_URL=https://your-app.onrender.com
   NODE_ENV=production
   ADMIN_EMAIL=admin@example.com
   ADMIN_PASSWORD=admin123
   ```

4. **Add PostgreSQL Database**
   - In Render Dashboard, click "New +" → "PostgreSQL"
   - Select Free tier
   - Copy connection details to environment variables
   - Click "Connect"

5. **Deploy**
   - Click "Create Web Service"
   - Wait for deployment to complete
   - Access your app at `https://your-app.onrender.com`

## Important Notes

- **Never commit `.env`** - it's in `.gitignore`
- Use `.env.example` as a template
- Generate strong random values for `SESSION_SECRET` in production
- For email, use Gmail app-specific passwords (not your main password)
- On Render, database is automatically created and managed

## Project Structure

```
college-management/
├── app.js              # Main application file
├── package.json        # Dependencies
├── .env.example        # Environment template
├── render.yaml         # Render deployment config
├── config/             # Configuration files
│   ├── database.js     # Database connection
│   └── email.js        # Email setup
├── models/             # Sequelize models
├── controllers/        # Route handlers
├── routes/             # Route definitions
├── views/              # EJS templates
├── public/             # Static assets
└── uploads/            # User uploads
```

## Troubleshooting

### Database Connection Failed
- Verify PostgreSQL credentials in `.env`
- Check if database exists
- Ensure DATABASE_URL is set correctly in Render

### Email Not Sending
- Enable "Less secure app access" or use Gmail App Password
- Verify EMAIL_USER and EMAIL_PASS are correct
- Check spam folder

### Port Issues
- Ensure PORT is not hardcoded
- Render assigns dynamic PORT automatically

## License

ISC

## Support

For issues or questions, please open an issue in the repository.
