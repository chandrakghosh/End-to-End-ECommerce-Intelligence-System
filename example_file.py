#Order Level Dataset
order_level = orders.merge(customers, on="customer_id", how="left")

order_level = order_level.merge(order_items_agg, on="order_id", how="left")

order_level = order_level.merge(payments_agg, on="order_id", how="left")

order_level = order_level.merge(reviews_agg, on="order_id", how="left")

print(order_level.shape)
print(order_level["order_id"].nunique())

order_level.to_csv(
    "../data/cleaned/order_level_dataset.csv",
    index=False
)

order_level.head()

order_level.info()



# Merge products with product_category translation
products = products.merge(
    category_translation,
    on="product_category_name",
    how="left")
print(products.head())

# Aggregate order items
order_items_agg = order_items.groupby("order_id").agg({
    "price": "sum",
    "freight_value": "sum",
    "product_id": "count",
    "seller_id": "nunique"
}).reset_index()
order_items_agg.columns = [
    "order_id",
    "total_price",
    "total_freight",
    "num_items",
    "num_sellers"
]
print(order_items_agg.head())

#Aggregate payments table
payments_agg = order_payments.groupby("order_id").agg({
    "payment_value": "sum",
    "payment_installments": "max",
    "payment_type": lambda x: x.mode()[0]
}).reset_index()
payments_agg.columns = [
    "order_id",
    "total_payment",
    "payment_installments",
    "payment_type"
]
print(payments_agg.head())

# Aggregate reviews table
reviews_agg = order_reviews.groupby("order_id").agg({
    "review_score": "mean"
}).reset_index()
reviews_agg.columns = [
    "order_id",
    "review_score"
]
print(reviews_agg.head())