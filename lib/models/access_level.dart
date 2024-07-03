enum AccessLevel {
  public, //available without any login
  guest, //available with guest login
  notAuthed, // used for login screens
  authenticated, //available on login
  roleBased, //available on login and with allowed roles
  masked, //available in a partly masked manner based on role
  secret //never visible
}
