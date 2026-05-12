# Hevo Data Engineering Assessment

## Project Overview

This project implements an end-to-end ELT pipeline using:

- PostgreSQL (Source system hosted on EC2 using Docker)
- Hevo Data (CDC-based ingestion)
- Snowflake (Cloud data warehouse)
- dbt (Transformation + Testing)

---

## Architecture

PostgreSQL (EC2)
↓
Hevo CDC Pipeline
↓
Snowflake Raw Layer (HEVO_PUBLIC)
↓
dbt Transformation Layer (ANALYTICS)

---

## Project Structure

```bash
hevo_project/
├── models/
│   ├── customers.sql
│   └── schema.yml
├── macros/
├── tests/
├── dbt_project.yml
├── README.md
└── .gitignore
```

---

## Source Setup

### PostgreSQL

PostgreSQL was hosted on EC2 using Docker.

Logical replication was enabled with:

- wal_level = logical
- max_replication_slots = 10
- max_wal_senders = 10

Additional CDC objects created:

- Replication user: `test_user`
- Publication: `test_publication`
- Replication slot: `test_slot`

Source tables:

- raw_customers
- raw_orders
- raw_payments

---

## Hevo Pipeline Setup

Source: PostgreSQL  
Destination: Snowflake

Pipeline type:

- Historical Load + Incremental CDC

Successfully ingested:

- 312 records
- 0 failures

---

## Snowflake Setup

Database:

```sql
HEVO_ASSESSMENT
```

Raw schema created by Hevo:

```sql
HEVO_PUBLIC
```

Transformation schema created by dbt:

```sql
ANALYTICS
```

---

# Local Development Setup

## Prerequisites

Install:

- Python 3.10+
- Git
- WSL (Ubuntu)
- Snowflake access

---

## Step 1: Clone Repository

```bash
git clone <repo_url>
cd hevo_project
```

---

## Step 2: Create Virtual Environment

```bash
python3 -m venv dbt-env
source dbt-env/bin/activate
```

---

## Step 3: Install Dependencies

```bash
pip install dbt-core dbt-snowflake
```

---

## Step 4: Configure dbt Profile

Edit:

```bash
~/.dbt/profiles.yml
```

Update Snowflake credentials:

- account
- user
- password
- warehouse
- database
- schema

---

## Step 5: Validate Connection

```bash
dbt debug
```

Expected:

```bash
All checks passed!
```

---

# Build Instructions

## Run Models

```bash
dbt run
```

This creates:

```sql
HEVO_ASSESSMENT.ANALYTICS.CUSTOMERS
```

---

## Run Tests

```bash
dbt test
```

Implemented tests:

- customer_id not null
- customer_id unique

---

# Final Output Model

## customers

Columns:

- customer_id
- first_name
- last_name
- first_order
- most_recent_order
- number_of_orders
- customer_lifetime_value

---

# Engineering Challenges

## Local tunnel instability

Initially attempted CDC using local Docker + Bore tunnel.

Problem:

Persistent CDC sessions caused unstable connectivity.

## Resolution

Migrated PostgreSQL to EC2 for stable production-style connectivity.

---

# Deliverables

Included:

- Hevo pipeline implementation
- Snowflake validation
- dbt transformation models
- dbt tests
- GitHub repository
