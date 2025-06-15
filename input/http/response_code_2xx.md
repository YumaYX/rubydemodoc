**RC2XX**

This Ruby code checks if a given URL returns a successful HTTP status code (200-299).

1.  **Parses the URL:** It parses the URL string into its components (host, port, path).
2.  **Creates an HTTP Connection:** It establishes a connection to the URL's server.  It uses SSL if the URL is HTTPS.
3.  **Sends a GET Request:** It sends a GET request to the specified path.
4.  **Checks the Response Code:** It retrieves the HTTP response code and checks if it's within the range of 200 to 299 (inclusive). This indicates a successful HTTP request.
