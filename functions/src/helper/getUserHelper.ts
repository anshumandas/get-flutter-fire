import { usersRef } from "./firebaseHelper";

export async function getUser(userID: string) {
  const userSnapshot = await usersRef().doc(userID).get();
  return userSnapshot.exists ? userSnapshot.data() : null;
}
