#!/bin/bash
export AIRFLOW_HOME=~/airflow

AIRFLOW_VERSION=2.2.0
PYTHON_VERSION=3.8

CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
# Example: https://raw.githubusercontent.com/apache/airflow/constraints-2.1.4/constraints-3.6.txt

pip3 install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

# initialize the database
airflow db init

airflow users create \
    --username admin \
    --firstname Nome \
    --lastname Sobrenome \
    --role Admin \
    --email dominio@email.com

# start the web server, default port is 8080
airflow webserver --port 8080

# start the scheduler
# open a new terminal or else run webserver with ``-D`` option to run it as a daemon
airflow scheduler

# visit localhost:8080 in the browser and use the admin account you just
# created to login. Enable the example_bash_operator dag in the home page
