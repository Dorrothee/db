CREATE DATABASE Cosmetics;

CREATE TABLE "Product" (
  "product_id" integer PRIMARY KEY,
  "brand_id" integer,
  "category_id" integer,
  "product_name" varchar,
  "product_type" varchar,
  "product_price" float
);

SELECT * FROM "Product";
DROP TABLE "Product";


CREATE TABLE "Brand" (
  "brand_id" SERIAL PRIMARY KEY,
  "brand_name" varchar,
  "brand_country" varchar
);

CREATE TABLE "Category" (
  "category_id" SERIAL PRIMARY KEY,
  "category_category" varchar
);

CREATE TABLE "Inventory" (
  "inventory_id" SERIAL PRIMARY KEY,
  "product_id" integer UNIQUE,
  "inventory_quantity" integer,
  "inventory_store" varchar
);

ALTER TABLE "Product" ADD FOREIGN KEY ("brand_id") REFERENCES "Brand" ("brand_id");

ALTER TABLE "Product" ADD FOREIGN KEY ("category_id") REFERENCES "Category" ("category_id");

ALTER TABLE "Product" ADD FOREIGN KEY ("product_id") REFERENCES "Inventory" ("product_id");


INSERT INTO "Brand" ("brand_name", "brand_country")
VALUES
  ('Patricia Ledo', 'France'),
  ('Maybelline', 'USA'),
  ('Holika Holika', 'Korea');

INSERT INTO "Category" ("category_category")
VALUES
  ('Lips'),
  ('Eyes'),
  ('Hair'),
  ('Skincare');

INSERT INTO "Inventory" ("product_id", "inventory_quantity", "inventory_store")
VALUES
  (1, 200, 'Lavina'),
  (2, 100, 'Stone Road');

INSERT INTO "Product" ("brand_id", "category_id", "product_name", "product_type", "product_price", "product_id")
VALUES
  (1, 1, 'Permanent mechanical lip pencil Patricia Ledo Lip Liner with a sharpener, tone 00, 0.4 g', 'Lip Liner', 2.64, 1),
  (3, 4, 'Aloe gel Holika Holika Aloe 99% Soothing Gel soothing, moisturizing, 55 ml', 'Soothing Gel', 2.38, 2);
