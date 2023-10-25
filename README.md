# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...

# furima-39424

## Table Design

### Users Table

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| id                 | integer | Primary Key               |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birthdate          | date    | null: false               |

#### Association

- has_many :items
- has_many :purchases

---

### Items Table

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| id                     | integer    | Primary Key                    |
| name                   | string     | null: false                    |
| description            | text       | null: false                    |
| category_id            | integer    | null: false                    |
| sales_status_id        | integer    | null: false                    |
| shipping_fee_id        | integer    | null: false                    |
| prefecture_id          | integer    | null: false                    |
| scheduled_delivery_id  | integer    | null: false                    |
| price                  | integer    | null: false                    |
| user                   | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- has_one :purchase

---

### Purchases Table

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| id     | integer    | Primary Key                    |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

#### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

---

### ShippingAddresses Table

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| id            | integer    | Primary Key                    |
| postal_code   | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| purchase      | references | null: false, foreign_key: true |

#### Association

- belongs_to :purchase
