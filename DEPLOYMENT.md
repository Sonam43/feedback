# Deployment Guide for Render

This guide will walk you through deploying the College Management System to Render.

## Prerequisites

- GitHub account with the code pushed
- Render account (free tier available)
- Gmail account for email notifications

## Step-by-Step Deployment

### Step 1: Prepare Your Code for GitHub

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit - College Management System"

# Add your GitHub repository as remote
git remote add origin https://github.com/YOUR_USERNAME/college-management.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### Step 2: Create Render Account & Connect GitHub

1. Visit [render.com](https://render.com)
2. Sign up or log in
3. Click **"GitHub"** to authorize Render to access your repositories
4. Grant necessary permissions

### Step 3: Create a Web Service on Render

1. Click **"New +"** button → Select **"Web Service"**
2. Select your **college-management** repository
3. Fill in the configuration:
   - **Name**: `college-management`
   - **Environment**: `Node`
   - **Region**: Choose closest to your location
   - **Branch**: `main`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Plan**: `Free` (or upgrade as needed)

### Step 4: Add PostgreSQL Database

1. Click **"New +"** → Select **"PostgreSQL"**
2. Configure:
   - **Name**: `college-management-db`
   - **Plan**: `Free`
   - **Region**: Same as your web service
3. Click **"Create Database"**
4. Wait for database to be created
5. Copy the connection string (you'll need it)

### Step 5: Configure Environment Variables

In your Render Web Service Dashboard:

1. Go to **Environment** section
2. Click **"Add Environment Variable"** and add:

```
SESSION_SECRET=your_very_secure_random_string_here_min_32_chars

NODE_ENV=production

PORT=5000

DB_DIALECT=postgres
DB_HOST=your-db-host.postgres.render.com
DB_PORT=5432
DB_NAME=your_db_name
DB_USER=your_db_user
DB_PASSWORD=your_db_password

EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_gmail_app_password

BASE_URL=https://your-app-name.onrender.com

ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD=your_secure_admin_password
```

**How to get Database Credentials:**
- Go to your PostgreSQL database page on Render
- Look for "Connections" section
- Copy: hostname, port, database, user, password from the connection string

### Step 6: Deploy

1. After setting environment variables, scroll up and click **"Deploy"**
2. Render will:
   - Pull your code from GitHub
   - Install dependencies (`npm install`)
   - Run your application (`npm start`)
3. Check deployment logs - you should see: `🚀 Server running on...`
4. Visit your app at: `https://your-app-name.onrender.com`

### Step 7: Verify Everything Works

1. **Check Logs**: In Render dashboard, view live logs
2. **Test Endpoints**:
   - Visit homepage: `https://your-app.onrender.com`
   - Try login/signup
   - Test email verification
   - Test complaint submission
3. **Admin Dashboard**: Login with credentials from `.env`

## Gmail App Password Setup

To enable email notifications:

1. Go to [myaccount.google.com](https://myaccount.google.com)
2. Enable 2-Factor Authentication (if not done)
3. Go to **App passwords** section
4. Select: App = **Mail**, Device = **Windows Computer** (or your device)
5. Generate password (16 characters)
6. Use this password as `EMAIL_PASS` in environment variables

## Troubleshooting

### Application Won't Start

**Error**: `Cannot find module 'dotenv'`
- Solution: Ensure `npm install` is in build command

**Error**: `ECONNREFUSED` on database
- Solution: Check DB credentials match exactly from Render PostgreSQL page

### Database Connection Issues

**Error**: `role "user" does not exist`
- Solution: Use correct DB_USER from Render connection string

**Error**: `database "college_management" does not exist`
- Solution: Database is auto-created, but check DB_NAME matches

### Email Not Sending

**Check**:
1. EMAIL_USER is valid Gmail
2. EMAIL_PASS is App Password (not regular password)
3. Check spam folder
4. View app logs for email errors

### Auto-Deploy from GitHub

Render automatically redeploys when you push to GitHub:

```bash
# Make changes locally
git add .
git commit -m "Your changes"
git push origin main

# Render automatically detects and deploys!
```

## Performance Tips

- **Free Tier Limits**: App spins down after 15 minutes of inactivity
- **Cold Start**: First request after 15+ minutes may be slow
- **Database**: Free PostgreSQL limited to 90 days, then must pay
- **Upgrade**: Use Starter plan ($7/month) to keep services always running

## Monitoring & Updates

### View Live Logs
- Render Dashboard → Your Service → Logs

### Redeploy Manually
- Render Dashboard → Your Service → Manual Deploy → Deploy

### Update Code
1. Push to GitHub
2. Render auto-deploys
3. Check logs to confirm deployment

## Security Best Practices

✅ **DO**:
- Use strong SESSION_SECRET (min 32 characters)
- Use unique ADMIN_PASSWORD
- Use Gmail App Passwords (not main password)
- Keep `.env` out of Git (use `.gitignore`)
- Update admin password after first login

❌ **DON'T**:
- Commit `.env` files to GitHub
- Use same password for admin and database
- Share environment variable values
- Use weak or default passwords
- Commit secrets in code

## Next Steps

1. ✅ Push code to GitHub
2. ✅ Create Render account
3. ✅ Deploy web service
4. ✅ Deploy database
5. ✅ Configure environment variables
6. ✅ Test application
7. ✅ Share your deployed URL!

## Support

- Render Docs: https://render.com/docs
- Sequelize Docs: https://sequelize.org
- Express Docs: https://expressjs.com
- PostgreSQL Docs: https://www.postgresql.org/docs

---

**Happy Deploying! 🚀**
