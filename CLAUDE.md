# CLAUDE.md — CAP Node.js + Fiori Elements v4 + SAPUI5

> This file guides Claude Code when working in this SAP CAP project.
> It defines conventions, MCP tool usage, and workflow expectations.

---

## Project Overview

This is a **SAP Cloud Application Programming Model (CAP)** project using:
- **Runtime**: Node.js (`@sap/cds`, `@sap/cds-dk`)
- **UI**: SAP Fiori Elements v4 (OData V4) with SAPUI5
- **Database**: SQLite (local dev) → SAP HANA Cloud (production)
- **MCP Tools**: `@cap-js/mcp-server` (cds-mcp), `@sap-ux/fiori-mcp-server`, `@ui5/mcp-server`


## MCP Tool Rules — MANDATORY

### Rules for SAP CAP apps (`@cap-js/mcp-server` = cds-mcp)

- You **MUST** search for CDS definitions — entities, fields, and services (which include HTTP endpoints) — with **cds-mcp**. Only if it fails may you read `*.cds` files in the project directly.
- You **MUST** search for CAP docs with **cds-mcp** EVERY TIME you create or modify CDS models, or when using CAP APIs or the `cds` CLI. Do **NOT** propose, suggest, or make any changes without first checking it.

### Rules for SAP Fiori Elements apps (`@sap-ux/fiori-mcp-server`)

- When asked to create a Fiori Elements app, check whether the user input can be interpreted as an application organized into one or more pages containing table data or forms. These can be translated into a Fiori Elements application — otherwise ask the user for suitable input.
- The application typically starts with a **List Report** page showing the data of the base entity in a table. Details of a specific row are shown in an **Object Page** based on the same base entity.
- An Object Page can contain one or more table sections based on to-many associations of its entity type. Details of a table section row can be shown in another Object Page based on the association's target entity.
- The data model must be suitable for Fiori Elements: one main entity and one or more navigation properties to related entities.
- Each property of an entity must have a proper datatype.
- For all entities provide **primary keys of type UUID**.
- When creating sample data in CSV files, all **primary keys and foreign keys MUST be in UUID format** (e.g., `550e8400-e29b-41d4-a716-446655440001`).
- When generating or modifying the Fiori Elements application on top of the CAP service, use the **Fiori MCP server** if available.
- When modifying the Fiori Elements application (e.g. adding columns), do **NOT** use screen personalization — instead modify the project code. Before doing so, check whether an MCP server provides a suitable function.
- When previewing the Fiori Elements application, use the most specific `npm run watch-*` script for the app in `package.json`.

### Rules for UI5 apps (`@ui5/mcp-server`)

- Use the **`get_guidelines` tool** of the UI5 MCP server to retrieve the latest coding standards and best practices **before** any UI5 development task.

---

## MCP Tool Decision Guide

| Task | Use This MCP Server |
|------|-------------------|
| Search CDS entities, fields, services | `@cap-js/mcp-server` (cds-mcp) — **MANDATORY first step** |
| Create/modify CDS entity or service | `@cap-js/mcp-server` — check docs first |
| Add CAP plugin or feature flag | `@cap-js/mcp-server` |
| Debug OData service or metadata issue | `@cap-js/mcp-server` |
| Add Fiori annotation (LineItem, Facets, etc.) | `@sap-ux/fiori-mcp-server` |
| Generate Fiori app (manifest, app descriptor) | `@sap-ux/fiori-mcp-server` |
| Configure value help, field group, draft | `@sap-ux/fiori-mcp-server` |
| Add/modify columns or table sections | `@sap-ux/fiori-mcp-server` |
| Get UI5 coding standards & guidelines | `@ui5/mcp-server` — `get_guidelines` **first** |
| Look up UI5 control API / properties | `@ui5/mcp-server` |
| Create XML view, fragment, controller extension | `@ui5/mcp-server` |

---

## CDS Conventions

### Naming
- **Entities**: `PascalCase`, plural (e.g., `SalesOrders`, `BusinessPartners`)
- **Services**: `PascalCase` + `Service` suffix (e.g., `CatalogService`, `AdminService`)
- **Associations**: `camelCase` (e.g., `toItems`, `toHeader`)

### Model Design
- Define all **domain entities** in `db/schema.cds` — never in `srv/`
- Use **aspects** for reusable fields (e.g., `managed`, `cuid`)
- Use **compositions** (`Composition of many`) for master-detail relationships
- Use **associations** (`Association to`) for cross-entity references
- Always add `@readonly` or `@insertonly` where appropriate
- Provide **CSV test data** in `db/data/<namespace>-<EntityName>.csv`
- All primary keys and foreign keys in CSV files **must use UUID format**

### Service Layer
- Keep service `.cds` as thin projections — avoid duplicating field definitions
- Implement custom logic in `.js` handlers using `srv.on / srv.before / srv.after`
- **Prefer CDS-native computed columns** in projections over `.js` handlers for derived/read-only values:
  ```cds
  entity Foo as projection on db.Foo {
    *,
    case status
      when 'Open' then 5
      else 0
    end as criticality : Integer
  }
  ```
- Use `.js` handlers **only** for side effects, external calls, and validation — not for value derivation expressible in CDS
- Return early with `req.error(...)` for validation failures — never throw raw errors
- Prefer **managed transactions** (`req.context`) over manual DB calls

---

## Fiori Elements v4 Conventions

### Annotations
- Place **shared UI annotations** in `srv/annotations/<service-name>-ui.cds`
- Place **app-specific annotations** in `app/<app-name>/annotations.cds`
- Always define `@UI.HeaderInfo.Title` and `@UI.HeaderInfo.TypeName`
- Use `@UI.SelectionFields` for the List Report filter bar
- Use `@UI.Criticality` for status fields
- Structure Object Pages with `@UI.Facets` → `ReferenceFacet` and `CollectionFacet`

#### UI.HeaderInfo — NEVER use abstract types
- `Title` and `Description` in `@UI.HeaderInfo` MUST use `$Type: 'UI.DataField'`
- NEVER use `$Type: 'UI.DataFieldAbstract'` — it is an abstract base type
  and will crash at runtime in TitleHelper.ts

### Draft Handling
- Enable draft with `annotate <Entity> with @odata.draft.enabled;`
- Always use `srv.on('PATCH', ...)` for draft events — do not bypass them
- Add `@Common.ValueList` for foreign key fields
- Use `@mandatory` for required fields, `@Core.Computed` for server-calculated fields

---

## Development Workflow

### Starting the CAP Server
```bash
cds watch                        # Local dev with live reload (SQLite + mock auth)
cds watch --profile hybrid       # With bound BTP services (HANA, XSUAA)
npm run watch-<app-name>         # App-specific preview (preferred for Fiori)
```

### Adding Capabilities
```bash
cds add hana        # SAP HANA Cloud support
cds add xsuaa       # Authentication/authorization
cds add approuter   # SAP App Router
cds add mta         # Generate mta.yaml for BTP deployment
```

### Deploying
```bash
cds build --production           # Build for deployment
mbt build                        # Build MTA archive
cf deploy mta_archives/<app>.mtar  # Deploy to BTP Cloud Foundry
```

---

## Authorization

- Use `@restrict` annotations on services and entities — never bypass security
- For local dev use `"kind": "mocked"` auth with test users in `.cdsrc.json`
- Always scope sensitive operations: `@restrict: [{ grant: 'WRITE', to: 'Admin' }]`

---

## Common Pitfalls to Avoid

- ❌ Do NOT modify CDS models without first querying cds-mcp for current definitions and docs
- ❌ Do NOT use screen personalization to modify Fiori apps — always change the code
- ❌ Do NOT put domain logic in `.cds` files — use `.js` handlers
- ❌ Do NOT use `SELECT *` in CAP handlers — always project specific fields
- ❌ Do NOT hardcode tenant/user context — use `req.user`, `req.tenant`
- ❌ Do NOT commit `.env` files or `default-env.json` with credentials
- ❌ Do NOT use non-UUID formats for primary or foreign keys in CSV seed data
- ❌ Do NOT use `sapui5.hana.ondemand.com` as CDN — it is the **old, deprecated URL**. Always use `ui5.sap.com` instead.
  - In `*.html` files: `src="https://ui5.sap.com/<version>/resources/sap-ui-core.js"`
  - In `ui5*.yaml` files: `url: https://ui5.sap.com`
  - This applies to generated files too — correct them immediately after generation.

- ✅ DO prefer **CDS-native computed expressions** (e.g. `CASE`, arithmetic, string functions) in service projections over equivalent `.js` handler logic — they push computation to the DB layer and require no runtime overhead

---

## Key References

- [CAP Documentation](https://cap.cloud.sap/docs/)
- [Fiori Elements Feature Showcase (OData V4)](https://github.com/SAP-samples/fiori-elements-feature-showcase)
- [UI5 Web Components](https://sap.github.io/ui5-webcomponents/)
- [SAP Fiori Design Guidelines](https://experience.sap.com/fiori-design-web/)
- [OData V4 Vocabulary Reference](https://github.com/SAP/odata-vocabularies)
