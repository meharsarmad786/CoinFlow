# 🚀 CoinFlow - Enterprise Cryptocurrency Management Platform

> **A scalable, modern Ruby on Rails application for cryptocurrency portfolio tracking, price monitoring, and market analysis. Built to handle billions of users.**

[![Ruby](https://img.shields.io/badge/Ruby-3.1.2+-red.svg)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/Rails-7.2.3+-red.svg)](https://rubyonrails.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Latest-blue.svg)](https://www.postgresql.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind-4.0+-38bdf8.svg)](https://tailwindcss.com/)

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Technology Stack](#-technology-stack)
- [Installation](#-installation)
- [Features Breakdown](#-features-breakdown)
- [Architecture](#-architecture)
- [Scalability](#-scalability)

---

## 🎯 Overview

**CoinFlow** is a comprehensive cryptocurrency management platform designed for scale. Built with Ruby on Rails and modern web technologies, it provides real-time price tracking, portfolio management, transaction history, and intelligent price alerts.

### Why CoinFlow?

- ✅ **Real-Time Price Tracking** - Live cryptocurrency prices from CoinGecko API
- ✅ **Portfolio Management** - Track investments, calculate P/L, manage holdings
- ✅ **Price Alerts** - Set custom alerts for price movements
- ✅ **Transaction History** - Complete buy/sell transaction tracking
- ✅ **Beautiful Modern UI** - Tailwind CSS with gradient designs
- ✅ **Scalable Architecture** - Built for billions of users
- ✅ **Secure Authentication** - Devise-based user management
- ✅ **Responsive Design** - Works on all devices

---

## ✨ Key Features

### 📊 Real-Time Market Data
- **Top Cryptocurrencies** - View top 100+ cryptocurrencies by market cap
- **Live Price Updates** - Automatic price synchronization
- **Market Statistics** - Market cap, volume, 24h changes
- **Search Functionality** - Find any cryptocurrency quickly
- **Trending Coins** - Discover trending cryptocurrencies

### 💼 Portfolio Management
- **Auto-Calculated Values** - Real-time portfolio valuation
- **Profit/Loss Tracking** - Automatic P/L calculation with percentages
- **Holdings Overview** - View all your cryptocurrency holdings
- **Average Price Tracking** - Weighted average for multiple purchases
- **Portfolio Summary** - Total value, invested, and P/L at a glance

### 🔔 Price Alerts
- **Custom Alerts** - Set alerts for price above/below targets
- **Active Monitoring** - Automatic alert checking
- **Alert History** - Track triggered alerts
- **Multiple Alerts** - Set multiple alerts per cryptocurrency

### 📝 Transaction Management
- **Buy/Sell Tracking** - Record all transactions
- **Transaction History** - Complete transaction log
- **Filter Options** - Filter by buy/sell type
- **Auto Portfolio Updates** - Transactions automatically update portfolio

### 🎨 Modern UI/UX
- **Gradient Design** - Beautiful purple/pink gradient theme
- **Dark Mode** - Easy on the eyes
- **Responsive Layout** - Mobile-friendly design
- **Smooth Animations** - Polished user experience
- **Intuitive Navigation** - Easy to use interface

---

## 🛠 Technology Stack

### Backend
- **Ruby** 3.1.2+
- **Rails** 7.2.3+
- **PostgreSQL** - Scalable relational database
- **Devise** - Authentication
- **Sidekiq** - Background job processing
- **Redis** - Caching and job queue

### Frontend
- **Tailwind CSS** 4.0+ - Utility-first CSS framework
- **Turbo Rails** - SPA-like experience
- **Stimulus** - Modest JavaScript framework
- **Import Maps** - Modern JavaScript without bundlers

### APIs & Services
- **CoinGecko API** - Cryptocurrency price data
- **HTTParty** - HTTP client for API calls

### Development Tools
- **Puma** - Web server
- **Brakeman** - Security scanner
- **RuboCop** - Code quality

---

## 🚀 Installation

### Prerequisites

- Ruby 3.1.2 or higher
- PostgreSQL (latest version)
- Rails 7.2.3 or higher
- Redis (for background jobs and caching)
- Bundler gem

### Step-by-Step Setup

1. **Navigate to the project directory**
   ```bash
   cd CoinFlow
   ```

2. **Install Ruby dependencies**
   ```bash
   bundle install
   ```

3. **Set up the database**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start Redis (for background jobs)**
   ```bash
   redis-server
   ```

5. **Start the Rails server**
   ```bash
   rails server
   # or use foreman for multiple processes
   bin/dev
   ```

6. **Access the application**
   - Open your browser and navigate to: `http://localhost:3000`
   - Sign up for a new account or use the demo credentials

---

## 🔑 Default Credentials

After running `rails db:seed`, you can use:

- **Email:** `demo@coinflow.com`
- **Password:** `password123`

---

## 📱 Features Breakdown

### Dashboard
- **Portfolio Summary** - Total value, invested amount, profit/loss
- **Holdings Overview** - All your cryptocurrency holdings
- **Recent Transactions** - Last 10 transactions
- **Market Overview** - Top 10 cryptocurrencies
- **Active Alerts** - Your active price alerts

### Markets
- **Cryptocurrency List** - All available cryptocurrencies
- **Search** - Find by symbol or name
- **Price Information** - Current price, 24h change, market cap
- **Detailed Views** - Individual cryptocurrency pages

### Portfolio
- **Holdings Table** - Complete holdings breakdown
- **P/L Calculation** - Per-coin and total profit/loss
- **Current Values** - Real-time portfolio valuation
- **Transaction Links** - Quick access to add transactions

### Transactions
- **Transaction Form** - Easy buy/sell recording
- **Auto-Calculation** - Total amount calculated automatically
- **History View** - All transactions with filters
- **Portfolio Integration** - Automatic portfolio updates

### Price Alerts
- **Alert Creation** - Set alerts for any cryptocurrency
- **Active Alerts** - Monitor all active alerts
- **Triggered Alerts** - View triggered alerts
- **Alert Management** - Easy deletion of alerts

---

## 🏗 Architecture

### Database Models

| Model | Description | Key Features |
|-------|-------------|-------------|
| **User** | Authentication | Devise integration, auto portfolio creation |
| **Cryptocurrency** | Crypto data | Price, market cap, volume, changes |
| **Portfolio** | User portfolio | Total value, P/L calculation |
| **PortfolioItem** | Individual holdings | Quantity, average price, current value |
| **Transaction** | Buy/sell records | Type, quantity, price, total |
| **PriceAlert** | Price alerts | Target price, alert type, status |

### Key Relationships

```
User (1) ──< (1) Portfolio
Portfolio (1) ──< (*) PortfolioItem
PortfolioItem (*) ──< (1) Cryptocurrency
User (1) ──< (*) Transaction
Transaction (*) ──< (1) Cryptocurrency
User (1) ──< (*) PriceAlert
PriceAlert (*) ──< (1) Cryptocurrency
```

### Services

- **CryptoPriceService** - Fetches and updates cryptocurrency prices from CoinGecko API

---

## 📈 Scalability Features

### Built for Scale
- **Background Jobs** - Sidekiq for async processing
- **Caching** - Redis for fast data access
- **Database Indexing** - Optimized queries
- **API Rate Limiting** - Rack::Attack for protection
- **Efficient Queries** - Eager loading, scopes
- **Pagination** - Kaminari for large datasets

### Performance Optimizations
- **Database Indexes** - On frequently queried fields
- **Eager Loading** - Prevents N+1 queries
- **Caching Strategy** - Redis caching for price data
- **Background Processing** - Price updates via Sidekiq
- **Optimized Migrations** - Proper decimal precision

---

## 🎨 UI/UX Features

- **Modern Gradient Design** - Purple/pink theme
- **Dark Mode** - Easy on the eyes
- **Responsive Grid Layouts** - Works on all screen sizes
- **Smooth Transitions** - Polished animations
- **Color-Coded Data** - Green for gains, red for losses
- **Intuitive Navigation** - Easy to use
- **Real-Time Updates** - Live data display

---

## 🔒 Security Features

- **Password Encryption** - BCrypt hashing
- **CSRF Protection** - Built-in Rails protection
- **SQL Injection Protection** - ActiveRecord parameterization
- **XSS Protection** - Automatic HTML escaping
- **Rate Limiting** - Rack::Attack integration
- **Secure Sessions** - Devise session management

---

## 📝 License

This project is proprietary software created for cryptocurrency management. All rights reserved.

---

## 👨‍💻 Development Team

Built with ❤️ using Ruby on Rails

---

**CoinFlow** - *Your Gateway to the Crypto Universe* 🚀💰
