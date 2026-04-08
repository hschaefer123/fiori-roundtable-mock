# Getting Started

Welcome to your new CAP project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`readme.md` | this getting started guide

## Next Steps

- Open a new terminal and run `cds watch`
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start with your domain model, in a CDS file in `db/`

## Learn More

Learn more at <https://cap.cloud.sap>.

## 🥚 Easter Egg
There's a hidden surprise somewhere in this project.
It involves the [@sap-ux/preview-middleware](https://www.npmjs.com/package/@sap-ux/preview-middleware) — specifically its flp.init lifecycle and a custom theme injection that goes slightly beyond what the middleware was originally designed for.
If you know where to look, you'll find it. If you don't — maybe start with what loads before your Fiori app does.

> Not all middleware is created equal. Some of it has taste.
