import express from "express";
import restaurantRouter from "./restaurant/restaurant-routes.js";
//import userRouter from "./routes/user-router.js";
//import authRouter from "./routes/auth-router.js";

const router = express.Router();

// bind base url for all restaurant routes to restaurantRouter
router.use("/restaurants", restaurantRouter);
// TODO: use userRouter for all /users endpoints
//router.use("/users", userRouter);

//router.use("/auth", authRouter);

export default router;
