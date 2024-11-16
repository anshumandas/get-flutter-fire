import { extendZodWithOpenApi } from "@asteasolutions/zod-to-openapi";
import { z } from "zod";

import { commonValidations } from "@/common/utils/commonValidation";
import { userSchema } from "@/common/zod/user";

extendZodWithOpenApi(z);

export type User = z.infer<typeof userSchema>;
export const UserSchema = userSchema;

// Input Validation for 'GET users/:id' endpoint
export const GetUserSchema = z.object({
  params: z.object({ id: commonValidations.id }),
});
