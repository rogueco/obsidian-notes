# HomeLet Framework

<aside>
💡 This template provides context/instructions for the languages you use.

</aside>

# Change HomeLet Framework to Access Rentshield

1. Navigate to:
    
    ```
    src -> application -> parameters -> global.ini
    ```
    
2. Change the below

```json
brand.brandName = 'homelet'
brand.templateAffix = 'Homelet'

// TO

brand.brandName = 'rentshield'
brand.templateAffix = 'Rentshield'
```

TypeScript

We use React with TypeScript for our frontend codebase. 

# Code Style Guide

We largely follow Airbnb's React/JSX Style Guide:

[airbnb/javascript](https://github.com/airbnb/javascript/tree/master/react)