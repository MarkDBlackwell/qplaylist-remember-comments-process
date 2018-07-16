### Remember songs comments process (for Qplaylist)

Copyright (C) 2018 Mark D. Blackwell.

## Overview

A Windows Ruby gem that processes
listeners comments about recent songs
and emails them to disk jockeys
for any radio station
which uses WideOrbit automation software.

## Installation

Select (or create) a Gmail account for the gem to use,
for sending emails to disk jockeys.
I'll call this account the "Remember Songs Daemon" email account.
You must tell Google to allow (what Google calls)
"less secure access" to it (by programs).

Google says, at the bottom of [this help page](https://support.google.com/a/answer/6260879):

* "Access to less secure applications is allowed for first 24 hours after a new user is created[,]
even if either the admin-level or user-level setting has been set to disallowed.

* "Access to less secure applications remains allowed[,]
if a non-secure application accesses the account within 24 hours after you've created the user."

Therefore, you must ensure that this gem successfully sends its first email
within 24 hours of the email account's creation.

Install Ruby, version 2.2.5-p319, from the .exe file (regular or 64-bit) in the
[RubyInstaller.org archives](https://rubyinstaller.org/downloads/archives/),
to the directory C:\Ruby.

* Select the option to install Tcl/Tk support.

* Unselect the option to add Ruby executables to your PATH.

* Unselect the option to associate .rb and .rbw files with this Ruby installation.

Add "C:\Ruby\bin" to your system environment variable, "Path".

Open up a command window,
and verify that the version of the installed Ruby is "2.2.5p319":

````bash
$ ruby --version
````

Do the following,
and find the directory it lists as the SYSTEM CONFIGURATION DIRECTORY:

````bash
$ gem env
````

Open Windows Explorer and navigate to that directory.
Ensure that it contains a file, "gemrc" (with no extension).
Edit this to contain:

````
install: --no-document
````

Download version 2.7.4 of the gem "rubygems-update" by navigating in a web browser to its
[description page](https://rubygems.org/gems/rubygems-update/versions/2.7.4)
and clicking the word, "Download".

In the command window, navigate to your download directory, and do:

````bash
$ gem install --local --no-document rubygems-update-2.7.4.gem
$ update_rubygems --version=2.7.4
$ gem uninstall --executables rubygems-update
````

In Windows Explorer, navigate to the directory, "C:\Ruby\lib\ruby\gems\2.2.0\doc".
There, delete (not recycle) the directory, "rubygems-2.7.4".

Download gem "qplaylist-remember-comments-process"
to some {file} in your download directory, and do:

````bash
$ gem install {file}
````

If a Windows Security Alert comes up, asking whether to "Allow Ruby interpreter...to communicate",
then click the "Allow access" button.

If asked whether to "Overwrite the executable?",
answer "Y".
(This regards conflicts between executable files.)

If necessary, you can do the following,
and then reinstall the gem:

````bash
$ gem uninstall --executables qplaylist-remember-comments-process
````

Then do:

````bash
$ qplaylist-remember-comments-process-set-up
````

This will ask questions about:
1. The credentials to access an FTP account on your web server;
1. The credentials to access the "Remember Songs Daemon" email account;
1. Your desired "Remember Songs Daemon" reply-to email address;
1. Your desired filename
(including network drive letter and path)
for a special, air-show schedule file
(used by the gem).

Create a Windows Task Scheduler task which runs at 15 minutes after every hour.

  General tab:
````
Name: QplaylistRememberComments
Security options: Run only when user is logged on.
````

  Triggers tab: Create a trigger with the following properties:
````
Begin the task: On a Schedule.
Settings: One time.
Start: (enter the next available, appropriate time).
Repeat task every: 1 hour
For a duration of: Indefinitely.
Stop task if it runs longer than: 5 minutes.
Enabled.
````

  Actions tab: Create an action with the following properties:
````
Action: Start a program.
Settings: Program/script: qplaylist-remember-comments-process-mail
````

  Settings tab:
````
Allow task to be run on demand.
Stop the task if it runs longer than: 5 minutes.
If the task does not end when requested, force it to stop.
If the task is already running, then the following rule applies: Do not start a new instance.
````

View the task by Task Scheduler Library - View - Show Preview Pane.
Select the root of Task Scheduler Library to find the task.

Again, the job should start the following program.
(This executable is supplied by the gem.):

````bash
$ qplaylist-remember-comments-process-mail
````

Then, edit the special air-show schedule file (which the gem will use).

Occasionally, in order to minimize web server disk space use,
you should run the following program.
But, don't run it during
(or until 20 minutes after)
any air-show listed in the schedule file
(which you maintain for this program).

````bash
$ qplaylist-remember-comments-process-clear
````

## Development

````bash
$ gem uninstall --executables qplaylist-remember-comments-process
$ gem build *.gemspec
$ gem install --local *.gem
````

## Test

Currently, the testbed isn't working.

````bash
$ bundle install --with development
````

## License

See LICENSE.txt.
