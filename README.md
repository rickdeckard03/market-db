# University DB Project - ‘Market’

This is a university-level project regarding the organization and management of a online marketplace database, developed for the course of Database Laboratory course at the University of L’Aquila. The project provides a simple and basic framework for a system designed to support internal procurement for a public organization and controlling the buying process.

## Table of Contents
* [Functional Requirements](#functional-requirements)
* [Entity List and Description](#entity-list-and-description)
* [Others](#others)

## Functional Requirements

+ The system works with a collaborative model between three entities: orderers, engineers and administrator. For each user, are recorded name, surname, email, role and other informations for traceability.  
+ The system keeps a category catalog, and for each category there are specific characteristics.  
+ Purchase requests are created from orderers by a specific form. When is created, the order is in 'waiting' until a technician is assigned. After that, the request can assume different states.  
+ The requests can receive information about the product.  
+ The orderers, after they receive the product, they have to close the request by indicating the outcome.

## Entity List and Description

| Name entities | Description |
| ----- | ----- |
| User | Generic user of the system, distinguishable by role (orderer, technician, administrator). |
| Category | Specific product type. |
| Caratteristic | Category-specific property. |
| Purchase request | Purchase request expressed by a customer for a specific product category. |
| Feature Value | Specific value assigned to a feature within a request. |
| Candidate product | Prodotto concreto proposto da un tecnico come possibile soluzione a una richiesta. |

## Others

Administrators manage user registration, while Requesters create purchase requests. Only Technicians can be assigned to manage these requests, ensuring a clear separation of duties.  

Technicians propose and modify candidate products for their assigned requests. Requesters alone can approve or reject these proposals, providing specific feedback if the product is unsatisfactory.  

A state-based ENUM attribute tracks the request's progress. A nullable BOOLEAN evaluates candidate products, allowing for pending, approved, or rejected statuses linked to a response timestamp. 

Every request generates a complete history via timestamps, persisting in the database even after completion. This ensures full traceability of the transaction outcome and delivery status.  

Categories use an ID_padre attribute to support nested structures, reflecting a real-world product catalog. Deleting a parent category does not result in the loss of its subcategories.  

Foreign keys link requests to users with RESTRICT constraints to prevent data loss. The Requester remains fixed, while the Technician can be assigned later but never deleted from the history.  
