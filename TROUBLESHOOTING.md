# Render Deployment Troubleshooting

## Common Issues & Solutions

### 1. Build Fails: "Cannot find module"

**Problem**: Build fails with module not found error

**Solutions**:
```bash
# Option 1: Clear Render build cache
# Render Dashboard → Your Service → Settings → Clear Cache → Redeploy

# Option 2: Reinstall dependencies locally
npm install
git add package-lock.json
git commit -m "Update package-lock.json"
git push origin main
```

### 2. Application Starts but Won't Connect to Database

**Problem**: Application error connecting to PostgreSQL

**Check**:
1. Database is in same region as web service
2. Database is fully created (not still initializing)
3. Credentials match exactly

**Solution**:
```bash
# In Render Dashboard:
1. Go to PostgreSQL database page
2. Copy "Internal Database URL"
3. Parse it: postgresql://user:password@host:port/database
4. Use each part for environment variables:
   - DB_HOST = host
   - DB_PORT = port (usually 5432)
   - DB_USER = user
   - DB_PASSWORD = password
   - DB_NAME = database
```

### 3. "No such table: users"

**Problem**: Tables not being created automatically

**Reason**: Sequelize needs to sync database on first run

**Solution**:
```bash
1. Check app logs for sync messages
2. Wait 1-2 minutes for tables to be created
3. Refresh application
4. If still fails:
   - Redeploy manually
   - Check Sequelize sync in app.js is working
```

### 4. Email Not Sending

**Problem**: Emails not arriving to users

**Check List**:
- [ ] EMAIL_USER is a valid Gmail address
- [ ] EMAIL_PASS is Gmail App Password (NOT your main password)
- [ ] 2-Factor Authentication enabled on Gmail
- [ ] App Password generated at myaccount.google.com/apppasswords
- [ ] Check spam/junk folder

**Test Email Setup**:
1. Create test account
2. Register with email
3. Check for verification email
4. View app logs for email errors

### 5. "ECONNREFUSED" or Connection Timeout

**Problem**: Cannot connect to database or external service

**Causes**:
- Database not ready yet
- Wrong credentials
- Network/firewall issue
- Service down

**Solution**:
```bash
1. Wait 2-3 minutes for database to fully initialize
2. Manual redeploy: Dashboard → Manual Deploy
3. Check credentials again in environment variables
4. Verify database status in Render dashboard
```

### 6. Application Running Slow / Timing Out

**Problem**: App takes >30 seconds to respond

**Reasons on Free Tier**:
- Cold start (app not running, needs to start)
- Database cold start
- Large file operations
- Insufficient resources

**Solutions**:
1. Upgrade to Starter plan ($7/month) for always-on
2. Keep app warm with periodic requests (UptimeRobot free service)
3. Optimize database queries
4. Reduce initial data loading

### 7. "502 Bad Gateway" Error

**Problem**: Application crashed or not responding

**Debug**:
1. Check app logs in Render dashboard
2. Look for JavaScript errors
3. Check if database is still accessible

**Common Causes**:
- Out of memory
- Database disconnected
- Unhandled error in code
- PORT variable not set

**Fix**:
```javascript
// Make sure app.js uses environment PORT
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

### 8. File Uploads Not Working

**Problem**: Uploaded files disappear or cannot access them

**Note**: Render uses ephemeral file system - files are deleted on redeploy

**Solutions**:
- Option 1: Store files in PostgreSQL as BLOB
- Option 2: Use external storage (AWS S3, Cloudinary)
- Option 3: Mount persistent volume (paid tier)

**Temporary**: For development/testing
```javascript
// Current setup: files go to /uploads folder
// Will be deleted on redeploy
// Implement real file storage for production
```

### 9. Environment Variables Not Being Read

**Problem**: process.env variables are undefined

**Check**:
1. Variables added to Render environment
2. Redeployed after adding variables (should be auto)
3. Variable names are exact match (case-sensitive)

**Debug**:
```javascript
// Add to app.js temporarily
console.log('DB_HOST:', process.env.DB_HOST);
console.log('DB_NAME:', process.env.DB_NAME);
// Check app logs
```

### 10. "Error: listen EADDRINUSE"

**Problem**: Port already in use

**Solution**: Never hardcode port!
```javascript
// ✅ CORRECT
const PORT = process.env.PORT || 5000;

// ❌ WRONG
const PORT = 5000; // Fails on Render
```

### 11. Session/Login Not Working

**Problem**: Users get logged out or sessions lost

**Causes**:
- SERVICE_SECRET not set
- Session store not configured properly
- Browser cookies blocked

**Solution**:
```env
SESSION_SECRET=your_very_secure_random_string_at_least_32_characters_long_abc123xyz...
```

### 12. "Cannot GET /" or Routes Not Found

**Problem**: Routes returning 404

**Reason**: EJS views or static files not found

**Check**:
```bash
# In Render logs, look for:
"Cannot find module '/app/views/home.ejs'"
```

**Solution**:
1. Ensure all view files are in Git
2. Check file paths are relative
3. Verify .gitignore is not excluding needed files

```javascript
// ✅ CORRECT - relative paths
app.set("views", path.join(__dirname, "views"));

// ❌ WRONG - hardcoded paths
app.set("views", "/home/user/views");
```

## Diagnostics

### View Real-Time Logs

```bash
# Render Dashboard → Your Service → Logs
# Shows deployment and runtime logs
# Errors appear here first
```

### Check Service Status

- Green (✓): Running normally
- Yellow (⚠): Deploying or restarting
- Red (✗): Error or crashed

### Manual Redeploy

1. Dashboard → Your Service
2. Top right → "Manual Deploy" → "Deploy latest"
3. Watch logs for progress

## Prevention Tips

✅ **Test Locally First**
```bash
npm run dev
# Verify everything works
```

✅ **Check Logs Frequently**
- After each deployment
- After making changes
- When users report issues

✅ **Use Staging Environment**
- Deploy to test Render instance before production

✅ **Monitor Performance**
- Dashboard → Metrics
- Watch CPU and memory usage

✅ **Keep Dependencies Updated**
```bash
npm update
npm audit
git push origin main
# Render auto-redeploys
```

## Contact Render Support

If issues persist:
1. Check logs carefully
2. Try manual redeploy
3. Check Render status page: https://status.render.com/
4. Contact support: https://support.render.com

---

**Still stuck?** Check [RENDER_DEPLOYMENT.md](./RENDER_DEPLOYMENT.md) for complete guide.
