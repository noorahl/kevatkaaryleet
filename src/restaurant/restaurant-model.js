import promisePool from "../../utils/database.js";

// Hakee ravintoloiden yhteystiedot tietokannasta ja palauttaa rivit.

const listAllRestaurants = async () => {
  const [rows] = await promisePool.query("SELECT * FROM Restaurant");
  return rows;
};

export { listAllRestaurants };
