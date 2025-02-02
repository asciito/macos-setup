# Initial setup for my MacOS computers

Every once and a while, I format my computers or buy a new one (not so often), and when this happen I need to install a bunch of tools like Code Editors (VSCode, PHPStorm, etc), package manager ([Homebrew](https://brew.sh)), plugins for [Oh My ZSH](https//ohmyz.sh/), etc. This takes time, and configuring my Code editors is a pain in the ass, even when I sync this settings natively a few things don´t work correctly.

With all this in mind, I decided to use a quick solution (at least for me) and do this process with the shell, just the bare minimum to start working on my projects without setting up anything else, unless the project needs something special.

Yup, a lot of work just to say: I'm lazy...


---

This project will install:

* [Xcode](https://developer.apple.com/xcode/)
* [Homebrew](https://brew.sh)
* [Git](https://git-scm.com)
* [Oh My ZSH](https://ohmyz.sh/)
* ... and more


## One Line Installation

Just run the next command:

```bash
/bin/bash -c "$(curl -fsSL "https://raw.githubusercontent.com/asciito/macos-setup/main/oneline/install.sh" -o-)"
```

That's all 😂
