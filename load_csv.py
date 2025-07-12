import os
import pandas as pd
import sqlite3

# Get path to this script's folder (root/)
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Construct absolute paths
csv_path = os.path.join(BASE_DIR, 'WELFake_Dataset.csv')
db_path = os.path.join(BASE_DIR, 'WELFake_Dataset.db')

print("Loading CSV from:", csv_path)
print("Saving DB to:", db_path)

# Connect to SQLite
conn = sqlite3.connect(db_path)
cursor = conn.cursor()

# Drop table if it exists
cursor.execute('DROP TABLE IF EXISTS WELFake_Dataset')

# Create table
cursor.execute('''
    CREATE TABLE WELFake_Dataset (
        id INTEGER PRIMARY KEY,
        title TEXT,
        text TEXT,
        label TEXT
    )
''')

# Read CSV
df = pd.read_csv(csv_path, index_col=0)
print("CSV loaded. Shape:", df.shape)
print("Columns:", df.columns)

# Move index into an "id" column
df = df.reset_index().rename(columns={'index': 'id'})
print("After resetting index:")
print(df.head())

# Write DataFrame to table
try:
    df.to_sql('WELFake_Dataset', conn, if_exists='append', index=False)
    print("Data written successfully.")
except Exception as e:
    print("Error writing data:", e)

# Check table contents
cursor.execute("SELECT COUNT(*) FROM WELFake_Dataset;")
count = cursor.fetchone()[0]
print(f"Rows loaded into WELFake_Dataset: {count}")

conn.commit()
conn.close()
print("DB connection closed.")