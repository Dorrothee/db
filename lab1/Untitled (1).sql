CREATE TABLE "Product" (
  "product_id" integer PRIMARY KEY,
  "brand_id" integer,
  "category_id" integer,
  "product_name" varchar,
  "product_type" varchar,
  "product_price" integer
);

CREATE TABLE "Brand" (
  "brand_id" integer PRIMARY KEY,
  "brand_name" varchar,
  "brand_country" varchar
);

CREATE TABLE "Category" (
  "category_id" integer PRIMARY KEY,
  "category_category" varchar
);

CREATE TABLE "Inventory" (
  "inventory_id" integer PRIMARY KEY,
  "product_id" integer,
  "inventory_quantity" integer,
  "inventory_store" varchar
);

ALTER TABLE "Product" ADD FOREIGN KEY ("brand_id") REFERENCES "Brand" ("brand_id");

ALTER TABLE "Product" ADD FOREIGN KEY ("category_id") REFERENCES "Category" ("category_id");

ALTER TABLE "Product" ADD FOREIGN KEY ("product_id") REFERENCES "Inventory" ("product_id");
