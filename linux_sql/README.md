# Introduction

The project is designed with a modular approach, comprising different independent programs that work seamlessly together. The final product monitors a Linux cluster using a relational database to store hardware specifications and collect real-time host usage data every minute, which is then saved in the database. The intended users are likely individuals familiar with UNIX environments, such as system administrators, software developers, and engineers. The project is developed using the Bash language for scripting purposes, enabling data collection and transmission to the database. The database tables are automatically created and designed relationally using an SQL file, ensuring seamless synchronization with the Bash scripts. Crontab is utilized to automatically run one of the scripts every minute. Docker is employed to containerize, ship, run, and deploy the entire product. Additionally, GitHub is utilized to host code and facilitate collaboration.

# Quick Start

- Start a psql instance using ``` ./linux_sql/scripts/psql_docker.sh start|stop|create [db_username][db_password] ```
- Create tables using ``` sql/ddl.sql ```
- Insert hardware specs data into the DB using ``` bash linux_sql/scripts/host_info.sh psql_host psql_port db_name psql_user psql_password ```
- Insert hardware usage data into the DB using ``` bash linux_sql/scripts/host_usage.sh psql_host psql_port db_name psql_user psql_password ```
- Crontab setup ``` * * * * * bash [full path to run host_usage] > /tmp/host_uage.log ```

# Implemenation

The two Bash scripts (host_info.sh and host_usage.sh) are implemented to enhance the robustness of the code and to validate the arguments in order to mitigate the risk of errors. Data is collected using a combination of Linux commands and pipelines (|).
A SQL INSERT statement is assigned to a variable with the data collected in psql. This variable is then used as an argument to communicate with the psql database at the end of the scripts.

The psql_docker.sh script is implemented to create, start, or stop Docker containers and is designed to be robust, mitigating the risk of errors, and running appropriate commands to perform the desired task.

The DDL SQL script creates tables if they don't exist with the appropriate number of rows and all the information that will be collected in the Bash scripts, ensuring everything will be synchronized perfectly during runtime.

## Architecture

![Architecture](./assets/Architecture.drawio.png)

## Scripts

- ``` psql_docker.sh: create, start, or stop Docker containers``` 
- ``` host_info.sh: collect hardware secifications and puts it in our host_info table```
- ``` host_usage.sh: collect resource usage data and insert it to the database host_usage table ````
- ``` crontab: run host_usage script every minute to collect memory informations in real time``` 
- ``` ddl.sql: Create tables for the database ``` 

## Database Modeling

- ```host_info : this table has columns for each of the important hardware specs with some different and appropriate data types to receive data```
- ```usage_info : this table has columns for each of the important resource usage data with some different and appropriate data types to receive data```

# Test

After the creation of the Docker container, we connect to the psql instance to create a database named 'host_agent'. Once it's successfully created, we run our 'ddl.sql' script and insert some data into the 2 tables for testing purposes.
Once completed, we verify everything with a SQL query to see all the table lines in order to ensure that every piece of data is inserted successfully. Once done, we run the 'host_info' script and verify the 'host_info' table.
Once it's confirmed to be correct, we run the 'host_usage' script once and verify if the data is successfully inserted into the appropriate table.
After completing this, we set up 'host_usage' to run with crontab and verify after some minutes if all the data collected during this timeframe is successfully inserted.
If the desired result is achieved, our project works perfectly.

#Deployment

The Cluster Monitor is shipped and run in Docker containers, and the code is hosted in the jarviscanada/jarvis_data_eng_AhmadouGaye GitHub repository. It is deployed using crontab technology, allowing it to update our database every minute.

#Improvements

- handle hardware updates
- option to send signal when there is no longer disk available 
- have more robustness in the code
