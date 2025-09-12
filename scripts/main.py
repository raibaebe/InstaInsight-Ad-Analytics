import psycopg2

try:
    conn = psycopg2.connect(
        host="localhost",
        port=5432,
        database="adinsight",
        user="postgres",
        password="0000"
    )
    conn.autocommit = True
    print("Database connection successful.\n")
except Exception as e:
    print("Error connecting to database:", e)
    exit()

cur = conn.cursor()

queries = [
    "SELECT ad_platform, COUNT(*) AS total_ads FROM ads GROUP BY ad_platform ORDER BY total_ads DESC;",
    "SELECT ad_type, COUNT(*) AS total_ads FROM ads GROUP BY ad_type ORDER BY total_ads DESC;",
    "SELECT target_gender, COUNT(*) AS total_ads FROM ads GROUP BY target_gender ORDER BY total_ads DESC;"
]

for i, query in enumerate(queries, start=1):
    try:
        cur.execute(query)
        if cur.description:
            rows = cur.fetchall()
            print(f"Query {i} results:")
            for row in rows:
                print(row)
            print()
        else:
            print(f"Query {i} executed successfully (no results to fetch).\n")
    except Exception as e:
        print(f"Error running query {i}: {e}\n")

cur.close()
conn.close()
print("Database connection closed.")
