# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# furima-39424

## Table Design

### Users Table

| Column    | Type    | Options     |
|-----------|---------|-------------|
| id        | integer | Primary Key |
| nickname  | string  | NOT NULL    |
| email     | string  | NOT NULL, UNIQUE |
| password  | string  | NOT NULL    |
| birthdate | date    | NOT NULL    |

#### Association
- has_many :items
- has_many :purchases

---

### Items Table

| Column        | Type       | Options                        |
|---------------|------------|--------------------------------|
| id            | integer    | Primary Key                    |
| image         | string     | NOT NULL                       |
| name          | string     | NOT NULL                       |
| description   | text       | NOT NULL                       |
| category      | string     | NOT NULL                       |
| condition     | string     | NOT NULL                       |
| shipping_fee  | string     | NOT NULL                       |
| prefecture    | string     | NOT NULL                       |
| shipping_days | string     | NOT NULL                       |
| price         | integer    | NOT NULL                       |
| user_id       | references | NOT NULL, FOREIGN KEY (user)   |

#### Association
- belongs_to :user
- has_one :purchase

---

### Purchases Table

| Column  | Type       | Options                       |
|---------|------------|-------------------------------|
| id      | integer    | Primary Key                   |
| user_id | references | NOT NULL, FOREIGN KEY (user)  |
| item_id | references | NOT NULL, FOREIGN KEY (item)  |

#### Association
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

---

### ShippingAddresses Table

| Column      | Type       | Options                          |
|-------------|------------|----------------------------------|
| id          | integer    | Primary Key                      |
| postal_code | string     | NOT NULL                         |
| prefecture  | string     | NOT NULL                         |
| city        | string     | NOT NULL                         |
| address     | string     | NOT NULL                         |
| building    | string     |                                  |
| phone_number| string     | NOT NULL                         |
| purchase_id | references | NOT NULL, FOREIGN KEY (purchase) |

#### Association
- belongs_to :purchase