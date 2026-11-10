
CREATE TABLE Service_types (
                service_type_id INT AUTO_INCREMENT NOT NULL,
                service_name VARCHAR(30) NOT NULL,
                PRIMARY KEY (service_type_id)
);


CREATE TABLE Categories (
                category_id INT AUTO_INCREMENT NOT NULL,
                category_name VARCHAR(30) NOT NULL,
                PRIMARY KEY (category_id)
);


CREATE TABLE Manufacturers (
                manufacturer_id INT AUTO_INCREMENT NOT NULL,
                manufacturer_name VARCHAR(30) NOT NULL,
                country VARCHAR(30) NOT NULL,
                PRIMARY KEY (manufacturer_id)
);


CREATE TABLE Parts (
                part_id INT AUTO_INCREMENT NOT NULL,
                manufacturer_id INT NOT NULL,
                category_id INT NOT NULL,
                part_name VARCHAR(100) NOT NULL,
                price INT NOT NULL,
                image_url VARCHAR(255) NOT NULL,
                stock_quantity INT DEFAULT 0 NOT NULL,
                PRIMARY KEY (part_id)
);


CREATE TABLE Brands (
                brand_id INT AUTO_INCREMENT NOT NULL,
                brand_name VARCHAR(15) NOT NULL,
                country VARCHAR(30) NOT NULL,
                PRIMARY KEY (brand_id)
);


CREATE TABLE Motorcycle_models (
                model_id INT AUTO_INCREMENT NOT NULL,
                brand_id INT NOT NULL,
                model_name VARCHAR(30) NOT NULL,
                released_yr INT NOT NULL,
                PRIMARY KEY (model_id)
);


CREATE TABLE Part_fitments (
                part_id INT NOT NULL,
                model_id INT NOT NULL,
                PRIMARY KEY (part_id, model_id)
);


CREATE TABLE Users (
                user_id INT AUTO_INCREMENT NOT NULL,
                user_name VARCHAR(30) NOT NULL,
                user_pwd_hash VARCHAR(255) NOT NULL,
                email VARCHAR(50) NOT NULL,
                phone VARCHAR(15) NOT NULL,
                role VARCHAR(20) DEFAULT 'customer' NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
                PRIMARY KEY (user_id)
);


CREATE UNIQUE INDEX users_idx
 ON Users
 ( email );

CREATE TABLE Favorites (
                user_id INT NOT NULL,
                part_id INT NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
                PRIMARY KEY (user_id, part_id)
);


CREATE TABLE Orders (
                order_id INT AUTO_INCREMENT NOT NULL,
                user_id INT NOT NULL,
                order_status VARCHAR(10) DEFAULT 'pending' NOT NULL,
                total_amount INT NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
                PRIMARY KEY (order_id)
);


CREATE TABLE Order_items (
                order_id INT NOT NULL,
                part_id INT NOT NULL,
                quantity INT NOT NULL,
                unit_price INT NOT NULL,
                PRIMARY KEY (order_id, part_id)
);


CREATE TABLE User_vehicles (
                vehicle_id INT AUTO_INCREMENT NOT NULL,
                user_id INT NOT NULL,
                model_id INT NOT NULL,
                nickname VARCHAR(30),
                plate_number VARCHAR(8),
                purchase_date DATE NOT NULL,
                PRIMARY KEY (vehicle_id)
);


CREATE TABLE Maintenance_records (
                record_id INT AUTO_INCREMENT NOT NULL,
                vehicle_id INT NOT NULL,
                service_date DATE NOT NULL,
                total_price INT NOT NULL,
                mileage INT NOT NULL,
                PRIMARY KEY (record_id)
);


CREATE TABLE Maintenance_items (
                item_id INT AUTO_INCREMENT NOT NULL,
                record_id INT NOT NULL,
                service_type_id INT NOT NULL,
                cost INT NOT NULL,
                part_id INT NOT NULL,
                PRIMARY KEY (item_id)
);


CREATE TABLE Reviews (
                review_id INT AUTO_INCREMENT NOT NULL,
                user_id INT NOT NULL,
                part_id INT NOT NULL,
                rating DECIMAL(2,1) NOT NULL,
                review_text VARCHAR(300) NOT NULL,
                created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
                PRIMARY KEY (review_id)
);


CREATE UNIQUE INDEX reviews_idx
 ON Reviews
 ( user_id, part_id );

ALTER TABLE Maintenance_items ADD CONSTRAINT service_type_maintenance_items_fk
FOREIGN KEY (service_type_id)
REFERENCES Service_types (service_type_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Parts ADD CONSTRAINT categories_parts_fk
FOREIGN KEY (category_id)
REFERENCES Categories (category_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Parts ADD CONSTRAINT manufacturers_parts_fk
FOREIGN KEY (manufacturer_id)
REFERENCES Manufacturers (manufacturer_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Reviews ADD CONSTRAINT parts_reviews_fk
FOREIGN KEY (part_id)
REFERENCES Parts (part_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Part_fitments ADD CONSTRAINT parts_part_fitments_fk
FOREIGN KEY (part_id)
REFERENCES Parts (part_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Order_items ADD CONSTRAINT parts_order_items_fk
FOREIGN KEY (part_id)
REFERENCES Parts (part_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Favorites ADD CONSTRAINT parts_favorites_fk
FOREIGN KEY (part_id)
REFERENCES Parts (part_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Maintenance_items ADD CONSTRAINT parts_maintenance_items_fk
FOREIGN KEY (part_id)
REFERENCES Parts (part_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Motorcycle_models ADD CONSTRAINT brands_motorcycle_models_fk
FOREIGN KEY (brand_id)
REFERENCES Brands (brand_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE User_vehicles ADD CONSTRAINT motorcycle_models_user_vehicles_fk
FOREIGN KEY (model_id)
REFERENCES Motorcycle_models (model_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Part_fitments ADD CONSTRAINT motorcycle_models_part_fitments_fk
FOREIGN KEY (model_id)
REFERENCES Motorcycle_models (model_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Reviews ADD CONSTRAINT users_reviews_fk
FOREIGN KEY (user_id)
REFERENCES Users (user_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE User_vehicles ADD CONSTRAINT users_user_vehicles_fk
FOREIGN KEY (user_id)
REFERENCES Users (user_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Orders ADD CONSTRAINT users_orders_fk
FOREIGN KEY (user_id)
REFERENCES Users (user_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Favorites ADD CONSTRAINT users_favorites_fk
FOREIGN KEY (user_id)
REFERENCES Users (user_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Order_items ADD CONSTRAINT orders_order_items_fk
FOREIGN KEY (order_id)
REFERENCES Orders (order_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Maintenance_records ADD CONSTRAINT user_vehicles_maintenance_records_fk
FOREIGN KEY (vehicle_id)
REFERENCES User_vehicles (vehicle_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Maintenance_items ADD CONSTRAINT maintenance_records_maintenance_items_fk
FOREIGN KEY (record_id)
REFERENCES Maintenance_records (record_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
