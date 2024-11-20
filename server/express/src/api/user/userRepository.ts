import type { User } from "@/api/user/userModel";
import {DB_API} from "@/common/dal"

// export const users: User[] = [
//   {
//     id: "AA",
//     name: "Alice",
//     on: new Date(),
//     type: "User",
//     version: 0,
//     status: State.NEW,
//     by: "0ADMIN",
//     action: EntryAction.CREATE
//   },
//   {
//     id: "BR",
//     name: "Robert",
//     on: new Date(),
//     type: "User",
//     version: 0,
//     status: State.NEW,
//     by: "0ADMIN",
//     action: EntryAction.CREATE
//   },
// ];

export class UserRepository {
  async findAllAsync(): Promise<User[]> {
    return DB_API.singleton.queryMany("users");
  }

  async findByIdAsync(id: string): Promise<User | null> {
    return await DB_API.singleton.queryByID("users", id) || null;
  }
}
