query getUser {
  getUser(UserId: "1") {
    UserId
    Username
  }
}

query getOrder {
  getOrder(OrderId: "1") {
    OrderId
    UserId
  }
}

mutation createUser {
  createUser(UserId: "1", Username: "Paul") {
    UserId
    Username
  }
}

mutation createOrder {
  createOrder(OrderId: "1", UserId: "1", ProductId:"1") {
    OrderId
    UserId
    ProductId
}
