import streamlit as st
import pandas as pd
import sqlite3

# Function to query SQLite
@st.cache_data
def load_data():
    conn = sqlite3.connect("WELFake_Dataset.db")
    df = pd.read_sql("SELECT * FROM WELFake_Dataset", conn,  index_col="id")
    conn.close()
    return df

st.title("My Streamlit Dashboard")

df = load_data()

st.write("Data preview:")
st.dataframe(df.head(10))

if "value" in df.columns:
    st.line_chart(df["value"])
