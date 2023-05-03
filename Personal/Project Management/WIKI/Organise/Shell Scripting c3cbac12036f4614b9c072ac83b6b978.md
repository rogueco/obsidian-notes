# Shell Scripting

# Basic-Implementation

## Variables

[Variables](Variables%205bf90750f4f645ad93a52d51ab87852d.md)

## Basic Implementation of a shell script

```bash
#!/usr/bin/env zsh

# Author : Tom Fletcher
# Copyright (c) None
# Script follows here:

echo "What is your name?"
read PERSON
echo "Hello, $PERSON"
```

The above, we are using zsh as our default script language - If you are using bash, swap out to use bash.

# Script file Execution

To make the script **Executable** you will need to run the following command

```bash
chmod +x {pathToDirectory/File}
chmod +x test.sh
```

### To Run Script

To run your script just run the following command

```bash
./{fileName}

./test.sh
```

# Arrays

[Arrays](Arrays%205cf6937ff7d6447ebd530b1bbc9e9fd4.md)

# Decision Making - ZSH & Bash.

```bash
#Bash

#!/bin/sh

a=10
b=20

if [ $a == $b ]
then
   echo "a is equal to b"
fi

if [ $a != $b ]
then
   echo "a is not equal to b"
fi

#ZSH
#!/bin/sh

a=10
b=20

if [[ $a == $b ]]
then
   echo "a is equal to b"
fi

if [[ $a != $b ]]
then
   echo "a is not equal to b"
fi

```

 

# Operators

<aside>
🔒 The following points need to be considered while adding −

There must be spaces between operators and expressions. For example, 2+2 is not correct; it should be written as 2 + 2.

The complete expression should be enclosed between ‘ ‘, called the backtick.

</aside>

[Arithmetic Operators](Shell%20Scripting%20c3cbac12036f4614b9c072ac83b6b978/Arithmetic%20Operators%203983388cf75b4362a049fd1b4291195e.md)

<aside>
🔒 Assume variable a holds 10 and variable b holds 20 then −

</aside>

[Relational Operators](Shell%20Scripting%20c3cbac12036f4614b9c072ac83b6b978/Relational%20Operators%2092b535b975d1449c96afe2abc519a0a5.md)