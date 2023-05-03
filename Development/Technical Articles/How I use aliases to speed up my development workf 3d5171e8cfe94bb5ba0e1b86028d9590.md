# How I use aliases to speed up my development workflow

Article Link: https://medium.com/@Radu_Raicea/using-aliases-to-speed-up-your-workflow-89f0a93d34ba
Date Added: August 15, 2021 9:10 PM
Tag: Git, Terminal

![https://miro.medium.com/max/2000/1*9CZzf93jJ7bG_B2vZTbZow.png](https://miro.medium.com/max/2000/1*9CZzf93jJ7bG_B2vZTbZow.png)

For many developers, especially beginners, the terminal seems daunting. Some even find it inefficient and prefer to use a GUI application for their development needs instead.

While they might be right about some things taking longer when doing them in the terminal, they’re mostly wrong. Using the terminal is much faster than using a GUI, given the right setup.

The secret to speeding up your terminal workflow is the use of **aliases**.

Aliases are crucial to working in the terminal. They’re what domain names are to IPs. Nobody wants to remember `172.217.0.227` instead of `google.com`. The same is true for terminal commands.

Aliases have a very simple structure:

```
alias name_of_the_alias='bash commands'
```

If you open up a terminal and enter the following commands, you will create an alias that displays the current time.

```
$ alias now='date +"%T"'
$ now
18:55:28
```

Unfortunately, this alias will not work if you close the terminal and re-open it. We need to store our aliases in a file where the computer knows to look for them. Every computer and operating system has a different name for that file, but it is usually in your home directory.

Go in your home directory by entering `cd ~/` and then list all the files (including the hidden files) with `ls -la`.

On *Ubuntu* the file is called `.bashrc`. If it doesn’t exist in your home directory, create it using the following command.

```
$ mkdir ~/.bashrc
```

On *Mac* the file is called `.bash_profile` or `.profile`. If you have both files in your home directory, use `.bash_profile`. If none of them exist in your home directory, create one using the following command.

```
$ mkdir ~/.profile
```

Once the file is there, it’s time to add our aliases in it. Open it up using `nano`.

```
$ nano ~/.profile
```

![https://miro.medium.com/max/1001/1*CbMfUeMLlV3OwaRXDEo2jg.png](https://miro.medium.com/max/1001/1*CbMfUeMLlV3OwaRXDEo2jg.png)

.profile opened up with nano

If there is already content inside the file, any alias you add should be at the bottom.

Add all your aliases and press `CTRL-X` to save. When it asks you to confirm, enter `Y` and press `ENTER`.

![https://miro.medium.com/max/992/1*HzS4aHX0ieC1DJbeupDYrg.png](https://miro.medium.com/max/992/1*HzS4aHX0ieC1DJbeupDYrg.png)

nano saving confirmation

If you try your aliases now, they will not work because we haven’t run the file yet. You can do that by using `source`.

```
$ source ~/.profile
```

The aliases are now active, and they will stay active even if you restart your terminal. To verify them, you can either try the aliases you’ve added, or type `alias` to get the list of all aliases.

To wrap things up, here are some of my most used aliases (mostly for Git and Docker).

```
parse_git_branch2() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}alias ll='ls -la'
alias work='cd ~/Dev'
alias py='python'alias gb='git branch'
alias gps='git push'
alias gpl='git pull'
alias gch='git checkout'
alias gco='git commit -m'
alias gst='git status'
alias ga='git add'
alias gr='git reset'
alias gd='git diff'
alias gup="git push --set-upstream origin \$(parse_git_branch2)"alias dock='docker-compose down && docker-compose up --build'
alias ddd='docker rm $(docker ps -a -q) -f'
alias iii='docker rmi $(docker images -a -q)'
alias vvv='docker volume prune'
alias exc='docker exec -it'
alias post='exc postgres psql -U postgres'
alias test='docker-compose run --rm flask python manage.py cov'
alias migrate='docker-compose run --rm flask python manage.py db migrate'
alias upgrade='docker-compose run --rm flask python manage.py db upgrade'
alias test_one='docker-compose run --rm flask python manage.py test_one'
alias run='docker-compose run --rm flask python manage.py'
```

Note: `parse_git_branch2()` is used to automatically detect the current Git branch you’re in, in order to pass it to `gup`, which pushes the branch to the remote.