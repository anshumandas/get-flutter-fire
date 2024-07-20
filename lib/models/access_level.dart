enum AccessLevel {
  notAuthed, // used for login screens
  public, //available without any login
  guest, //available with guest login
  authenticated, //available on login
  roleBased, //available on login and with allowed roles
  masked, //available in a partly masked manner based on role
  secret //never visible
}
