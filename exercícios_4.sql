use AMAZON;
-- 1
select * from USERS;
-- 2
select distinct ID, NAME from USERS order by NAME DESC;
-- 3
select * from USERS where EMAIL like "%@gmail%";
-- 4
select * from USERS where DATA_DE_NASCIMENTO > '2000-12-31' order by DATA_DE_NASCIMENTO ASC;
-- 5
select * from CATEGORIES;
-- 6
select * from PRODUCTS where PRICE >100;
-- 7
select * from PRODUCTS where PRICE between 50 and 200;
-- 8
select * from PRODUCTS order by PRICE DESC;
-- 9
select distinct CATEGORY_ID from PRODUCTS;
-- 10
select * from PRODUCTS where NAME like "A%" order by NAME asc;
-- 11
select * from ORDERS;
-- 12
select distinct USER_ID from ORDERS;
-- 13
select distinct ORDER_DATE from ORDERS order by ORDER_DATE desc;
-- 14
select * from ORDER_ITEMS where QUANTITY >1;
-- 15
select distinct PRODUCT_ID,QUANTITY from ORDER_ITEMS;
-- 16
select * from PRODUCT_REVIEWS where RATING >4;
-- 17
select distinct REVIEW_DATE from PRODUCT_REVIEWS;
-- 18
select * from PRODUCT_REVIEWS order by RATING desc;
-- 19
SELECT * FROM PRODUCT_REVIEWS 
WHERE PRODUCT_ID NOT IN (SELECT PRODUCT_ID 
    FROM PRODUCT_REVIEWS 
    WHERE RATING IS NULL
);

-- 20