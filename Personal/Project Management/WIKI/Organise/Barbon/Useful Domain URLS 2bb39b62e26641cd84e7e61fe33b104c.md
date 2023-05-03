# Useful Domain URLS

<aside>
💡 Frequently used commands. This is a helpful page to [add to your Favorites](https://www.notion.so/7ef7287cee00464d9a813073b02ce24a).

</aside>

# 🚚 Development

[Development URLS](Useful%20Domain%20URLS%202bb39b62e26641cd84e7e61fe33b104c/Development%20URLS%20e68d5b13445545c88c20aa09858147e6.md)

```bash
acme run --local
```

For a full list of options, use:

```bash
acme --help
```

To run the typechecker on the entire codebase:

```bash
acme typecheck
```

# 🚢 Deployment

When you deploy to staging or production, run the following on the deployment server:

```bash
acme deploy --staging 
```

Replace `--staging` with `--prod` if deploying production.