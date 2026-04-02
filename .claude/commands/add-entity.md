---
description: Add a new CDS entity with service projection, CSV seed data and OData annotations
---
Add a new CDS entity to this CAP project. Ask me for:
- Entity name (PascalCase, singular, e.g. "SalesOrderItem")
- Key fields and their types
- Additional fields

Then do the following steps without stopping:

1. Search for the existing CDS schema and service using cds-mcp to understand naming conventions
2. Add the entity to `db/schema.cds` — key as UUID, proper CDS types, `@title` annotations
3. Add a projection in the existing service CDS file
4. Create `db/data/<namespace>-<EntityName>s.csv` with 5 realistic UUID-keyed sample rows
5. Add OData annotations (UI.LineItem, UI.HeaderInfo, UI.SelectionFields) to the existing `annotations.cds`
