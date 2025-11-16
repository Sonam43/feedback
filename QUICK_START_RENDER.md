# Quick Start Guide - Deploy to Render in 10 Minutes

## 🎯 What You Need

1. ✅ Code on GitHub
2. ✅ Render account (free)
3. ✅ Gmail account (for emails)

## 📋 10-Minute Deployment

### Minute 1-2: Push to GitHub

```bash
cd college-management
git init
git add .
git commit -m "College Management System - Ready for Render"
git remote add origin https://github.com/YOUR_USERNAME/college-management.git
git branch -M main
git push -u origin main
```

### Minute 3-4: Create Web Service

1. Go to https://render.com → Sign in with GitHub
2. Click **"New +"** → **"Web Service"**
3. Select `college-management` repository
4. Settings:
   - Name: `college-management`
   - Build: `npm install`
   - Start: `npm start`
5. Click **"Create Web Service"**

### Minute 5-6: Create Database

1. Click **"New +"** → **"PostgreSQL"**
2. Name: `college-management-db`
3. Click **"Create Database"**
4. ⏰ Wait for database creation (1-2 min)
5. **Copy connection details** from the database page

### Minute 7-10: Set Environment Variables

In Web Service → **Environment** section, add:

```
SESSION_SECRET=abc123xyz789abc123xyz789abc123xyz789

NODE_ENV=production

DB_DIALECT=postgres
DB_HOST=your_host_from_database_page
DB_PORT=5432
DB_NAME=college_management
DB_USER=your_user_from_database_page
DB_PASSWORD=your_password_from_database_page

EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_gmail_app_password

BASE_URL=https://college-management-xxx.onrender.com

ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD=admin123
```

**Save** → Render auto-redeploys!

## ✅ Done!

Your app is now live at: `https://college-management-xxx.onrender.com`

## 🧪 Quick Test

- [ ] Visit homepage
- [ ] Create account
- [ ] Verify email works
- [ ] Login
- [ ] Submit complaint
- [ ] Check admin dashboard

## 📞 Got Issues?

See full guide: [RENDER_DEPLOYMENT.md](./RENDER_DEPLOYMENT.md)

---

**Happy Deploying!** 🚀
