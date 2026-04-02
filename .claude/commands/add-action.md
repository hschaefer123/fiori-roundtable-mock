---
description: Add a CAP bound or unbound action or function with handler stub
---
Add a new CAP action or function to this project. Ask me for:
- Action name (camelCase, e.g. "approve")
- Bound (on which entity?) or unbound?
- Action or Function (function returns a value)?
- Input parameters and return type

Then do the following steps without stopping:

1. Search for the existing service definition using cds-mcp
2. Add the action/function declaration to the service CDS file
3. Add the handler stub in `srv/*.js` — include input validation and a TODO comment for business logic
4. If a Fiori Elements app exists: add a UI.DataFieldForAction annotation to trigger the action from the Object Page toolbar
