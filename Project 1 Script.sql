-- Project 1 (10%)			Due March 10th by 10pm

--  1. List the details for all orders for the customer named "Charlie" that contained sales for the item "Apples"
SELECT O.* FROM dbo.Customer C INNER JOIN dbo.Orders O
ON C.CustId = O.CustId INNER JOIN dbo.SaleItem S
ON O.OrderNo = S.OrderNo INNER JOIN dbo.Item I
ON S.ItemId = I.ItemId
WHERE C.CustName = 'Charlie' AND I.ItemDesc = 'Apples';

 -- 2. List the order no. for orders that have placed more than 2 sale items in 2022
SELECT O.OrderNo AS "Order No. For Orders over 2 Sale Items" FROM dbo.Orders O INNER JOIN dbo.SaleItem S
ON O.OrderNo = S.OrderNo
WHERE YEAR(O.OrderDate) = 2022 AND S.QtySold > 2;

--  3. List the customers details for customers who have placed  orders items in the "Fruit" (FR)  or "Vegetable" (VG) catgeory in 2022. Show each customer only once
SELECT DISTINCT C.* FROM dbo.Customer C INNER JOIN dbo.Orders O
ON C.CustId = O.CustId INNER JOIN dbo.SaleItem S
ON O.OrderNo = S.OrderNo INNER JOIN dbo.Item I
ON S.ItemId = I.ItemId
WHERE YEAR(O.OrderDate) = 2022
AND I.ItemCategory = 'FR' OR I.ItemCategory = 'VG';

--  4.  List the id , description and category of items where the QOH is less than the reorder level.  Sequence by item id within category
SELECT DISTINCT I.ItemId, I.ItemDesc, I.ItemCategory FROM dbo.Customer C INNER JOIN dbo.Orders O
ON C.CustId = O.CustId INNER JOIN dbo.SaleItem S
ON O.OrderNo = S.OrderNo INNER JOIN dbo.Item I
ON S.ItemId = I.ItemId
WHERE I.QtyOnHand < I.ReOrderLevel
ORDER BY I.ItemCategory, I.ItemId;

--  5.  List the details for the items that have been sold at a discount on any order (Where the sale price less than list price).
SELECT I.* FROM dbo.Customer C INNER JOIN dbo.Orders O
ON C.CustId = O.CustId INNER JOIN dbo.SaleItem S
ON O.OrderNo = S.OrderNo INNER JOIN dbo.Item I
ON S.ItemId = I.ItemId
WHERE S.SalePrice < I.ItemListPrice;

 -- 6.  List the details for all customers that have ordered items with characters "Bananas" anywhere in its description. 
SELECT C.* FROM dbo.Customer C INNER JOIN dbo.Orders O
ON C.CustId = O.CustId INNER JOIN dbo.SaleItem S
ON O.OrderNo = S.OrderNo INNER JOIN dbo.Item I
ON S.ItemId = I.ItemId
WHERE I.ItemDesc LIKE '%Bananas%';

 -- 7.  List the maximum quantity on hand for any item in the "Fruit" (FR) category
SELECT MAX(I.QtyOnHand) AS "Quantity on Hand" FROM dbo.Customer C INNER JOIN dbo.Orders O
ON C.CustId = O.CustId INNER JOIN dbo.SaleItem S
ON O.OrderNo = S.OrderNo INNER JOIN dbo.Item I
ON S.ItemId = I.ItemId
WHERE I.ItemCategory = 'FR';

--8. List the total quantity sold for the item with the description "Green Bananas" in Ontario in 2022
SELECT SUM(QtySold) AS "Total Qty of Green Bananas Sold in Ontario 2022" 
FROM dbo.SaleItem S INNER JOIN dbo.Item I
ON S.ItemId = I.ItemId INNER JOIN dbo.Orders O
ON S.OrderNo = O.OrderNo INNER JOIN dbo.Customer C
ON O.CustId = C.CustId
WHERE ItemDesc = 'Green Bananas' 
AND Prov = 'ON'
AND YEAR(OrderDate) = 2022;

--9. List the item details for all sold items in 2019 Sequence the output by item description. 
SELECT I. * FROM dbo.SaleItem S INNER JOIN dbo.Item I
ON S.ItemId = I.ItemId INNER JOIN dbo.Orders O
ON S.OrderNo = O.OrderNo
WHERE YEAR(OrderDate) = 2019
ORDER BY ItemDesc;

--10. Count the number of times an item in the vegetable (VG) category has appeared on an order in 2022
SELECT COUNT(ItemCategory) AS "# of times VG appeared on an order in 2022" 
FROM dbo.Item I INNER JOIN dbo.SaleItem S
ON S.ItemId = I.ItemId INNER JOIN dbo.Orders O
ON S.OrderNo = O.OrderNo
WHERE ItemCategory = 'VG'
AND YEAR(OrderDate) = 2022;

--11. Count the number of different item categories represented by sales in Quebec in August 2019
SELECT COUNT(DISTINCT ItemCategory) AS "Different item categories represented by sales in Quebec in August 2019"
FROM dbo.Item I INNER JOIN dbo.SaleItem S
ON S.ItemId = I.ItemId INNER JOIN dbo.Orders O
ON S.OrderNo = O.OrderNo INNER JOIN dbo.Customer C
ON O.CustId = C.CustId
WHERE Prov = 'QC'
AND YEAR(OrderDate) = 2019
AND MONTH(OrderDate) = 08;

--12. List the details for the customers that purchased the item "Broccoli" in 2022. Show each customer only once and sequence alphabetically by customer name
SELECT DISTINCT C. * FROM dbo.Customer C INNER JOIN dbo.Orders O
ON C.CustId = O.CustId INNER JOIN dbo.SaleItem S
ON O.OrderNo = S.OrderNo INNER JOIN dbo.Item I
ON S.ItemId = I.ItemId
WHERE ItemDesc = 'Broccoli'
AND YEAR(OrderDate) = 2022
ORDER BY C.CustName;

--13. List for each item by item id, the highest sale value (sale price * qty sold ) appearing on any order.
SELECT MAX(SalePrice * QtySold) AS "Highest Sale Value", ItemId FROM dbo.SaleItem
GROUP BY ItemId;

--14. List the total value of sales (sale price * qty sold) for each item category in 2022. Order the output by greatest value to lowest value --
SELECT ItemCategory AS "Category", 
SUM(SalePrice * QtySold) AS "Total Value From Sales" 
FROM dbo.SaleItem A
INNER JOIN dbo.item B ON A.ItemId = B.ItemId 
GROUP BY ItemCategory
ORDER BY SUM(SalePrice * QtySold) DESC;

--15. List the customer id for the Ontario customers that have placed  2 or more orders in 2022--
SELECT C.CustID FROM dbo.Customer C INNER JOIN 
dbo.Orders O ON C.CustId = O.CustId INNER JOIN
dbo.SaleItem S ON S.OrderNo = O.OrderNo 
WHERE YEAR(OrderDate) = 2022 AND Prov = 'ON'
GROUP BY C.CustId
HAVING COUNT(O.CustID) >= 2;

--16. List in alphabetic sequence by item description the details of any items ordered by the customer named "Jones".  Show each item only once
SELECT DISTINCT D.* FROM dbo.Item D INNER JOIN dbo.SaleItem S
ON D.ItemId = S.ItemId INNER JOIN dbo.Orders O 
ON S.OrderNo = O.OrderNo INNER JOIN dbo.Customer C
ON O.CustId = C.CustId 
WHERE CustName = 'Jones'
ORDER BY D.ItemDesc;

--17. List the customer details for those customers who have bought broccoli in 2022  and  who reside in either Ontario or Quebec--
SELECT C.* FROM dbo.Customer C INNER JOIN 
dbo.Orders O ON C.CustId = O.CustId INNER JOIN
dbo.SaleItem S ON S.OrderNo = O.OrderNo INNER JOIN
dbo.Item I ON S.ItemId = I.ItemId
WHERE ItemDesc LIKE 'Broccoli' AND (YEAR(O.OrderDate) = 2022 AND (Prov = 'ON' OR Prov = 'QC'));

-----18. Show by item id the total value (sale price * qty sold) for each sale item in August 2022 where that item appeared on at least 2 orders in that same time period--
SELECT A.ItemId, SUM(SalePrice * QtySold) AS "Total Value From Sales" FROM dbo.SaleItem A
INNER JOIN dbo.Orders O ON A.OrderNo = O.OrderNo
WHERE (OrderDate Between '2022/08/01' AND '2022/08/31')
GROUP BY A.ItemId
HAVING COUNT(A.ItemID) >= 2;

--19. List the total inventory value (item cost  * qty on hand ) for each item in the "VG" category --
SELECT SUM(ItemCost * QtyOnHand) AS "Total Inventory Value"  
FROM dbo.Item D
WHERE ItemCategory LIKE 'VG' 
GROUP BY ItemId;

--20. Write the following commands. I must be able to test run i), ii) and iii) below in sequence.--

--20 a). Add a new item to the database --
INSERT INTO dbo.Item
(ItemID, ItemDesc, ItemCategory, ItemListPrice, QtyOnHand, ReOrderLevel, ItemCost) 
VALUES ('999', 'popcorn', 'JF' , '5.99', '1000' , '1' ,'2.99');

--20 b). Update the qtyonhand by adding 50 new units (Use a formula. Don't directly hard code the new value)--
UPDATE dbo.Item
SET QtyOnHand = QtyOnHand + 50
WHERE ItemId = '999';

--20 c) Delete the item
DELETE dbo.Item
WHERE ItemId = '999';
