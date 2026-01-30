# CollectionGetFirstValue_Records

A Salesforce Apex **Invocable Action** that returns the **first field value** from the first record in a record collection.  
Built for **Salesforce Flow** to easily extract a single field value without loops or additional logic.

---

## Overview

`CollectionGetFirstValue_Records` accepts a collection of records along with a **field API name**, and returns the value of that field from the **first record** in the collection as text.

If the record collection is null, empty, or the field value is null, the response is safely returned as `null`.

---

## Features

- Flow-ready via `@InvocableMethod`
- Works with **any SObject**
- Field selection via **dynamic Field API Name**
- Null-safe for records and field values
- No DML or SOQL
- Uses `with sharing` to respect org security

---

## Common Use Cases

- Retrieve the **Id**, **Name**, or other field from a Get Records result in Flow
- Convert non-text field values to **String** for downstream Flow logic
- Avoid Flow loops when only a single field value is needed
- Reusable utility across multiple Flows and object types

---

## Behavior Notes

- The first record is determined by the **existing collection order**
- No sorting or validation of the field API name is performed
- If the field does not exist or the value is null, the response is `null`
- All returned values are converted to **String**

---
