# 3 Terminal Commands to Increase Your Productivity

Article Link: https://betterprogramming.pub/3-terminal-commands-to-increase-your-productivity-9dbab9f1a015
Date Added: August 15, 2021 9:11 PM
Tag: Terminal

[https://miro.medium.com/max/1400/0*G4NUYazg0MXMlvjc](https://miro.medium.com/max/1400/0*G4NUYazg0MXMlvjc)

Photo by [Juan Gomez](https://unsplash.com/@nosoylasonia?utm_source=medium&utm_medium=referral) on [Unsplash](https://unsplash.com/?utm_source=medium&utm_medium=referral)

Here are a few important shortcuts that help me be more productive throughout the day at work:

- Creating aliases for commands.
- Using pbcopy.
- Using reverse search in the terminal.
- Bonus tricks and tips.

# **Alias for Commands**

Alias can be one of the most powerful tools in our hands, it provides us with the power to write our own shortcuts. Let’s see with an example what I mean.

```
alias dev="cd ~/Project/development"
```

Whenever I type `dev` and hit enter it’ll run this command. This becomes very useful when navigating to different folders. We can run almost all the commands in the alias. Here is the list of some of my most-used commands:

```
alias ..="cd .."
alias gs="git status"
alias gp="git pull"
alias gb="git branch"
alias ga="git add ."
```

So, using these aliases, I save a lot of time during the day, to up a directory I type, instead of cd… I think the rest of them are self-explanatory. We can also use arguments with $1, $2, etc. for more extendability, like in this example:

```
alias gc="git commit -m $1"
```

Now, all I have to type is `gc “Commit message”` and it’ll commit my changes with the provided message. All you have to do is find your most-used commands and try to make them shorter using an alias to make yourself more productive.

Now that we know what the aliases can do, let us see how we can set them. There are two ways in which we can achieve this, the first is temporary and can be set by running the command:

```
alias dev="cd ~/Project/development"
```

This will work until the session is closed. The other way is to set these aliases permanently. For that, we need to set it up in our shell, I use [Zsh](https://ohmyz.sh/), so I’ll be updating my `~/.zshrc` file.

If you are using [Bash](https://www.gnu.org/software/bash/), use the `~/.bashrc` file. Add the commands to the file and your file should look like this:

![https://miro.medium.com/max/1050/1*vS_C4gUS4JQ6BB93IW5oPw.png](https://miro.medium.com/max/1050/1*vS_C4gUS4JQ6BB93IW5oPw.png)

.zshrc file

After making changes to this file, you need to run the command:

```
source ~/.zshrc
```

Then, all your aliases will be available for your use.

# **pbcopy**

This command is available on Mac and if you want to use it on Linux distributions, you can follow this [guide](https://www.ostechnix.com/how-to-use-pbcopy-and-pbpaste-commands-on-linux/).

`pbcopy` is copy on steroids. You can use this command to copy the contents of a file to the clipboard. Let me give you an example. Suppose you have to copy your SSH identity to the clipboard, you can do it with this command:

```
pbcopy < ~/.ssh/id_rsa.pub
```

You can save your other passwords in different files and make use of this while logging in.

Suppose you are using and accessing a remote server, and you have to provide the password, instead of opening the file, you can just `pbcopy` it to your clipboard and without all the hassle of opening and closing files, you’ll have the passwords.

It becomes more useful when it is piped with other commands like `grep`. It’ll copy the grepped results to the clipboard. Let’s see with an example:

```
grep "<keyword>" | pbcopy
```

I use this command when I am debugging the log files, and I provide a keyword to be searched for, like a timestamp, and all the lines are copied onto my clipboard.

I can paste it in a file to see the required logs instead of the whole file. It can be even more useful if you use the `tee` command as a pipe to `grep`, it’ll write the results to a file.

It has the following syntax:

```
grep "<keyword>" | tee myfile.txt
```

# **Using Reverse Search**

Reverse search is one of the coolest things available on the Unix system.

Suppose you forget the full command and you only remember some parts, what you can do is you can go to the reverse search and type the words that you remember. Let’s see it with an example.

I have to restart my server running in the staging environment, I only remember the staging keyword and forgot the rest of the command. So, I type `ctrl + r`to go into reverse-search mode and type:

```
(reverse-i-search)`stag': cd /home/ubuntu/server; pm2 stop app.js && export NODE_ENV="staging" && pm2 start app.js && pm2 logs
```

It’ll remember the commands previously entered and finds the right match that you are looking for.

# **Bonus Tricks and Tips**

## **cal**

It prints the current month on the terminal. It has many different options available, which can be checked using `man cal`.

![https://miro.medium.com/max/401/1*ZA74I_maw0M9LLW8-abu_A.png](https://miro.medium.com/max/401/1*ZA74I_maw0M9LLW8-abu_A.png)

Current Month view

## **Encrypting a file using vim**

You can encrypt a file using [vim](https://www.vim.org/), just type `:X`. It’ll ask you to set a password which will look like this:

![https://miro.medium.com/max/1050/1*gJn9mq3Oh517gJz8DJ7_lg.png](https://miro.medium.com/max/1050/1*gJn9mq3Oh517gJz8DJ7_lg.png)

Encrypting a file

When you access this file again, it’ll ask you for the password.

![https://miro.medium.com/max/1050/1*EXTVX6CXf8Hfpp1QELF_jg.png](https://miro.medium.com/max/1050/1*EXTVX6CXf8Hfpp1QELF_jg.png)

If you want to learn more about vim, here is a great article:

**[Understanding the Efficiency of vimWhy is everyone always talking about vim? Learn the basics of vim to finally start using it**
medium.com](https://medium.com/better-programming/understanding-the-efficiency-of-vim-d6a5ab8feb2d)

If you want to learn more about terminal shortcuts, here is a great link:

**[Top 5 tips to increase productivity in TerminalHow to use shortcuts to increase your productivity in Termina**
medium.com](https://medium.com/@swarnajyoti/top-5-tips-to-increase-productivity-in-terminal-31ee66611465)

# **Conclusion**

We can use these commands to make our day more productive and stay on top of things.