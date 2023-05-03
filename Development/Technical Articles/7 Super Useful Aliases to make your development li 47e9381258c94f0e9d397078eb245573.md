# 7 Super Useful Aliases to make your development life easier

Article Link: https://codeburst.io/7-super-useful-aliases-to-make-your-development-life-easier-fef1ee7f9b73
Date Added: August 15, 2021 9:09 PM
Tag: Git, Terminal

```
npm install --save expresssudo apt-get updatebrew cask install docker
```

Commands like these are our *daily routine*. *Software Developer*, *Dev ops*, *Data Scientists*, *System Admin* or in any other profession, we need to play with a few regular commands again and again.

It’s **tiresome** to write these commands every time we need them 😫

***Wouldn’t it be better if we could use some kind of shortcuts for these commands?***

# **Meet Your Friend — *Alias***

What if I tell you that you can use

```
nis express
```

Instead of

```
npm install --save express
```

Stay with me, we’ll find out how 😉

# **What’s `alias ?`**

It’s a text-only interface for your terminal or shell commands that can be mapped with longer and more complex commands under the hood!

# **How ?**

Open your terminal and type `alias` then press `Enter`

You’ll see a list of available `aliases` on your machine.

If you look closely you’ll find a common pattern to use aliases -

```
alias alias_name="command_to_run"
```

**So, we’re simply mapping commands with names! (almost)**

# **Let’s Create a few**

***NOTE: For the purpose of this tutorial, please keep your terminal open and use one terminal to test these aliases. use `cd` if you need to change directory.***

## **1. Install `node` Packages**

`npm install --save packagename` ➡️ `nis packagename`Type the command below in your terminal and press `Enter` -

```
alias nis="npm install --save "
```

Now, we can use `nis express` to install `express` inside your `node` project.

## **2. Git add and commit**

`git add . && git commit -a -m "your commit message"`➡️ `gac "your commit message"`

```
alias gac="git add . && git commit -a -m "
```

WARNING: This is not a recommended alias to use, use it if and only if you know what you’e

## **3. Search Through Terminal History**

`history | grep keyword` ➡️ `hs keyword`

```
alias hs='history | grep'
```

Now, if we need to search thorough our history to find everything with the keyword `test` we just have to execute `hs test` to find our expected result.

## **4. Make and enter inside a directory**

`mkdir -p test && cd test` ➡️ `mkcd test`

```
alias mkcd='foo(){ mkdir -p "$1"; cd "$1" }; foo '
```

## **5. Show my ip address**

`curl [http://ipecho.net/plain](http://ipecho.net/plain)` ➡️ `myip`

```
alias myip="curl http://ipecho.net/plain; echo"
```

## **6. Open file with admin access**

`sudo vim filename` ➡️ `svim filename`

```
alias svim='sudo vim'
```

## **7. Update your linux pc/server**

`sudo apt-get update && sudo apt-get update` ➡️ `update`

```
alias update='sudo apt-get update && sudo apt-get upgrade'
```

# **Persistant Aliases**

You’ve learnt how to create aliases. Now it’s time to make them persistent throughout your system. Depending on what type of shell/terminal you’re using you need to `copy-paste` your aliases inside `~/.bashrc` or `~/.bashprofile` or `~/.zshrc` if you’re using `zsh` as your default terminal.

**Example**:

As I’m using `zsh` as my default terminal, I’ve to edit `~/.zshrc` file to add my aliases. First of all let’s open it with admin access with `sudo vim ~/.zshrc` .

Now, I need to paste my alias/aliases like `alias hs='history | grep'` then exit with saving by entering `:wq` inside `vim`

Then to take effect I need to execute `source ~/.zshrc` and restart my terminal. From now on, the `hs` command will be available throughout my system 😃

## **Bonus**

[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) is a great enhancement for your terminal which comes with some default aliases and beautiful interface.

**As you’ve learnt how to use aliases, let’s go and create some awesome aliases and share it in the response section.**

**Happy Coding 💻**