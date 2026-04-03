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
- Bulk-safe: each request is processed independently — one invalid field name or bad request does not fail others
- Per-request error reporting via the `errorMessage` output variable
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
- If `fieldApiName` is blank, `response` is `null` and `errorMessage` is populated
- If the field does not exist on the SObject, `response` is `null` and `errorMessage` contains the exception detail
- If the field value is `null`, `response` is `null` and `errorMessage` is also `null`
- All returned values are converted to **String**
- When multiple requests are passed (bulk invocation), each is processed independently so that one failing request does not affect the others

---
