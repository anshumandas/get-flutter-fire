import type { User } from "@/api/user/userModel";
import { State, EntryAction } from "@/common/models/enums";

export const users: User[] = [
  {
    id: "AA",
    name: "Alice",
    on: new Date(),
    type: "User",
    version: 0,
    status: State.NEW,
    by: "0ADMIN",
    action: EntryAction.CREATE
  },
  {
    id: "BR",
    name: "Robert",
    on: new Date(),
    type: "User",
    version: 0,
    status: State.NEW,
    by: "0ADMIN",
    action: EntryAction.CREATE
  },
];

export class UserRepository {
  async findAllAsync(): Promise<User[]> {
    return users;
  }

  async findByIdAsync(id: string): Promise<User | null> {
    return users.find((user) => user.id === id) || null;
  }
}
