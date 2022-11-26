## How to run

1. Clone the repo
2. Install gems (current using Ruby 3.0.2)
    ```
   bundle install
    ```
3. Set up DB
    ```
   rake db:migrate
    ```
4. Run tests suite (optional)
    ```
   rails test
    ```
5. Start web server
    ```
   rails s
    ```
6. Using Postman or curl to send requests to our server at `http://localhost:3000` (See API docs for endpoints details)

## API documentation

### 1. Encode URL API

- Endpoint: /encode
- Method: POST
- params:
    ```json
    {
      "url": "http://example.com" // required
    }
    ```
- Example success response
    ```json
    {
      "message": "URL encoded successfully",
      "encoded_url": "http://abc123.xyz"
    }
    ```

### 2. Decode URL API

- URL: /decode
- Method: POST
- params:
    ```json
    {
      "encoded_url": "http://abc123.xyz" // required
    }
    ```
- Example success response
    ```json
    {
      "message": "URL decoded successfully",
      "encoded_url": "http://example.com"
    }
    ```

## Security concerns

### 1. Lack of authentication mechanisms, anyone can call API freely

Currently in our service we don't implement any auth mechanisms, which result in everyone can call our API endpoint
freely without any limit

**Suggestions:**

- Allow free users / anonymous to encode only 1 API, we can simple check unique by IP, browser info.
- Implement authentication mechanism (JWT / Oauth), with it we can control who can use our API service

### 2. Too many incoming requests, DDoS attack

Our service may suffer from DDoS attack or suddenly too many requests coming to our server, eating up all the resources
and might kill the service

**Suggestions:**

- Implement throttling requests, allow only number of requests to be made per account / IP
- When deploy our service, dont expose it directly on Internet, instead put it behind a proxy server (nginx) and route
  the traffic in-out through the proxy server,
  in case we are being under attacked, we would have just stop the proxy server to protect our service

## Scalability concerns

### 1. DB performance

In time, our service may grow bigger and serve millions users, we might face the issue with DB performance

**Suggestions:**

- In this example we are using SQLite, for the sake of simplicity, but in the real world, we might need to user a more mature DB such as PostgresSQL for better performance
- Implement caching for even better performance (Redis, Memcache ...)

### 2. High availability (HA)

If we deploy our service on only 1 server, if something happen cause the server down, we will lost our service.

**Suggestions:**

- On production, at least deploy our API on 2 servers and distribute the request using a Load Balancer
