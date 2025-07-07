# CAP4770-Project

This repository contains the group project for CAP 4770: Introduction to 
Data Science at the University of Florida. Our project uses Docker to 
run a data science environment with:

- Streamlit Dashboard for data visualization.
- Jupyter Lab for collaborative data exploration and analysis.
- A SQLite database loaded from the [WELFake dataset](https://www.kaggle.com/datasets/saurabhshahane/fake-news-classification/data).

## Setup

Requirements:
- Docker 28.3.0, or later

Steps:
1. Fork and clone repo.
2. Navigate to project root (CAP4770-Project).
3. Download [WELFake_dataset.csv](https://www.kaggle.com/datasets/saurabhshahane/fake-news-classification/data).
    - Must be named exactly and placed in project root.
4. Give permissions to `docker-control.sh`:
    ```
    chmod +x docker-control.sh
    ```
5. Build and run the containers: 
   ```
   ./docker-control.sh build
   ./docker-control.sh start
   ```
   - Run `./docker-control.sh help` for more info.

## Access

Streamlit Dashboard: http://localhost:8501 \
Jupyter Lab: http://localhost:8888
- Login password: 1234
  - When you’re done using Jupyter Lab:
    - Go to File → Log Out in the Jupyter menu.
    - Then stop the Docker containers:

     ```
     ./docker-control.sh stop
     ```

Note: If you don’t log out first, you might see this harmless warning:
```
404 GET /api/kernels/17ebbb8..
Kernel does not exist
```

## Please Do

Please, to keep us all up to date, do the following:
1. Work in your own Notebook titled `NameNotebook.ipynb`.
2. When you are done for the day: 
   - Make a PR and update main.
   - Let us know we need to pull from main.