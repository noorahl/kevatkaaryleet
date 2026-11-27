import { listAllRestaurants } from "./restaurant-model.js";

// Hakee ravintoloiden yhteystiedot restaurant-modelista.
// Palauttaa vastauksen json muodossa

const getAllRestaurants = async (req, res) => {
  const restaurants = await listAllRestaurants();

  if (!restaurants) {
    return res.status(404).json({ message: "Ravintoloita ei löytynyt" });
  }

  res.json({
    message: "Tässä ravintolat",
    data: restaurants,
  });
};

export { getAllRestaurants };
