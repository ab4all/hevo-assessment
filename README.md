Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

# Hevo Data Engineering Assessment

## Architecture

EC2 PostgreSQL → Hevo CDC → Snowflake → dbt

## Components

### Source
- PostgreSQL hosted on EC2 using Docker
- Logical replication enabled

### Ingestion
- Hevo Data pipeline configured for CDC replication

### Destination
- Snowflake
- Database: HEVO_ASSESSMENT
- Raw Schema: HEVO_PUBLIC

### Transformation
dbt model created in:
- ANALYTICS.CUSTOMERS

## Final Model Columns

- customer_id
- first_name
- last_name
- first_order
- most_recent_order
- number_of_orders
- customer_lifetime_value

## Tests Implemented

- customer_id not null
- customer_id unique

## Challenges & Resolution

### Local tunnel instability
Initially tested using Bore on local WSL + Docker, but multi-session CDC caused tunnel disconnects.

### Resolution
Migrated PostgreSQL source to EC2 for stable production-grade connectivity.

## Deliverables

- Hevo Pipeline ID
- Snowflake validation
- dbt models
- dbt tests
