#!/bin/bash
# Startup script for Render deployment

echo "🚀 Starting College Management System..."
echo "📍 NODE_ENV: $NODE_ENV"
echo "🔗 Database: $DB_HOST:$DB_PORT/$DB_NAME"
echo "🌐 Base URL: $BASE_URL"

# Start the application
npm start
