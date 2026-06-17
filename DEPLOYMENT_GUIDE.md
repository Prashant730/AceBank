# AceBank Deployment Guide

This guide walks through deploying AceBank to Render with PostgreSQL database on Neon.

---

## Step 1: Push Project to GitHub

1. **Initialize Git Repository**
```bash
cd d:\AceBank-main
git init
git add .
git commit -m "Initial commit"
git branch -M main
```

2. **Create a GitHub Repository**
   - Go to [GitHub](https://github.com/new)
   - Create a new repository named `acebank`
   - Copy the repository URL (HTTPS or SSH)

3. **Push to GitHub**
```bash
git remote add origin <YOUR_GITHUB_REPO_URL>
git push -u origin main
```

Replace `<YOUR_GITHUB_REPO_URL>` with your actual GitHub repository URL.

---

## Step 2: Create PostgreSQL Database on Neon

1. **Sign up for Neon**
   - Go to [Neon](https://neon.tech)
   - Click "Sign up"
   - Create a free account

2. **Create a new project**
   - Click "New Project"
   - Set project name: `acebank`
   - Select region closest to you
   - Click "Create"

3. **Get your database credentials**
   - You'll see a connection string like: `postgresql://user:password@host:5432/dbname`
   - Or view in the "Connection details" section:
     - **DB_HOST**: e.g., `ep-xyz.us-east-1.aws.neon.tech`
     - **DB_PORT**: `5432`
     - **DB_NAME**: `neondb` (or your project name)
     - **DB_USER**: e.g., `neondb_owner`
     - **DB_PASSWORD**: (shown once, save it!)

**Save these values securely!** You'll need them for Render.

---

## Step 3: Update Project Configuration

✅ **Already completed!** The following changes have been made:

### pom.xml changes:
- ✅ Changed packaging from `war` to `jar`
- ✅ Removed MySQL connector dependency
- ✅ Added PostgreSQL driver dependency

### application.properties changes:
- ✅ Added PostgreSQL datasource URL configuration
- ✅ Added Hibernate dialect for PostgreSQL
- ✅ Environment variables support for database credentials

### application-dev.properties changes:
- ✅ Updated database connection to PostgreSQL
- ✅ Updated database driver to PostgreSQL driver

The application is now configured to use PostgreSQL!

---

## Step 4: Build the Project Locally (Optional)

To verify everything works before deployment:

```bash
# Build the project
./mvnw clean package

# The JAR file will be created at: target/ace-bank-lite-1.0-SNAPSHOT.jar
```

---

## Step 5: Create Render Account

1. **Sign up for Render**
   - Go to [Render](https://render.com)
   - Click "Get Started"
   - Sign in with GitHub (recommended)

2. **Authorize Render with GitHub**
   - Click "Connect GitHub"
   - Authorize Render to access your repositories

---

## Step 6: Deploy to Render

### 6.1 Create a New Web Service

1. Go to [Render Dashboard](https://dashboard.render.com)
2. Click **"New +"** → **"Web Service"**
3. Select your `acebank` repository from GitHub
4. Click **"Connect"**

### 6.2 Configure Build Settings

Fill in the configuration:

| Field | Value |
|-------|-------|
| **Name** | `acebank` |
| **Environment** | `Java` |
| **Region** | (Select closest to your users) |
| **Branch** | `main` |
| **Build Command** | `./mvnw clean package` |
| **Start Command** | `java -jar target/ace-bank-lite-1.0-SNAPSHOT.jar` |
| **Plan** | `Free` (optional: upgrade for production) |

### 6.3 Add Environment Variables

Click **"Advanced"** → **"Add Environment Variable"** for each:

| Key | Value |
|-----|-------|
| `SPRING_DATASOURCE_URL` | `jdbc:postgresql://HOST:5432/DATABASE` |
| `SPRING_DATASOURCE_USERNAME` | Your Neon DB_USER |
| `SPRING_DATASOURCE_PASSWORD` | Your Neon DB_PASSWORD |

**Example:**
```
SPRING_DATASOURCE_URL=jdbc:postgresql://ep-xyz.us-east-1.aws.neon.tech:5432/neondb
SPRING_DATASOURCE_USERNAME=neondb_owner
SPRING_DATASOURCE_PASSWORD=your_password_here
```

### 6.4 Deploy

1. Click **"Create Web Service"**
2. Render will automatically build and deploy
3. Monitor the build logs in the dashboard
4. Once deployed, you'll get a URL like: `https://acebank.onrender.com`

---

## Step 7: Verify Deployment

After deployment completes:

1. **Check logs** in Render dashboard for any errors
2. **Visit your app**: `https://acebank.onrender.com`
3. **Test core features**:
   - User registration
   - User login
   - Account operations
   - Admin dashboard

---

## Troubleshooting

### Build Fails
- Check that `./mvnw` is executable
- Verify Java version compatibility (Java 21 required)
- Check pom.xml for typos

### Application Crashes
- Check Render logs for database connection errors
- Verify environment variables are set correctly
- Check PostgreSQL credentials from Neon

### Database Errors
- Verify PostgreSQL driver is added to pom.xml
- Check connection string format
- Ensure Neon database is created and accessible

### Port Issues
- Application runs on port determined by Render (dynamic)
- Don't set `server.port` to a fixed port in production

---

## Additional Notes

- **Free Tier Limitations**:
  - Render free tier spins down after 15 minutes of inactivity
  - First request after spin-down takes ~30 seconds
  - Upgrade to paid plan for production use

- **Database Backups**:
  - Set up regular backups in Neon dashboard
  - Consider automated backup schedule

- **Monitoring**:
  - Enable logs in Render dashboard
  - Set up alerts for deployment failures

- **Custom Domain**:
  - Add your custom domain in Render dashboard
  - Update DNS records accordingly

---

## Next Steps

1. ✅ Push to GitHub
2. ✅ Create Neon PostgreSQL database
3. ✅ Configuration is ready
4. Create Render account
5. Deploy web service to Render
6. Monitor and verify deployment

Good luck with your deployment! 🚀
