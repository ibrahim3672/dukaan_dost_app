# DukanDost 🛍️

**Digitizing everyday retail for small shopkeepers — in their own language, their own way.**

DukanDost ("Shop Friend") is a mobile application built with **Flutter**, backed by a **Laravel Sanctum REST API** and **MySQL** database, with **Gemini AI** powering intelligent voice parsing and business insights. It helps small shopkeepers (*dukan owners*) manage daily business operations — sales, stock, and *udhaar* (credit) — using simple, Urdu-friendly, voice-first tools.

---

## 📖 Table of Contents

- [Introduction](#introduction)
- [Background](#background)
- [Goals & Objectives](#goals--objectives)
- [Problem Statement (Gap Analysis)](#problem-statement-gap-analysis)
- [Proposed Solution](#proposed-solution)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Roadmap](#roadmap)

---

## Introduction

In many regions, especially in Pakistan, small retailers still rely on manual methods — paper registers and memory — to track sales, stock, and *udhaar*. This leads to errors, lost data, and poor financial management.

DukanDost digitizes traditional retail processes in a simple, Urdu-friendly, and accessible way, enabling shopkeepers to improve efficiency, reduce losses, and make better business decisions — without needing technical training.

## Background

Small retail businesses (*kirana* stores, medical shops, clothing shops) form a large part of the economy in developing countries. However, most of these businesses:

- Do not use digital systems
- Lack technical knowledge
- Prefer simple and fast workflows

Existing solutions — POS systems, inventory software, accounting apps — are often too complex, English-based, and require training to use.

Recent advancements in mobile development (Flutter), voice recognition, and cloud-based REST APIs (Laravel Sanctum + MySQL) have made it possible to build lightweight, user-friendly solutions tailored for local users.

## Goals & Objectives

**Main Goal:** To develop a user-friendly mobile app that helps small shopkeepers manage sales, stock, and *udhaar* using voice input and a simple UI.

**Objectives:**

1. Enable shopkeepers to record sales using Urdu voice input
2. Provide an easy way to manage *udhaar* (credit accounts)
3. Track stock levels and generate low-stock alerts
4. Generate monthly sales and profit reports
5. Ensure secure data storage and access through a cloud backend (Laravel + MySQL)
6. Design a simple UI for non-technical users
7. Provide WhatsApp-based reminders for payments

## Problem Statement (Gap Analysis)

Small shopkeepers face difficulty managing daily sales records, customer *udhaar*, and inventory tracking. Relying on paper registers and memory results in data loss, calculation errors, and poor financial visibility.

### Limitations of Existing Solutions

| Existing Solution | Problem |
|---|---|
| POS Systems | Expensive & complex |
| Accounting Apps | English-based |
| Inventory Apps | Not designed for small shops |
| Manual Registers | Error-prone |

**Identified Gap:** There is no simple, Urdu-based, voice-enabled, AI-powered online mobile app specifically designed for small shopkeepers.

## Proposed Solution

DukanDost is a cloud-based mobile application that allows shopkeepers to record sales via voice, track *udhaar*, manage stock, and view reports — all from one app.

| Problem | Solution |
|---|---|
| Manual records | Digital entry |
| Complex apps | Simple UI |
| Language barrier | Urdu voice input |
| No automation | Gemini AI parsing & insights |
| No cloud/multi-device support | Secure cloud backend (Laravel + MySQL) |

### Unique Features (Innovation)

- ⭐ Urdu voice-based sales entry
- Real-time cloud sync via Laravel Sanctum REST API
- WhatsApp reminder integration
- Designed specifically for Pakistani shopkeepers
- Simple UI for low-literacy users

## Features

### High Priority (Core Features)

**1. Voice Entry System**
- Record sales using Urdu voice
- Extracts: customer name, product, quantity, price

**2. Dashboard**
- Daily sales summary
- Total *udhaar*
- Low stock alerts
- Quick action buttons

**3. Udhaar Management**
- Customer list
- Credit tracking
- Payment history
- WhatsApp reminders

**4. Stock Management**
- Add/update products
- Track quantities
- Low stock alerts

**5. Reports**
- Monthly sales chart
- Best-selling products
- Profit estimation

### Medium Priority

- Manual sales entry
- Notifications (stock alerts)
- Category-based product management

### Low Priority / Future Features

- Gemini AI-powered sales analytics and business insights
- Push notifications for payments and stock alerts
- AI-based analytics
- PDF report export

## Tech Stack

| Layer | Technology |
|---|---|
| Mobile App | Flutter |
| Backend API | Laravel (Sanctum) |
| Database | MySQL |
| AI / Voice Parsing | Gemini AI |
| Notifications | WhatsApp API integration |

## Roadmap

- [ ] Core voice entry system (Urdu)
- [ ] Dashboard & udhaar management
- [ ] Stock management module
- [ ] Sales & profit reporting
- [ ] WhatsApp payment reminders
- [ ] Gemini AI–powered analytics & insights
- [ ] PDF report export

---

*DukanDost is built to give every small shopkeeper — regardless of technical background — the tools to run a smarter, more organized business.*
