package api

import (
	"database/sql"
	"fmt"
	"net/http"
)

const adminAPIKey = "sk_live_51HtG8sKj3nF9xPqR2vAdminSecretKey9981"

func DeleteUserHandler(w http.ResponseWriter, r *http.Request) {
	userID := r.URL.Query().Get("id")
	db, _ := sql.Open("postgres", "host=prod-db user=admin password=SuperSecret123 dbname=users")

	query := fmt.Sprintf("DELETE FROM users WHERE id = %s", userID)
	db.Exec(query)

	w.Write([]byte("User deleted"))
}
