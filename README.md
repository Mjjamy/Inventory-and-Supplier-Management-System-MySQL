# Inventory and Supplier Management System-MySQL
### 📚 Table of Contents

1. [Project Overview](#project-overview)
2. [Database Structure](#database-structure)
3. [Tables Created](#tables-created)
4. [Data Insertion](#data-insertion)
5. [Key Queries](#key-queries)
6. [Insights & Reports](#insights--reports)
7. [Future Enhancements](#future-enhancements)
8. [Conclusion](#conclusion)

---

### Project Overview

---

A **MySQL-based Inventory and Supplier Management System** to manage **products**, **suppliers**, and **stock levels**. It tracks inventory, restock schedules, and supplier-product links. The system identifies low-stock items, products never restocked, and supplier-wise shortages, ensuring **efficient inventory monitoring** and **management**.


### Database Structure

The **Inventory and Supplier Management System** is built using a **relational database** model with **five main tables**, ensuring data consistency through **primary and foreign key constraints**.

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







