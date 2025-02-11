# Data Flow Diagram (Context Level)

## Context
This Data Flow Diagram (DFD) represents the high-level flow of data involved in the customer purchasing process on Shopping. The system interacts with external entities like customers, payment gateways, and shipping providers, and processes data through the central Shopping system.

## Entities and Processes
1. **Customer**
   - Inputs: Search queries, product selection, payment details.
   - Outputs: Order confirmation, product shipment details.

2. **Shopping System**
   - **Processes:**
     - Product Search & Recommendation
     - Order Placement
     - Payment Processing
     - Inventory Management
     - Shipping Coordination
   - **Data Stores:**
     - Product Catalog
     - Customer Database
     - Order Database
     - Inventory Database

3. **Payment Gateway**
   - Inputs: Payment details from Shopping.
   - Outputs: Payment approval/rejection.

4. **Shipping Provider**
   - Inputs: Shipment request and address details.
   - Outputs: Tracking number, delivery status.

## DFD Context-Level Diagram Description

```plaintext
           +--------------------+
           |     Customer       |
           +--------------------+
                  |   (Search, Place Order)
                  v
           +--------------------+
           |   Shopping System    |
           +--------------------+
            |        |      |
            v        v      v
    +------------+ +----------------+ +----------------+
    | Payment    | | Inventory       | | Shipping       |
    | Gateway    | | Management      | | Provider       |
    +------------+ +----------------+ +----------------+
