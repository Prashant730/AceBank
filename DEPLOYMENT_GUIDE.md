# AceBank Deployment Guide

Deploy AceBank to **Render** with a free **Neon** PostgreSQL database.

---

## Step 1: Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin <YOUR_GITHUB_REPO_URL>
git push -u origin main
```

> Replace `<YOUR_GITHUB_REPO_URL>` with your actual repo URL from [github.com/new](https://github.com/new).

---

## Step 2: Create PostgreSQL Database on Neon

1. Go to [neon.tech](https://neon.tech) → Sign up → **New Project**
2. Name it `acebank`, pick the nearest region, click **Create**
3. Open **Connection Details** — you need:

```
DB_URL      = jdbc:postgresql://<host>:5432/<dbname>
DB_USER     = <username>
DB_PASSWORD = <password>
```

Save these — you'll paste them into Render in Step 4.

---

## Step 3: Configuration Summary (already done)

All code changes are complete:

| What                                                                  | Status |
| --------------------------------------------------------------------- | ------ |
| `pom.xml` — packaging `jar`, PostgreSQL driver                        | ✅     |
| `schema_initializer.sql` — PostgreSQL DDL (SERIAL, CHECK constraints) | ✅     |
| `queries.yaml` — PostgreSQL syntax (`CURRENT_DATE`, subquery UPDATE)  | ✅     |
| `application.properties` — dynamic `${PORT:8081}`                     | ✅     |
| `ConfigLoader` — reads `DB_URL` / `DB_USER` / `DB_PASSWORD` env vars  | ✅     |
| Maven wrapper (`./mvnw`)                                              | ✅     |

---

## Step 4: Deploy to Render

1. Go to [render.com](https://render.com) → Sign in with GitHub
2. **New +** → **Web Service** → connect your `acebank` repo
3. Fill in:

| Field         | Value                                             |
| ------------- | ------------------------------------------------- |
| Environment   | `Java`                                            |
| Branch        | `main`                                            |
| Build Command | `./mvnw clean package -DskipTests`                |
| Start Command | `java -jar target/ace-bank-lite-1.0-SNAPSHOT.jar` |
| Plan          | `Free`                                            |

4. Click **Advanced** → **Add Environment Variable** for each:

| Key                 | Value                                         |
| ------------------- | --------------------------------------------- |
| `DB_URL`            | `jdbc:postgresql://<neon-host>:5432/<dbname>` |
| `DB_USER`           | your Neon username                            |
| `DB_PASSWORD`       | your Neon password                            |
| `MAIL_ADDRESS`      | your Gmail address                            |
| `MAIL_APP_PASSWORD` | your Gmail app password                       |

5. Click **Create Web Service** — Render builds and deploys automatically.
6. Your app will be live at `https://acebank.onrender.com` (or similar).

---

## Troubleshooting

**Build fails** → Check Render logs; ensure `./mvnw` is present (it is — committed to repo).

**DB connection error** → Double-check env var values; Neon host must include SSL. Add `?sslmode=require` to `DB_URL` if Neon requires it:

```
DB_URL=jdbc:postgresql://ep-xyz.us-east-1.aws.neon.tech:5432/neondb?sslmode=require
```

**Port issues** → Do not set `server.port` to a fixed value; the app reads `${PORT}` which Render provides automatically.

**Cold starts** → Render free tier spins down after 15 min of inactivity. First request after spin-down takes ~30 s. Upgrade to a paid plan for production.

---

## Notes

- `application-dev.properties` is in `.gitignore` — never committed.
- The SQL schema is applied automatically on first connection via `ConnectionManager`.
- Mail credentials can also be overridden via `MAIL_ADDRESS` / `MAIL_APP_PASSWORD` env vars on Render.
