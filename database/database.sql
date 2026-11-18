/* DROP TABLES IN REVERSE ORDER OF DEPENDENCY */
DROP TABLE IF EXISTS Food_Restrictions;
DROP TABLE IF EXISTS Announcement;
DROP TABLE IF EXISTS Restrictions;
DROP TABLE IF EXISTS Order_Item;
DROP TABLE IF EXISTS Order_History;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS Order_Status;
DROP TABLE IF EXISTS User_favourite_Food;
DROP TABLE IF EXISTS Restaurant_Food;
DROP TABLE IF EXISTS Admin;
DROP TABLE IF EXISTS Food;
DROP TABLE IF EXISTS Food_Category;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Restaurant;

/* RESTAURANT TABLE */

CREATE TABLE Restaurant (
	restaurant_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	info_text_fi VARCHAR(500) NOT NULL,
	info_text_eng VARCHAR(500) NOT NULL,
	phone_number VARCHAR(50) NOT NULL,
	name VARCHAR(50) NOT NULL,
	address VARCHAR(100) NOT NULL,
	email VARCHAR(50) NOT NULL,
	opening_hours VARCHAR(100) NOT NULL
);

/* USER TABLE */

CREATE TABLE User (
	user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	phone_number VARCHAR(50) NOT NULL,
	mail VARCHAR(50) NOT NULL,
	name VARCHAR(50) NOT NULL,
	lastname VARCHAR(50) NOT NULL,
	address VARCHAR(100) NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	username VARCHAR(255) NOT NULL
);

/* ORDERS STATUS TABLE */

CREATE TABLE Order_Status (
	order_status_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	status_fi VARCHAR(50) NOT NULL,
	status_eng VARCHAR(50) NOT NULL
);

/* FOOD CATEGORY TABLE */
CREATE TABLE Food_Category (
	category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_fi VARCHAR(50),
	name_eng VARCHAR(50)
);

/* RESTRICTIONS TABLE */
CREATE TABLE Restrictions (
    restriction_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(10),
    name_fi VARCHAR(50),
    name_eng VARCHAR(50)
);

/* ANNOUNCEMENT TABLE*/

CREATE TABLE Announcement (
	announcement_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	content VARCHAR(500) NOT NULL,
	announcement_date Date NOT NULL DEFAULT CURRENT_DATE,
	restaurant_id INT NOT NULL,

	CONSTRAINT fk_restaurant_announcement
	FOREIGN KEY (restaurant_id)
	REFERENCES Restaurant(restaurant_id)
);

/* FOOD TABLE */
CREATE TABLE Food (
	food_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name_fi VARCHAR(100) NOT NULL,
	name_eng VARCHAR(100) NOT NULL,
	description_fi VARCHAR(500),
	description_eng VARCHAR(500),
	is_available BOOLEAN,
	price DOUBLE NOT NULL,
	category_id INT NOT NULL,
	CONSTRAINT fk_Food_Category
	FOREIGN KEY (category_id)
	REFERENCES Food_Category(category_id)
);

/* ADMIN TABLE */

CREATE TABLE Admin (
	admin_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	password_hash VARCHAR(255) NOT NULL,
	username VARCHAR(255) NOT NULL,
	restaurant_id INT NOT NULL,

	CONSTRAINT fk_Restaurant_Admin
	FOREIGN KEY(restaurant_id)
	REFERENCES Restaurant(restaurant_id)
);

/* RESTAURANT_FOOD TABLE */

CREATE TABLE Restaurant_Food (
	restaurant_id INT NOT NULL,
    food_id INT NOT NULL,

	PRIMARY KEY (restaurant_id, food_id),

	CONSTRAINT fk_Restaurant_Restaurant_Food
	FOREIGN KEY(restaurant_id)
	REFERENCES Restaurant(restaurant_id),

	CONSTRAINT fk_Food_Restaurant_Food
	FOREIGN KEY(food_id)
	REFERENCES Food(food_id)
);

/*USER_FAVOURITE_FOOD TABLE*/

CREATE TABLE User_favourite_Food (
	user_id INT NOT NULL,
    food_id INT NOT NULL,

	PRIMARY KEY (user_id, food_id),

	CONSTRAINT fk_User_Favourite_Food
	FOREIGN KEY(user_id)
	REFERENCES User(user_id),

	CONSTRAINT fk_Food_Favourite_Food
	FOREIGN KEY(food_id)
	REFERENCES Food(food_id)
);

/* ORDER TABLE */

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

/* FOOD RESTRICTIONS TABLE */
CREATE TABLE Food_Restrictions (
    food_id INT NOT NULL,
    restriction_id INT NOT NULL,

    PRIMARY KEY (food_id, restriction_id),

    CONSTRAINT fk_Food_Restrictions_Food
    FOREIGN KEY (food_id)
    REFERENCES Food(food_id),

    CONSTRAINT fk_Food_Restrictions_Restrictions
    FOREIGN KEY (restriction_id)
    REFERENCES Restrictions(restriction_id)
);

/* INSERT DATA */
INSERT INTO Order_Status (status_fi, status_eng) VALUES
('Odottaa käsittelyä', 'Pending'),
('Käsittelyssä', 'Processing'),
('Lähetetty', 'Shipped'),
('Toimitettu', 'Delivered'),
('Peruutettu', 'Cancelled');

INSERT INTO Food_Category (name_fi, name_eng) VALUES
('Alkuruuat', 'Appetizers'),
('Pääruuat', 'Main Courses'),
('Jälkiruuat', 'Desserts'),
('Juomat', 'Drinks');

INSERT INTO Restrictions (code, name_fi, name_eng) VALUES
('L', 'Laktoositon', 'Lactose-free'),
('G', 'Gluteeniton', 'Gluten-free'),
('V', 'Vegaani', 'Vegan');

INSERT INTO Food (name_fi, name_eng, description_fi, description_eng, is_available, price, category_id) VALUES
/* Alkuruuat (Category ID 1) */
('Kasvis Kevätkääryleet 4KPL', 'Vegetable Spring Rolls 4PCS', 'Rapeaksi paistettuja kevätkääryleitä, joiden täytteenä on tuoreita vihanneksia.', 'Crispy fried spring rolls filled with mix of fresh vegetables.', TRUE, 6.50, 1),
('Kana Kevätkääryleet 4KPL', 'Chicken Spring Rolls 4PCS', 'Rapeita kevätkääryleitä, jotka on täytetty kanalla ja kasviksilla.', 'Crispy spring rolls filled with chicken and vegetables.', TRUE, 6.50, 1),
('Kana-maissikeitto', 'Chicken-Sweet Corn Soup', 'Keitto, jossa on kanaa, maissia ja maustettua lientä.', 'Soup with chicken, sweet corn and seasoned broth.', TRUE, 8.50, 1),

/* Pääruuat (Category ID 2) */
('Kantonin kanaa hapanimeläkastikkeessa', 'Cantonese Chicken in Sweet and Sour Sauce', 'Rapeaksi paistettua kanaa tarjoiltuna herkullisessa makean ja happaman kastikkeen kera.', 'Crispy fried chicken served with a delicious sweet and sour sauce.', TRUE, 18.50, 2),
('Kana Kung Po', 'Chicken Kung Po', 'Mehevää kanaa wokattuna chilin, valkosipulin, kasvisten ja cashewpähkinöiden kanssa mausteisessa kastikkeessa.', 'Tender chicken stir-fried with chili, garlic, vegetables and cashew nuts in a spicy sauce.', TRUE, 18.50, 2),
('Paistettua riisiä, kanaa ja vihanneksia', 'Fried Rice with Chicken and Vegetables', 'Paistettua riisiä, mehevää kanaa ja tuoreita vihanneksia kevyesti maustettuna.', 'Fried rice with tender chicken and fresh vegetables, lightly seasoned.', TRUE, 17.00, 2),
('Peking naudanlihaa', 'Peking Beef', 'Mureaa naudanlihaa paistettuna Peking-tyylisessä makean mausteisessa kastikkeessa.', 'Tender beef stir-fried in a sweet and spicy Peking-style sauce.', TRUE, 18.50, 2),
('Naudanliha Chop Suey', 'Beef Chop Suey', 'Wokattua naudanlihaa ja tuoreita vihanneksia herkullisessa kiinalaisessa kastikkeessa.', 'Stir-fried beef and fresh vegetables in a delicious Chinese-style sauce.', TRUE, 18.50, 2),
('Naudanlihaa Satay-kastikkeessa', 'Beef in Satay Sauce', 'Mureaa naudanlihaa tarjoiltuna täyteläisessä ja pehmeässä maapähkinäisessä satay-kastikkeessa.', 'Tender beef served in a rich and creamy peanut satay sauce.', TRUE, 18.50, 2),
('Tofua Chilikastikkeessa', 'Tofu in Chili Sauce', 'Paistettua tofua mausteisessa chilikastikkeessa.', 'Fried tofu served in a spicy chili sauce.', TRUE, 17.00, 2),
('Paistettua tofua wok-vihanneksilla', 'Fried Tofu with Stir-Fried Vegetables', 'Paistettua tofua ja tuoreita wok-vihanneksia kevyesti maustettuna.', 'Fried tofu with fresh stir-fried vegetables, lightly seasoned.', TRUE, 17.00, 2),
('Vihanneksia ja cashewpähkinöitä', 'Vegetables with Cashew Nuts', 'Tuoreita wokattuja vihanneksia ja rapeita cashewpähkinöitä kiinalaisessa kastikkeessa.', 'Fresh stir-fried vegetables and crunchy cashew nuts in Chinese-style sauce.', TRUE, 16.00, 2),
('Paahdettua porsaanlihaa grillikastikkeessa', 'Roast Pork in Barbecue Sauce', 'Mehevää paahdettua porsaanlihaa tarjoiltuna täyteläisessä ja maukkaassa grillikastikkeessa.', 'Juicy roasted pork served with a rich and flavorful barbecue sauce.', TRUE, 18.50, 2),
('Friteerattua porsaanlihaa hapanimeläkastikkeessa', 'Deep Fried Sweet and Sour Pork', 'Rapeaksi friteerattua porsaanlihaa makean ja happaman kastikkeen kera.', 'Crispy deep-fried pork served with a sweet and sour sauce.', TRUE, 16.00, 2),
('Porsaanliha Kung Po', 'Pork Kung Po', 'Mehevää porsaanlihaa wokattuna chilin, valkosipulin, kasvisten ja cashewpähkinöiden kanssa mausteisessa kastikkeessa.', 'Tender pork stir-fried with chili, garlic, vegetables and cashew nuts in a spicy sauce.', TRUE, 18.50, 2),

/* Jälkiruuat (Category ID 3) */
('Friteerattua banaania', 'Deep Fried Banana', 'Kullanruskeaksi friteerattua banaania, joka on pinnalta rapeaa ja sisältä ihanan pehmeää.', 'Golden deep-fried banana, crispy on the outside and deliciously soft on the inside.', TRUE, 5.50, 3),
('Paistettua vaniljajäätelöä', 'Fried Vanilla Ice Cream', 'Rapeaksi paneroitua ja nopeasti paistettua vaniljajäätelöä, tarjoiltuna kinuskikastikkeen kera.', 'Crispy breaded and quick-fried vanilla ice cream, served with caramel sauce.', TRUE, 6.50, 3),
('Mangovanukas', 'Mango Pudding', 'Silkkisen pehmeä ja raikas mangon makuinen vanukas, tarjoiltuna tuoreen mangon kanssa.', 'Silky smooth and refreshing mango-flavored pudding, served with fresh mango.', TRUE, 5.90, 3),-- ==========================================

/* Juomat (Category ID 4) */
('Coca-cola 0,33L', 'Coca-cola 0,33L', NULL, NULL, TRUE, 3.90, 4),
('Coca-cola ZERO 0,33L', 'Coca-cola ZERO 0,33L', NULL, NULL, TRUE, 3.90, 4),
('Fanta 0,33L', 'Fanta 0,33L', NULL, NULL, TRUE, 3.90, 4),
('Kivennäisvesi 0,33L', 'Sparkling water 0,33L', NULL, NULL, TRUE, 2.90, 4),
('Mansikka pillimehu 0,2L', 'Strawberry juice 0,2L', NULL, NULL, TRUE, 2.50, 4);

INSERT INTO Food_Restrictions (food_id, restriction_id) VALUES
(1, 1),  /* Kasvis Kevätkääryleet Laktoositon */
(2, 1),  /* Kana Kevätkääryleet Laktoositon */
(3, 1),  /* Kana-maissi keitto Laktoositon */
(3, 2),  /* Kana-maissi keitto Gluteeniton */
(4, 1),  /* Kantonin kanaa Laktoositon */
(6, 1),  /* Paistettua riisiä, kanaa ja vihanneksia Laktoositon */
(6, 2),  /* Paistettua riisiä, kanaa ja vihanneksia Gluteeniton */
(7, 1),  /* Peking naudanlihaa Laktoositon */
(8, 1),  /* Naudanliha Chop Suey Laktoositon */
(8, 2),  /* Naudanliha Chop Suey Gluteeniton */
(9, 2),  /* Naudanlihaa Satay-kastikkeessa Gluteeniton */
(10, 3), /* Tofua Chilikastikkeessa Vegaaninen */
(11, 3), /* Paistettua tofua wok-vihanneksilla Vegaaninen */
(12, 3), /* Vihanneksia ja cashewpähkinöitä Vegaaninen */
(12, 2), /* Vihanneksia ja cashewpähkinöitä Gluteeniton */
(13, 1), /* Paahdettua porsaanlihaa grillikastikkeessa Laktoositon */
(14, 1), /* Friteerattua porsaanlihaa hapanimeläkastikkeessa Laktoositon */
(15, 1), /* Porsaanliha Kung Po Laktoositon */
(18, 1), /* Mangovanukas Laktoositon */
(18, 2); /* Mangovanukas Gluteeniton */

INSERT INTO Restaurant (info_text_fi, info_text_eng, phone_number, name, address, email, opening_hours) VALUES
('Tervetuloa nauttimaan aidon kiinalaisen keittiön herkullisista mauista Espoon sydämessä! Ravintolamme tarjoaa monipuolisen valikoiman perinteisiä kiinalaisia ruokia, joissa yhdistyvät tuoreet raaka-aineet, huolella valmistetut annokset ja ainutlaatuiset maut.', 'Discover the delicious flavors of authentic Chinese cuisine in the heart of Espoo! Our restaurant offers a wide selection of traditional Chinese dishes, prepared with fresh ingredients, care, and passion.', '040 9913146', 'Kevätkääryle', 'Leppävaarankatu 3, 02600 Espoo', 'kevätkääryleEspoo@gmail.com', 'ma-su klo 10-20'),
('Tervetuloa nauttimaan aidon kiinalaisen keittiön herkullisista mauista Helsingin sydämessä! Ravintolamme tarjoaa monipuolisen valikoiman perinteisiä kiinalaisia ruokia, joissa yhdistyvät tuoreet raaka-aineet, huolella valmistetut annokset ja ainutlaatuiset maut.', 'Discover the delicious flavors of authentic Chinese cuisine in the heart of Helsinki! Our restaurant offers a wide selection of traditional Chinese dishes, prepared with fresh ingredients, care, and passion.', '040 8724534', 'Kevätkääryle', 'Urho Kekkosen katu 1, 00100 Helsinki', 'kevätkääryleHelsinki@gmail.com', 'ma-su klo 10-20'),
('Tervetuloa nauttimaan aidon kiinalaisen keittiön herkullisista mauista Tampereen sydämessä! Ravintolamme tarjoaa monipuolisen valikoiman perinteisiä kiinalaisia ruokia, joissa yhdistyvät tuoreet raaka-aineet, huolella valmistetut annokset ja ainutlaatuiset maut.', 'Discover the delicious flavors of authentic Chinese cuisine in the heart of Tampere! Our restaurant offers a wide selection of traditional Chinese dishes, prepared with fresh ingredients, care, and passion.', '040 4467644', 'Kevätkääryle', 'Vuolteenkatu 1, 33100 Tampere', 'kevätkääryleTampere@gmail.com', 'ma-su klo 10-20'),
('Tervetuloa nauttimaan aidon kiinalaisen keittiön herkullisista mauista Oulun sydämessä! Ravintolamme tarjoaa monipuolisen valikoiman perinteisiä kiinalaisia ruokia, joissa yhdistyvät tuoreet raaka-aineet, huolella valmistetut annokset ja ainutlaatuiset maut.', 'Discover the delicious flavors of authentic Chinese cuisine in the heart of Oulu! Our restaurant offers a wide selection of traditional Chinese dishes, prepared with fresh ingredients, care, and passion.', '040 5793274', 'Kevätkääryle', 'Isokatu 25, 90100 Oulu', 'kevätkääryleOulu@gmail.com', 'ma-su klo 10-20'),
('Tervetuloa nauttimaan aidon kiinalaisen keittiön herkullisista mauista Turun sydämessä! Ravintolamme tarjoaa monipuolisen valikoiman perinteisiä kiinalaisia ruokia, joissa yhdistyvät tuoreet raaka-aineet, huolella valmistetut annokset ja ainutlaatuiset maut.', 'Discover the delicious flavors of authentic Chinese cuisine in the heart of Turku! Our restaurant offers a wide selection of traditional Chinese dishes, prepared with fresh ingredients, care, and passion.', '040 8838754', 'Kevätkääryle', 'Yliopistonkatu 20, 20100 Turku', 'kevätkääryleTurku@gmail.com', 'ma-su klo 10-20');
