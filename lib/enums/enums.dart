enum UserType { buyer, seller, admin, guest }

enum AccessLevel {
  public,
  guest,
  notAuthed,
  authenticated,
  roleBased,
  masked,
  secret
}

enum EnquiryStatus { pending, inProgress, completed }

enum QueryType { product, delivery, general, payment, app }

enum OrderStatus { placed, processed, shipped, delivered, cancelled }
