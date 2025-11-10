# Inventory and Supplier Management System-MySQL
### 📚 Table of Contents

1. [Project Overview](#project-overview)
2. [Database Structure](#database-structure)
3. [Data Insertion](#data-insertion)
4. [Key Queries](#key-queries)
5. [Insights](#insights)
6. [Conclusion](#conclusion)

---

### Project Overview

---

A **MySQL-based Inventory and Supplier Management System** to manage **products**, **suppliers**, and **stock levels**. It tracks inventory, restock schedules, and supplier-product links. The system identifies low-stock items, products never restocked, and supplier-wise shortages, ensuring **efficient inventory monitoring** and **management**.


## Database Structure

The **Inventory and Supplier Management System** is built using a **relational database** model with **five main tables** being created, ensuring data consistency through **primary and foreign key constraints**.

### 1. Products

Stores details of each product in the system.

* **Primary Key:** `prodID`
* **Attributes:** `productName`, `prodtype`

### 2. Inventory

Tracks stock levels and minimum quantity thresholds.

* **Primary Key:** `Inventory_id`
* **Foreign Key:** `prodID` - `Products(prodID)`
* **Attributes:** `Quant_available`, `MinQuantity`

### 3. Suppliers

Contains information about product suppliers.

* **Primary Key:** `S_id`
* **Attributes:** `S_name`, `contact`

### 4. RestockSchedule

Manages upcoming and past restock activities.

* **Primary Key:** `scheduleID`
* **Foreign Key:** `prodID` - `Products(prodID)`
* **Attributes:** `restockdate`, `restockquantity`

### 5. ProdSupplier

Defines the **many-to-many relationship** between Products and Suppliers.

* **Primary Key:** (`prodID`, `S_id`)
* **Foreign Keys:**

  * `prodID` - `Products(prodID)`
  * `S_id` - `Suppliers(S_id)`



### Relationships Summary

* **Products - Inventory:** One-to-Many
* **Products - RestockSchedule:** One-to-Many
* **Products - Suppliers:** Many-to-Many (via `ProdSupplier`)
* **Suppliers - Products:** Many-to-Many



## Data Insertion

After creating the database and tables, sample data is inserted to simulate a real-world inventory and supplier setup. This data helps demonstrate stock levels, supplier relations, and restock schedules.

### Insert Statements

```sql
-- Insert products
INSERT INTO Products (productName, prodtype) VALUES
('smartphone', 'electronics'),
('marker', 'office stuff'),
('table chair', 'office stuff');

-- Insert suppliers
INSERT INTO Suppliers (S_name, contact) VALUES
('QuickTech Ltd', 'quick@tech.com'),
('OffSolutions Ltd', 'offsol@info.com');

-- Link products with suppliers
INSERT INTO ProdSupplier (prodID, S_id) VALUES
(1, 1),  -- smartphone supplied by QuickTech Ltd
(2, 2),  -- marker supplied by OffSolutions Ltd
(3, 2);  -- table chair also supplied by OffSolutions Ltd

-- Insert inventory details
INSERT INTO Inventory (prodID, Quant_available, MinQuantity) VALUES
(1, 80, 30),   -- smartphone: 80 in stock, min 30
(2, 40, 10),   -- marker: 40 in stock, min 10
(3, 130, 50);  -- table chair: 130 in stock, min 50

-- Insert restock schedule
INSERT INTO RestockSchedule (prodID, restockdate, restockquantity) VALUES
(1, '2025-03-01', 25),   -- Restocking smartphones
(2, '2025-02-25', 15);   -- Restocking markers
```

### Summary

* Products and suppliers are linked via the `ProdSupplier` table (many-to-many relationship).
* Inventory levels and restock schedules are predefined for test use.
* Data provides a solid base for testing queries like low stock detection and restock tracking.

## Key Queries

This section includes essential SQL queries used to **analyze and manage the inventory system** — from checking stock levels to tracking supplier performance.

### 1. Fetch Products That Need Restocking or Are Out of Stock

Find products with zero available quantity.

```sql
SELECT p.productName, i.Quant_available, i.MinQuantity
FROM Inventory i
JOIN Products p ON i.prodID = p.prodID
WHERE i.Quant_available = 0;
```

### 2. Fetch Restocking History for a Particular Product

View past or scheduled restocks for a given product.

```sql
SELECT p.productName, r.restockdate, r.restockquantity
FROM RestockSchedule r
JOIN Products p ON r.prodID = p.prodID
WHERE p.productName = 'smartphone';
```

### 3. Fetch Products That Were Never Restocked

Identify products without any restock records.

```sql
SELECT p.productName
FROM Products p
LEFT JOIN RestockSchedule r ON p.prodID = r.prodID
WHERE r.prodID IS NULL;
```



### 4. Fetch Suppliers for Products with Low Stock

List suppliers linked to items below their minimum quantity threshold.

```sql
SELECT p.productName, s.S_name, i.Quant_available
FROM Products p
JOIN Inventory i ON p.prodID = i.prodID
JOIN ProdSupplier ps ON i.prodID = ps.prodID
JOIN Suppliers s ON ps.S_id = s.S_id
WHERE i.Quant_available < i.MinQuantity;
```

### 5. Fetch the Number of Low-Stock Products per Supplier

Count how many of each supplier’s products are below minimum stock levels.

```sql
SELECT s.S_name, COUNT(ps.prodID) AS ProductLowStock
FROM Suppliers s
JOIN ProdSupplier ps ON s.S_id = ps.S_id
JOIN Inventory i ON ps.prodID = i.prodID
WHERE i.Quant_available < i.MinQuantity
GROUP BY s.S_name;
```



### Summary

* Queries help monitor **stock health**, **supplier performance**, and **restocking needs**.
* Supports **inventory decision-making** and **supply chain efficiency** through real-time insights.

## Insights

1. **Smartphone** and **Marker** are nearing or below their minimum stock levels, signaling the need for immediate restocking.
   
2. **Restock schedules** show planned replenishments for smartphones on *March 1, 2025* and markers on *February 25, 2025*.
 
3. **Table Chair** has never been restocked, indicating a possible supply gap or overstocked item.
 
4. **QuickTech Ltd** supplies high-demand electronics, while **OffSolutions Ltd** manages most office items.
 
5. **OffSolutions Ltd** has multiple products close to minimum quantity, highlighting the need for better supply management.

## Conclusion

The **Inventory and Supplier Management System** efficiently tracks products, suppliers, and restocking activities through a well-structured MySQL database. It ensures real-time visibility into stock levels, restock planning, and supplier performance, helping businesses maintain optimal inventory control and prevent stockouts.













