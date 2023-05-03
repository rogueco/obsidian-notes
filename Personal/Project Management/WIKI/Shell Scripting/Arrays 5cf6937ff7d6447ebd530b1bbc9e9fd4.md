# Arrays

<aside>
💡 **FYI, if you are using ZSH index value starts at 1 not 0... weird..**

</aside>

```bash
array_name[index]=value

NAME[0]="Tom"
NAME[1]="Cassy"
NAME[2]="Monty"
NAME[3]="Arthur"
NAME[4]="Indie"
```

**Accessing arrays**

```bash
#!/usr/bin/env zsh

# Author : Tom Fletcher
# Copyright (c) tom-fletcher.co.uk
# Script follows here:

NAME[0]="Tom"
NAME[1]="Cassy"

echo "First Index: ${NAME[0]}"
echo "Second Index: ${NAME[1]}"
```