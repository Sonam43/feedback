# College Management System - Render Deployment Checklist

## Pre-Deployment Checklist

- [ ] `.env` file is in `.gitignore`
- [ ] `.env.example` exists with all required variables
- [ ] `package.json` has correct build and start scripts
- [ ] `Procfile` is created
- [ ] `render.yaml` is created
- [ ] All dependencies are in `package.json`
- [ ] Code is committed to GitHub
- [ ] GitHub repository is public or accessible

## Render Deployment Steps

### 1. GitHub Setup ✅
```bash
git add .
git commit -m "Add Render deployment configuration"
git push origin main
```

### 2. Create Render Account
- Visit https://render.com
- Sign up with GitHub
- Authorize Render to access your repositories

### 3. Deploy Web Service

**Step 1: Create Web Service**
- Dashboard → New → Web Service
- Select your college-management repository
- Name: `college-management`
- Environment: Node
- Region: Choose your region
- Branch: main
- Build Command: `npm install`
- Start Command: `npm start`
- Plan: Free or Starter

**Step 2: Environment Variables**
Add these in the "Environment" section:

```
SESSION_SECRET=your_secure_random_string_minimum_32_characters
NODE_ENV=production
PORT=3000

DB_DIALECT=postgres
DB_HOST=(will add after creating database)
DB_PORT=5432
DB_NAME=(will add after creating database)
DB_USER=(will add after creating database)
DB_PASSWORD=(will add after creating database)

EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_gmail_app_password

BASE_URL=https://your-app-name.onrender.com

ADMIN_EMAIL=admin@example.com
ADMIN_PASSWORD=change_this_after_login
```

**Step 3: Deploy**
- Click "Create Web Service"
- Wait for deployment (2-5 minutes)
- Check logs for errors

### 4. Deploy PostgreSQL Database

**Step 1: Create Database**
- Dashboard → New → PostgreSQL
- Name: `college-management-db`
- Database: college_management
- User: postgres_user
- Region: Same as web service
- Plan: Free

**Step 2: Copy Credentials**
From the database page, copy:
- Host
- Port
- Database
- User
- Password

**Step 3: Update Web Service Environment**
Go back to web service and update:
```
DB_HOST=your_copied_host
DB_PORT=5432
DB_NAME=your_copied_database
DB_USER=your_copied_user
DB_PASSWORD=your_copied_password
```

### 5. Manual Deploy (if needed)
- Go to Web Service → Manual Deploy → Deploy latest

### 6. Test Deployment
- Visit: https://your-app-name.onrender.com
- Check logs for errors
- Test login/signup
- Test email functionality
- Test complaint submission

## Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| SESSION_SECRET | Session encryption key (min 32 chars) | `abc123xyz...` |
| NODE_ENV | Environment (production/development) | `production` |
| PORT | Application port | `3000` |
| DB_DIALECT | Database type | `postgres` |
| DB_HOST | Database hostname | `dpg-xxx.postgres.render.com` |
| DB_PORT | Database port | `5432` |
| DB_NAME | Database name | `college_management` |
| DB_USER | Database user | `username` |
| DB_PASSWORD | Database password | `password` |
| EMAIL_USER | Gmail address for sending emails | `your@gmail.com` |
| EMAIL_PASS | Gmail app password (NOT main password) | `16_char_password` |
| BASE_URL | Application public URL | `https://app.onrender.com` |
| ADMIN_EMAIL | Admin account email | `admin@example.com` |
| ADMIN_PASSWORD | Admin account password | `secure_password` |

## Troubleshooting

### Application Won't Start

**Error: Cannot find module**
```
Solution: Clear build cache → Redeploy
Go to: Settings → Clear cache → Redeploy
```

**Error: ECONNREFUSED at database**
```
Solution: 
1. Verify DB credentials are correct
2. Database might not be created yet
3. Wait 2-3 minutes and redeploy
4. Check database is in same region
```

### Database Issues

**Error: relation "users" does not exist**
```
Solution: Sequelize hasn't synced tables yet
1. Check app logs for sync status
2. Tables are created automatically on first run
3. Wait and refresh
```

**Error: Authentication failed for user**
```
Solution: Wrong DB credentials
1. Go to PostgreSQL database page
2. Copy credentials exactly from connection string
3. Update web service environment variables
4. Redeploy
```

### Email Not Working

**Gmail says "Less secure apps" error**
```
Solution: Use App Password instead
1. Enable 2FA on Gmail account
2. Go to myaccount.google.com/apppasswords
3. Generate app password
4. Use this password as EMAIL_PASS
5. Update environment variable
```

**Error: Invalid login**
```
Solution: Check credentials
1. Verify EMAIL_USER is correct Gmail
2. Verify EMAIL_PASS is app-specific password (16 chars)
3. Check 2FA is enabled
```

### Deployment Stuck

**Build seems to hang**
```
Solution: 
1. Check internet connection
2. Clear build cache → Settings → Clear cache → Redeploy
3. Check if any package is taking too long to install
4. Contact Render support
```

### App Starts but No Response

**Port issue or app crash**
```
Solution:
1. Don't hardcode PORT - use process.env.PORT
2. Check app logs for errors
3. Verify all environment variables are set
4. Restart service: Dashboard → Manual Deploy
```

## Performance & Optimization

### Free Tier Limitations
- ⏱️ Spins down after 15 mins of inactivity
- 📦 First request may take 30+ seconds (cold start)
- 💾 PostgreSQL free: 90-day limit
- 🌐 Limited bandwidth

### To Minimize Cold Starts
- Upgrade to Starter plan ($7/month)
- Or keep app "warm" with periodic requests
- Use tools like UptimeRobot (free)

### Monitoring

**View Logs**
- Dashboard → Your Service → Logs
- Search for errors or warnings
- Check deployment status

**Check Performance**
- Dashboard → Metrics
- View CPU, memory, response time

## Auto-Deploy from GitHub

Render automatically deploys when you push to GitHub:

```bash
# Make changes locally
nano app.js  # Edit file
git add .
git commit -m "Fix bug in authentication"
git push origin main

# Render automatically detects change and redeploys!
# Check logs in Render dashboard
```

## Security Checklist

- [ ] Changed default ADMIN_PASSWORD
- [ ] SESSION_SECRET is strong (32+ chars)
- [ ] Never commit `.env` to GitHub
- [ ] Using Gmail App Password (not main password)
- [ ] HTTPS is enabled (Render default)
- [ ] DATABASE_URL is not hardcoded
- [ ] Sensitive info not in code comments

## Useful Commands (Local)

```bash
# Test locally before deploying
npm install
npm start

# View what's in .env (never push this!)
cat .env

# Check Node version
node --version

# Check if PostgreSQL is running (Windows)
sc query PostgreSQL

# Check if PostgreSQL is running (Mac/Linux)
brew services list | grep postgresql
```

## Deployment Status Flow

```
Pushing to GitHub
        ↓
Render detects change
        ↓
Builds: npm install
        ↓
Deploys: npm start
        ↓
Server running ✅
```

## Getting Help

- **Render Support**: https://support.render.com
- **App Logs**: Check in Render Dashboard
- **GitHub Issues**: Create in your repo
- **Stack Overflow**: Tag with [render.com]

## After Deployment

1. ✅ Visit your app URL
2. ✅ Test user registration
3. ✅ Test login
4. ✅ Test complaint submission
5. ✅ Verify emails are sending
6. ✅ Check admin dashboard
7. ✅ Celebrate! 🎉

---

**Deployment Complete!** Your app is now live on Render. 🚀
