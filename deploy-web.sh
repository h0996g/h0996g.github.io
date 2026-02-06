#!/bin/bash

# Deploy Flutter web app to h0996g.github.io
# Usage: ./deploy-web.sh "commit message"

COMMIT_MSG="${1:-Update web app}"
WEB_REPO="https://github.com/h0996g/h0996g.github.io.git"
TEMP_DIR="/tmp/web-deploy-$(date +%s)"
PROJECT_DIR="/Users/mac/Development/Projects/ajr"

echo "🚀 Deploying Flutter web app to h0996g.github.io..."

# Build the Flutter web app
echo "🔨 Building Flutter web app..."
cd "$PROJECT_DIR"
flutter build web --release \
  --dart-define=SUPABASE_URL=https://kbaxcgshfludldlncmdb.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtiYXhjZ3NoZmx1ZGxkbG5jbWRiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjUwNDczMTgsImV4cCI6MjA4MDYyMzMxOH0.LS9uOpfpjRCpECX91Ql7mkj31YyxHeRh5WFlzoq3GAQ

# Check if build was successful
if [ ! -d "build/web" ]; then
    echo "❌ Build failed! build/web directory not found."
    exit 1
fi

# Clone the web repo
echo "📦 Cloning repository..."
git clone "$WEB_REPO" "$TEMP_DIR"

# Clean the repo (keep .git)
echo "🧹 Cleaning repository..."
cd "$TEMP_DIR"
rm -rf * .github .gitignore .metadata 2>/dev/null

# Copy built web files from build/web
echo "📋 Copying built web files from build/web..."
cp -r "$PROJECT_DIR/build/web/"* "$TEMP_DIR/"

# Commit and push
echo "💾 Committing changes..."
git add .
git commit -m "$COMMIT_MSG"

echo "⬆️  Pushing to GitHub..."
git push origin main

# Cleanup
echo "🧹 Cleaning up..."
cd "$PROJECT_DIR"
rm -rf "$TEMP_DIR"

echo "✅ Deployment complete!"
echo "🌐 Your site will be live at https://h0996g.github.io in 1-2 minutes"
