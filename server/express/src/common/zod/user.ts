// Generated by ts-to-zod
import { z } from "zod";
import { refSchema, opaqueSchema } from "./base";
import { socialNodeSchema } from "./social";

export const userRefSchema = refSchema;

export const userSchema = socialNodeSchema.extend({
  id: opaqueSchema,
});

export const userProfileSchema = userSchema.extend({
  dob: z.date(),
});