# Deployment Guide for Ajr Web App

## Automatic Deployment Setup

Your Flutter web app is now configured to automatically deploy to GitHub Pages whenever you push to the `main` branch.

### First-Time Setup

1. **Enable GitHub Pages in your repository:**

   - Go to: https://github.com/h0996g/noor/settings/pages
   - Under "Source", select: **GitHub Actions**
   - Click "Save"

2. **Push your changes:**

   ```bash
   git add .
   git commit -m "Add GitHub Actions deployment workflow"
   git push origin main
   ```

3. **Wait for deployment:**
   - Go to: https://github.com/h0996g/noor/actions
   - Watch the workflow run (takes ~2-3 minutes)
   - Once complete, your app will be live!

### Your Web App URL

After deployment, your app will be available at:
**https://h0996g.github.io/**

### Future Updates

From now on, any time you push to the `main` branch, your web app will automatically rebuild and deploy! 🚀

Just:

```bash
git add .
git commit -m "Your changes"
git push origin main
```

### Manual Deployment (Alternative)

If you prefer to deploy manually without GitHub Actions:

1. Build the web app:

   ```bash
   flutter build web --release --base-href /
   ```

2. Install gh-pages tool:

   ```bash
   npm install -g gh-pages
   ```

3. Deploy:
   ```bash
   gh-pages -d build/web
   ```

## Troubleshooting

- **Workflow not running?** Make sure GitHub Actions is enabled in your repository settings
- **404 errors?** Check that the `--base-href` matches your repository name
- **Old version showing?** Clear your browser cache or do a hard refresh (Ctrl+Shift+R or Cmd+Shift+R)
