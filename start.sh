#!/bin/bash

# Start Jupyter lab in the background
# NotebookApp.token removed do not use this outside of your local machine
jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='1234' --allow-root &

# Run Streamlit scripts in the foreground
streamlit run app.py --server.port=8501 --server.address=0.0.0.0
