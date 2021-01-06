# COVID-19 Dashboard with R Shinny 
This little project consists of the development of an interactive dashboard for visualizing different COVID indicators
at France such as:
* number of deaths
* number of positive cases
* number of hospitalizations
* ...

All that, observed from different analyses axes like **age**, **department**, **region** and **date**.

# How to install it
1. Clone the repository ``git clone https://github.com/juan-kabbali/covid-dashboard.git``
2. Your R version must be ``r >= 3.6``
3. Install required packages
    ```r
    install.packages(c("shiny","DBI","RMySQL","plotly","rjson"))
    ```
4. Import [this](data/MySQL_db_dump.sql) MySQL database
5. Modify MySQL ENV variables according to your database instance
    ```r
    host = "localhost"
    dbname = "covid"
    username = "root"
    password = "shhh!"
    ```
6. Run the app and lets Analyse
    ```shell
    # OPTION 1
        # JUST RUN app.R FILE
    
    # OPTION 2
        # EXECUTE
        R -e "shiny::runApp('covid-dashboard')"
    ````
