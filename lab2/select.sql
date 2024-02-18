--1-4 Select first 20 records from our database's tables (1-4)
SELECT * FROM "Brand" LIMIT 20;
SELECT * FROM "Category" LIMIT 20;
SELECT * FROM "Inventory" LIMIT 20;
SELECT * FROM "Product" LIMIT 20;

--5 Select first 20 records of brand_country column from "Brand" table
SELECT brand_country
FROM "Brand"
LIMIT 20;

--6 Count USA brands
SELECT COUNT(*) AS usa_brand
FROM "Brand"
WHERE brand_country LIKE 'USA';

--7 Count each country brands
SELECT brand_country, COUNT(*) AS brands
FROM "Brand"
GROUP BY brand_country
ORDER BY brands ASC;

--8 Select category what starts with "Face"
SELECT category_category
FROM "Category"
WHERE category_category LIKE 'Face%';

--9 Select category what starts with "Eye"
SELECT category_category
FROM "Category"
WHERE category_category LIKE 'Eye%';

--10 Select all possible Asian brands (Korean and Japaneese)
SELECT brand_name
FROM "Brand"
WHERE brand_country IN ('Korea', 'Japan');

--11 Count sum amount of products from stores
SELECT SUM(inventory_quantity)
FROM "Inventory";

--12 Count amount of products for each store
SELECT inventory_store, COUNT(*) AS products
FROM "Inventory"
GROUP BY inventory_store
ORDER BY inventory_store ASC;

--13 Select stores where amount of products served at equals 5
SELECT inventory_store
FROM "Inventory"
GROUP BY inventory_store
HAVING COUNT(*) = 5
ORDER BY inventory_store ASC;

--14 Select stores which contain "Plaza" in the end
SELECT inventory_store
FROM "Inventory"
WHERE inventory_store LIKE '%Plaza';

--15 Select unique stores which contain Plaza in the end
SELECT DISTINCT inventory_store
FROM "Inventory"
WHERE inventory_store LIKE '%Plaza';

--16 Select all products in ascending order of price 
SELECT product_price, product_name
FROM "Product"
ORDER BY product_price;

--17 Find the max price of products
SELECT product_price, product_name
FROM "Product"
WHERE product_price = (SELECT MAX(product_price) FROM "Product");

--18 Find the min price of products
SELECT product_price, product_name
FROM "Product"
WHERE product_price = (SELECT MIN(product_price) FROM "Product");

--19 Find the avg price of Lip Gloss products
SELECT AVG(product_price) AS average_price, product_type
FROM "Product"
WHERE product_type = 'Lip Gloss'
GROUP BY product_type;

--20 Find products with price 18.95-28
SELECT product_price, product_name
FROM "Product"
WHERE product_price >= 18.95 AND product_price < 28
ORDER BY product_price;

--21 Products which are Clinique brand
SELECT p.product_name
FROM "Brand" b
JOIN "Product" p ON b.brand_id = p.brand_id
Where b.brand_name = 'Clinique'
GROUP BY p.product_name;

--22 Find the amount of products which are Clinique brand (to verify previous select)
SELECT DISTINCT product_name, COUNT(*) AS products
FROM "Product"
WHERE brand_id = 13
GROUP BY product_name
ORDER BY product_name ASC;

--23 Select products quantity of which is more than 180
SELECT p.product_name, i.inventory_quantity
FROM "Inventory" i
JOIN "Product" p USING (product_id)
GROUP BY p.product_name, i.inventory_quantity
HAVING i.inventory_quantity > 180
ORDER BY i.inventory_quantity;

--24 Select stores which have Lip Balm products
SELECT i.inventory_store
FROM "Product" p
JOIN "Inventory" i USING (product_id)
JOIN "Category" c USING (category_id)
WHERE c.category_category = 'Lip Balm';

--25 Select stores which have Lip Balm products and according to its quantity find the total price for it
SELECT i.inventory_store, CAST(SUM(p.product_price * i.inventory_quantity) AS DECIMAL(10,2)) AS total_price
FROM "Product" p
JOIN "Inventory" i USING (product_id)
JOIN "Category" c USING (category_id)
WHERE c.category_category = 'Lip Balm'
GROUP BY p.product_price, i.inventory_store;

--26 Select categories of products for Charlotte Tilbury brand
SELECT c.category_category
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Category" c USING (category_id)
WHERE b.brand_name = 'Charlotte Tilbury';

--27 Select brands and types of products originated from Japan
SELECT b.brand_name, c.category_category
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Category" c USING (category_id)
WHERE b.brand_country = 'Japan'
ORDER BY b.brand_name;

--28 Find the most expensive product among Korean brands and categories
SELECT b.brand_name, c.category_category, p.product_name, p.product_price
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Category" c USING (category_id)
WHERE b.brand_country = 'South Korea'
  AND p.product_price = (SELECT MAX(product_price) FROM "Product" WHERE brand_id IN (SELECT brand_id FROM "Brand" WHERE brand_country = 'South Korea'));

--29 Find the least expensive product among Korean brands and categories
SELECT b.brand_name, c.category_category, p.product_name, p.product_price
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Category" c USING (category_id)
WHERE b.brand_country = 'South Korea'
  AND p.product_price = (SELECT MIN(product_price) FROM "Product" WHERE brand_id IN (SELECT brand_id FROM "Brand" WHERE brand_country = 'South Korea'));

--30 Select stores which serve Italian products
SELECT i.inventory_store
FROM "Product" p
JOIN "Inventory" i USING (product_id)
JOIN "Brand" b USING (brand_id)
WHERE b.brand_country = 'Italy';

--31 Select stores which serve Kylie Cosmetics products
SELECT i.inventory_store
FROM "Product" p
JOIN "Inventory" i USING (product_id)
JOIN "Brand" b USING (brand_id)
WHERE b.brand_name = 'Kylie Cosmetics';

--32 Select brands and products originated from United Kingdom
SELECT b.brand_name, p.product_name, i.inventory_quantity
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Inventory" i USING (product_id)
WHERE b.brand_country LIKE 'United Kingdom'
ORDER BY b.brand_name;

--33 Select all info about products that cost < 20 
SELECT b.brand_name, p.product_name, p.product_type, i.inventory_quantity
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Inventory" i USING (product_id)
WHERE p.product_price < 20
ORDER BY b.brand_name;

--34 Select all info about products from stores (esp price)
SELECT b.brand_name, p.product_name, SUM(i.inventory_quantity * p.product_price) AS total_inventory_value
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Inventory" i USING (product_id)
GROUP BY b.brand_name, p.product_name;

--35 Select all records (first 20) from Reviews table
SELECT * FROM "Reviews" LIMIT 20;

--36 Select users whose reviews are 5s
SELECT username
FROM "Reviews"
Where rating = 5
ORDER BY username ASC;

--37 Select unique usernames whose reviews are 1s
SELECT DISTINCT username
FROM "Reviews"
Where rating = 1
ORDER BY username ASC;

--38 Count amount for reviews
SELECT rating, COUNT(*) AS reviews
FROM "Reviews"
GROUP BY rating
ORDER BY rating ASC;

--39 Count approved reviews
SELECT "status", COUNT(*)
FROM "Reviews"
WHERE "status" = 'approved'
GROUP BY "status";

--40 Count pending reviews
SELECT "status", COUNT(*)
FROM "Reviews"
WHERE "status" = 'pending'
GROUP BY "status";

--41 Select the last added review
SELECT username, rating, "date"
FROM "Reviews"
ORDER BY "date" DESC
LIMIT 1;

--42 Select the first added review
SELECT username, rating, "date"
FROM "Reviews"
ORDER BY "date" ASC
LIMIT 1;

--43 Select reviews posted during January
SELECT *
FROM "Reviews"
WHERE date BETWEEN '2024-01-01' AND '2024-01-31';

--44 Select reviews posted during January which have approved status
SELECT *
FROM "Reviews"
WHERE date BETWEEN '2024-01-01' AND '2024-01-31' AND "status" = 'approved';

--45 Select reviews posted during January which have pending status
SELECT *
FROM "Reviews"
WHERE date BETWEEN '2024-01-01' AND '2024-01-31' AND "status" = 'pending';

--46 Select the average rating for each user
SELECT username, CAST(AVG(rating) AS DECIMAL (10,0)) AS average_rating
FROM "Reviews"
GROUP BY username
ORDER BY username ASC;

--47 Select the max rating for each user
SELECT username, MAX(rating) AS max_rating
FROM "Reviews"
GROUP BY username
ORDER BY username ASC;

--48 Select the min rating for each user
SELECT username, MIN(rating) AS max_rating
FROM "Reviews"
GROUP BY username
ORDER BY username ASC;

--49 Find the amount of approved ranked 5 reviews during January
SELECT COUNT(*) AS approved_reviews_with_5
FROM "Reviews"
WHERE rating = 5 AND "status" = 'approved' AND EXTRACT(MONTH FROM "date") = 1;

--50 Find the amount of approved ranked 2 or 3 reviews during January
SELECT COUNT(*) AS approved_reviews_with_2_or_3
FROM "Reviews"
WHERE (rating = 2 OR rating = 3) AND "status" = 'approved' AND EXTRACT(MONTH FROM "date") = 1;

--51 Select brands ranked 5 reviews
SELECT DISTINCT b.brand_name
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE r.rating = 5;

--52 Select brands ranked 1 reviews
SELECT DISTINCT b.brand_name
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE r.rating = 1;

--53 Find what brand got the majority of approved ranked 5 reviews
SELECT b.brand_name, COUNT(*) AS num_of_5_star_reviews
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE r.rating = 5 AND r.status = 'approved'
GROUP BY b.brand_name
ORDER BY num_of_5_star_reviews DESC
LIMIT 1;

--54 Count what brands got approved ranked 5 reviews (to verify previous select)
SELECT b.brand_name, COUNT(*) AS num_of_5_star_reviews
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE r.rating = 5 AND r.status = 'approved'
GROUP BY b.brand_name
ORDER BY num_of_5_star_reviews DESC;

--55 Count what country brands got ranked 5 reviews
SELECT b.brand_country, COUNT(*) AS num_of_5_star_reviews
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE r.rating = 5 AND r.status = 'approved'
GROUP BY b.brand_country
ORDER BY num_of_5_star_reviews DESC
LIMIT 1;

--56 Select brands ranked 5 reviews during 2023
SELECT b.brand_name, COUNT(*) AS num_of_5_star_reviews_in_2023
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE rating = 5 AND EXTRACT(YEAR FROM r.date) = 2023
GROUP BY b.brand_name;

--57 Select brand with the biggest amount of reviews during 2023
SELECT b.brand_name, COUNT(*) AS review_count
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE EXTRACT(YEAR FROM r.date) = 2023
GROUP BY b.brand_name
ORDER BY review_count DESC
LIMIT 1;

--58 Select brand with the smallest amount of reviews during 2023
SELECT b.brand_name, COUNT(*) AS review_count
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE EXTRACT(YEAR FROM r.date) = 2023
GROUP BY b.brand_name
ORDER BY review_count ASC
LIMIT 1;

--59 Select categories rated 5
SELECT DISTINCT c.category_category
FROM "Category" c
JOIN "Product" p USING (category_id)
JOIN "Reviews" r USING (product_id)
WHERE r.rating = 5;

--60 Select categories rated 1
SELECT DISTINCT c.category_category
FROM "Category" c
JOIN "Product" p USING (category_id)
JOIN "Reviews" r USING (product_id)
WHERE r.rating = 1;

--61 Select category with the biggest amount of reviews
SELECT c.category_category, COUNT(*) AS review_count
FROM "Product" p
JOIN "Category" c USING (category_id)
JOIN "Reviews" r USING (product_id)
GROUP BY c.category_category
ORDER BY review_count DESC
LIMIT 1;

--62 Select category with the smallest amount of reviews
SELECT c.category_category, COUNT(*) AS review_count
FROM "Product" p
JOIN "Category" c USING (category_id)
JOIN "Reviews" r USING (product_id)
GROUP BY c.category_category
ORDER BY review_count ASC
LIMIT 1;

--63 Select categories reviewed by MusicLover user
SELECT c.category_category
FROM "Category" c
JOIN "Product" p USING (category_id)
JOIN "Reviews" r USING (product_id)
WHERE r.username = 'MusicLover';

--64 Select categories reviewed by MusicLover user and rated 5
SELECT c.category_category
FROM "Category" c
JOIN "Product" p USING (category_id)
JOIN "Reviews" r USING (product_id)
WHERE r.username = 'MusicLover' AND r.rating = 5;

--65 Select categories reviewed by MusicLover user and rated 1
SELECT c.category_category
FROM "Category" c
JOIN "Product" p USING (category_id)
JOIN "Reviews" r USING (product_id)
WHERE r.username = 'MusicLover' AND r.rating = 1;

--66 Select users who reviewed Face Mask category
SELECT r.username
FROM "Category" c
JOIN "Product" p USING (category_id)
JOIN "Reviews" r USING (product_id)
WHERE c.category_category = 'Face Mask';

--67 Select users who reviewed Face Mask category with 5s
SELECT r.username
FROM "Category" c
JOIN "Product" p USING (category_id)
JOIN "Reviews" r USING (product_id)
WHERE c.category_category = 'Face Mask' AND r.rating = 5;

--68 Select the most popular product with the highest avg rating
SELECT p.product_name, avg_rating.average_rating
FROM "Product" p
JOIN (
    SELECT product_id, CAST(AVG(rating) AS DECIMAL(10, 0)) AS average_rating
    FROM "Reviews"
    GROUP BY product_id
) avg_rating ON p.product_id = avg_rating.product_id
ORDER BY avg_rating.average_rating DESC
LIMIT 1;

--69 Select the least popular product with the lowest avg rating
SELECT p.product_name, avg_rating.average_rating
FROM "Product" p
JOIN (
    SELECT product_id, CAST(AVG(rating) AS DECIMAL(10, 0)) AS average_rating
    FROM "Reviews"
    GROUP BY product_id
) avg_rating ON p.product_id = avg_rating.product_id
ORDER BY avg_rating.average_rating ASC
LIMIT 1;

--70 Find inventory info about products rated 5
SELECT p.product_name, i.inventory_store, i.inventory_quantity
FROM "Product" p
JOIN "Reviews" r USING (product_id)
JOIN "Inventory" i USING (product_id)
JOIN "Category" c USING (category_id)
WHERE r.rating = 5
GROUP BY p.product_name, i.inventory_store, i.inventory_quantity;

--71 Find inventory info about products rated 1
SELECT p.product_name, i.inventory_store, i.inventory_quantity
FROM "Product" p
JOIN "Reviews" r USING (product_id)
JOIN "Inventory" i USING (product_id)
JOIN "Category" c USING (category_id)
WHERE r.rating = 1
GROUP BY p.product_name, i.inventory_store, i.inventory_quantity;

--72 Find info about the most popular product with the highest avg rating
SELECT p.product_name, i.inventory_store, i.inventory_quantity, avg_rating.average_rating
FROM "Product" p
JOIN "Inventory" i USING (product_id)
JOIN (
    SELECT product_id, CAST(AVG(rating) AS DECIMAL(10, 0)) AS average_rating
    FROM "Reviews"
    GROUP BY product_id
) avg_rating ON p.product_id = avg_rating.product_id
JOIN "Category" c USING (category_id)
ORDER BY avg_rating.average_rating DESC
LIMIT 1;

--73 Find info about the least popular product with the least avg rating
SELECT p.product_name, i.inventory_store, i.inventory_quantity, avg_rating.average_rating
FROM "Product" p
JOIN "Inventory" i USING (product_id)
JOIN (
    SELECT product_id, CAST(AVG(rating) AS DECIMAL(10, 0)) AS average_rating
    FROM "Reviews"
    GROUP BY product_id
) avg_rating ON p.product_id = avg_rating.product_id
JOIN "Category" c USING (category_id)
ORDER BY avg_rating.average_rating ASC
LIMIT 1;

--74 Find info (price and rating) about Lip Gloss products
SELECT p.product_name, p.product_price, r.rating
FROM "Product" p
JOIN "Reviews" r USING (product_id)
WHERE p.product_type = 'Lip Gloss'
GROUP BY p.product_name, p.product_price, r.rating
ORDER BY r.rating;

--75 Find Lip Gloss products with price > 10
SELECT p.product_name, p.product_price, r.rating
FROM "Product" p
JOIN "Reviews" r USING (product_id)
WHERE p.product_type = 'Lip Gloss'
GROUP BY p.product_name, p.product_price, r.rating
HAVING p.product_price > 10
ORDER BY r.rating;

--76 Find amount of reviews for each user
SELECT username, COUNT(*) AS reviews_count
FROM "Reviews"
GROUP BY username
ORDER BY reviews_count DESC;

--77 Select brands reviewed by MusicLover user
SELECT b.brand_name
FROM "Brand" b
JOIN "Product" p USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE r.username = 'MusicLover';

--78 Select brands reviewed by MusicLover user and rated 5
SELECT b.brand_name
FROM "Brand" b
JOIN "Product" p USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE r.username = 'MusicLover' AND r.rating = 5;

--79 Select categories reviewed by MusicLover user and rated 1
SELECT b.brand_name
FROM "Brand" b
JOIN "Product" p USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE r.username = 'MusicLover' AND r.rating = 1;

--80 Select users who reviewed The Face Shop brand
SELECT r.username
FROM "Brand" b
JOIN "Product" p USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE b.brand_name = 'The Face Shop';

--81 Select users who reviewed The Face Shop brand with 5s
SELECT r.username
FROM "Brand" b
JOIN "Product" p USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE b.brand_name = 'The Face Shop' AND r.rating = 5;

--82 Select users who reviewed The Face Shop brand and find info about its products
SELECT r.username, p.product_name, p.product_price, p.product_type
FROM "Brand" b
JOIN "Product" p USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE b.brand_name = 'The Face Shop';

--83 Select users whose names strat with "A" and reviews are 5
SELECT *
FROM "Reviews"
WHERE rating = 5 AND username LIKE 'A%';

--84 Select users whose names end with "Lover" and reviews are 5
SELECT *
FROM "Reviews"
WHERE rating = 5 AND username LIKE '%Lover'
ORDER BY "date";

--85 Select products that aren't reviewed with 1
SELECT *
FROM "Product" p
JOIN "Reviews" r USING (product_id)
WHERE r.rating != 1;

--86 Find countries that have more than 3 brands
SELECT brand_country, COUNT(*) as brands_amount
FROM "Brand"
GROUP BY brand_country
HAVING COUNT(*) > 3;

--87 Find countries types of products
SELECT b.brand_country, c.category_category
FROM "Brand" b
JOIN "Product" p USING (brand_id)
JOIN "Category" c USING (category_id)
GROUP BY b.brand_country, c.category_category
ORDER BY b.brand_country;

--88 Find the amount of ranked 4 reviews for each user
SELECT COUNT(*) AS reviews_with_4, username
FROM "Reviews"
WHERE rating = 4
GROUP BY username
ORDER BY username;

--89 Find the amount of ranked 4 reviews and select brands
SELECT COUNT(*) AS reviews_with_4, b.brand_name
FROM "Reviews" r
JOIN "Product" p USING (product_id)
JOIN "Brand" b USING (brand_id)
WHERE r.rating = 4
GROUP BY b.brand_name
ORDER BY b.brand_name;

--90 Find which country has the majority of brands reviewed with 4
SELECT b.brand_country, COUNT(DISTINCT b.brand_id) AS brands_count
FROM "Brand" b
JOIN "Product" p USING (brand_id)
JOIN "Reviews" r USING (product_id)
WHERE r.rating = 4
GROUP BY b.brand_country
ORDER BY brands_count DESC
LIMIT 1;

--91 Find total inventory value for brands products that are reviewed with 4
SELECT b.brand_name, p.product_name, SUM(i.inventory_quantity * p.product_price) AS total_inventory_value
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Inventory" i USING (product_id)
JOIN "Reviews" r USING (product_id)
WHERE r.rating = 4
GROUP BY b.brand_name, p.product_name
ORDER BY b.brand_name;

--92 Find total inventory value for brands products that are reviewed with 1
SELECT b.brand_name, p.product_name, SUM(i.inventory_quantity * p.product_price) AS total_inventory_value
FROM "Product" p
JOIN "Brand" b USING (brand_id)
JOIN "Inventory" i USING (product_id)
JOIN "Reviews" r USING (product_id)
WHERE r.rating = 1
GROUP BY b.brand_name, p.product_name
ORDER BY b.brand_name;

--93 Count amount of reviews for each month of the year
SELECT EXTRACT(YEAR FROM "date") AS review_year, EXTRACT(MONTH FROM "date") AS review_month, COUNT(*) AS reviews_amount
FROM "Reviews"
GROUP BY review_year, review_month
ORDER BY review_year, review_month;

--94 Select the average rating for each category
SELECT c.category_category, CAST(AVG(r.rating) AS DECIMAL(10, 0)) AS average_rating
FROM "Reviews" r
JOIN "Product" p USING (product_id)
JOIN "Category" c USING (category_id)
GROUP BY c.category_category
ORDER BY average_rating;

--95 Find top 3 countries by the amount of reviews
SELECT b.brand_country, COUNT(*) AS reviews_amount
FROM "Brand" b
JOIN "Product" p USING (brand_id)
JOIN "Reviews" r USING (product_id)
GROUP BY b.brand_country
ORDER BY reviews_amount DESC
LIMIT 3;

--96 Find last 3 countries by the amount of reviews
SELECT b.brand_country, COUNT(*) AS reviews_amount
FROM "Brand" b
JOIN "Product" p USING (brand_id)
JOIN "Reviews" r USING (product_id)
GROUP BY b.brand_country
ORDER BY reviews_amount ASC
LIMIT 3;

--97 Select category with the biggest amount of reviews
SELECT c.category_category, COUNT(*) AS reviews_amount
FROM "Product" p
JOIN "Category" c USING (category_id)
JOIN "Reviews" r USING (product_id)
GROUP BY c.category_category
ORDER BY reviews_amount DESC
LIMIT 1;

--98 Select category with the biggest amount of reviews and find the most expensive product
SELECT c.category_category, COUNT(*) AS reviews_amount, MAX(p.product_price) AS max_price
FROM "Product" p
JOIN "Category" c USING (category_id)
JOIN "Reviews" r USING (product_id)
WHERE c.category_category = (
    SELECT c.category_category
    FROM "Product" p
    JOIN "Category" c USING (category_id)
    JOIN "Reviews" r USING (product_id)
    GROUP BY c.category_category
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
GROUP BY c.category_category;

--99 Find the most expensive product
SELECT product_type, product_name, product_price
FROM "Product"
WHERE product_price = (
    SELECT MAX(product_price)
    FROM "Product"
);

--100 Select users who reviewed South Korea Hair products
SELECT r.username, c.category_category, COUNT(r.username) as users
FROM "Reviews" r
JOIN "Product" p USING (product_id)
JOIN "Category" c USING (category_id)
JOIN "Brand" b USING (brand_id)
WHERE c.category_category LIKE 'Hair%' AND b.brand_country = 'South Korea'
GROUP BY r.username, c.category_category;