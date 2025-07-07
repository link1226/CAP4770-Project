import pandas as pd
import sqlite3

# Connect to SQLite DB
conn = sqlite3.connect('WELFake_Dataset.db')
cursor = conn.cursor()

# Drop table if exists
cursor.execute('DROP TABLE IF EXISTS WELFake_Dataset')

# Create table with index as PRIMARY KEY
cursor.execute('''
    CREATE TABLE WELFake_Dataset (
        id INTEGER PRIMARY KEY,
        title TEXT,
        text TEXT,
        label TEXT
)
''')

# Read CSV into DF
df = pd.read_csv('WELFake_Dataset.csv')
df = df.drop(columns=['index'])

try:
    # Insert DataFrame into table WITHOUT the DataFrame index
    df.to_sql('WELFake_Dataset', conn, if_exists='append', index=False)

except Exception as e:
    print(e)

# Commit and close connection
conn.commit()
conn.close()
