import express from "express";
import { getAllRestaurants } from "./restaurant-controller.js";

const restaurantRouter = express.Router();

restaurantRouter.get("/", getAllRestaurants);

export default restaurantRouter;
