/* RESTAURANT TABLE */

DROP TABLE IF EXISTS Restaurant;

CREATE TABLE Restaurant (
	restaurant_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	info_text_fi VARCHAR(500) NOT NULL,
	info_text_eng VARCHAR(500) NOT NULL,
	phone_number VARCHAR(50),
	name VARCHAR(50),
	address VARCHAR(100)
);

/* ADMIN TABLE */

DROP TABLE IF EXISTS Admin;

CREATE TABLE Admin (
	admin_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	password_hash VARCHAR(255) NOT NULL,
	username VARCHAR(255) NOT NULL,
	restaurant_id INT NOT NULL,

	CONSTRAINT fk_Restaurant
	FOREIGN KEY(restaurant_id)
	REFERENCES Restaurant(restaurant_id)
);

/* RESTAURANT_FOOD TABLE */

DROP TABLE IF EXISTS Restaurant_Food;

CREATE TABLE Restaurant_Food (
	restaurant_id INT NOT NULL,
    food_id INT NOT NULL,

	PRIMARY KEY (restaurant_id, food_id),

	CONSTRAINT fk_Restaurant
	FOREIGN KEY(restaurant_id)
	REFERENCES Restaurant(restaurant_id),

	CONSTRAINT fk_Food
	FOREIGN KEY(food_id)
	REFERENCES Food(food_id)
);


/* ORDERS STATUS TABLE */

DROP TABLE IF EXISTS Order_Status;

CREATE TABLE Order_Status (
	order_status_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	status_fi VARCHAR(50) NOT NULL,
	status_eng VARCHAR(50) NOT NULL
);

INSERT INTO Order_Status (status_fi, status_eng) VALUES
('Odottaa käsittelyä', 'Pending'),
('Käsittelyssä', 'Processing'),
('Lähetetty', 'Shipped'),
('Toimitettu', 'Delivered'),
('Peruutettu', 'Cancelled');

/* ORDER TABLE */

DROP TABLE IF EXISTS Order_Item;
DROP TABLE IF EXISTS Order_History;
DROP TABLE IF EXISTS `Order`;

CREATE TABLE `Order` (
	order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	user_id INT NOT NULL,
	restaurant_id INT NOT NULL,
	status_id INT NOT NULL,
	total_price DECIMAL(10, 2) NOT NULL,
	delivery_address VARCHAR(100) NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT fk_User
	FOREIGN KEY(user_id)
	REFERENCES User(user_id),

	CONSTRAINT fk_Restaurant
	FOREIGN KEY (restaurant_id)
	REFERENCES Restaurant(restaurant_id),

	CONSTRAINT fk_Order_status
	FOREIGN KEY (status_id)
	REFERENCES Order_status(order_status_id)
);

/* ORDER HISTORY TABLE */

CREATE TABLE Order_History (
	history_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	order_id INT NOT NULL,
	status_id INT NOT NULL,

	CONSTRAINT fk_Order
	FOREIGN KEY(order_id)
	REFERENCES `Order`(order_id),

    CONSTRAINT fk_Status
    FOREIGN KEY(status_id)
    REFERENCES Order_Status(order_status_id)
);

/* ORDER ITEM TABLE */

CREATE TABLE Order_Item (
	order_item_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	order_id INT NOT NULL,
	food_id INT NOT NULL,
	quantity INT NOT NULL,

	CONSTRAINT fk_Item_Order
	FOREIGN KEY(order_id)
	REFERENCES `Order`(order_id),

	CONSTRAINT fk_Food
	FOREIGN KEY(food_id)
	REFERENCES Food(food_id)
);
