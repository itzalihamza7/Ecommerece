# E-commerce Store

A multi-vendor online store built with Ruby on Rails. Sellers list products with image galleries, customers comment, fill a cart and pay through Stripe Checkout, and admins manage everything from an admin panel.

## Features

- **Accounts and roles:** sign-up and sign-in with Devise, profile pictures, and Customer, Seller and Admin roles enforced with Pundit
- **Products:** create, edit and delete your own products with multiple images (Active Storage on Cloudinary) and an auto-generated unique serial number
- **Comments:** comment on other users' products without reloading the page; you can't comment on your own products
- **Cart:** add products (but not your own), change quantities and remove items. A guest's cart is kept and moved to their account when they sign in at checkout
- **Checkout:** Stripe Checkout sessions for cart and "buy now" purchases, with Stripe products and prices kept in sync and payment results confirmed through a signed Stripe webhook
- **Orders:** every order and payment is recorded and viewable per user
- **Promo codes:** coupons with an expiry date, created as Stripe coupons and promotion codes
- **Search:** live product search from the header with Ransack
- **Admin panel:** RailsAdmin at `/admin`

## Tech stack

Ruby 2.7.1 · Rails 5.2 · PostgreSQL · Stripe · Devise · Pundit · Active Storage + Cloudinary · Ransack · RailsAdmin · Redis · jQuery · RSpec

## Getting started

Requires Ruby 2.7.1, PostgreSQL, Redis, Node.js and Yarn, plus Stripe and Cloudinary accounts.

```bash
bundle install
yarn install
```

The encrypted credentials in the repository need a `master.key` that is not committed, so create your own:

```bash
rm config/credentials.yml.enc
EDITOR="nano" bin/rails credentials:edit
```

and add your Stripe keys:

```yaml
stripe:
  public: pk_test_...
  secret: sk_test_...
  webhook_d: whsec_...   # webhook signing secret for development
  webhook_p: whsec_...   # webhook signing secret for production
```

Set your Cloudinary credentials as an environment variable:

```bash
export CLOUDINARY_URL=cloudinary://API_KEY:API_SECRET@CLOUD_NAME
```

Then create the database and start the app:

```bash
bin/rails db:create db:migrate
bin/rails server
```

Forward Stripe webhooks to your local app with the Stripe CLI: `stripe listen --forward-to localhost:3000/webhooks`. Email confirmations need SMTP settings in `config/environments/`.

## Project structure

```
app/controllers/   Products, comments, cart, checkout, orders, search, webhooks
app/models/        User, Product, Comment, CartItem, Order, OrderProduct, Coupon
app/policies/      Pundit authorization rules
app/services/      Stripe webhook handling
spec/              RSpec setup and factories
```
