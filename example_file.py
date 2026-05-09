fact_orders.to_sql(
    "fact_orders",
    con=engine,
    if_exists="append",
    index=False
)

pd.read_sql("SELECT COUNT(*) AS total_orders FROM fact_orders;", con=engine)