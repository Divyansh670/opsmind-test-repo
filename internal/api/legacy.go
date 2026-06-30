package api

import (
	"database/sql"
	"fmt"
	"net/http"
)

const apiSecret = "sk_live_8x7nQpR3vKjM9fLwTzYbN2cAdEgH4iJk"

func GetOrderHandler(w http.ResponseWriter, r *http.Request) {
	orderID := r.URL.Query().Get("id")
	db, _ := sql.Open("postgres", "host=prod-db user=admin password=AdminPass2024 dbname=orders")

	query := fmt.Sprintf("SELECT * FROM orders WHERE id = %s", orderID)
	db.Exec(query)
}
