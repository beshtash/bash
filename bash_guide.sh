# bash_guide.sh

Chapter-2: Special Characters.

---
: 
null comman(colon). NO OP do nothing operation. Synonim for "true".
===
while :
do
   operation-1
   operation-2
   ...
   operation-n
done

# Same as:
#    while true
#    do
#      ...
#    done
===

Placeholder in if/then test:
===
if condition
then :   # Do nothing and branch ahead
else     # Or else ...
   take-some-action
fi
===

===
Placeholder in if/then test:

if condition
then :   # Do nothing and branch ahead
else     # Or else ...
   take-some-action
fi
Provide a placeholder where a binary operation is expected, see Example 8-2 and default parameters.

: ${username=`whoami`}
# ${username=`whoami`}   Gives an error without the leading :
#                        unless "username" is a command or builtin...

: ${1?"Usage: $0 ARGUMENT"}     # From "usage-message.sh example script.

Provide a placeholder where a command is expected in a here document. See Example 19-10.

Evaluate string of variables using parameter substitution (as in Example 10-7).
: ${HOSTNAME?} ${USER?} ${MAIL?}
#  Prints error message
#+ if one or more of essential environmental variables not set.
===

===
Variable expansion / substring replacement.

In combination with the > redirection operator, truncates a file to zero length, without changing its permissions. If the file did not previously exist, creates it.
: > data.xxx   # File "data.xxx" now empty.	      

# Same effect as   cat /dev/null >data.xxx
# However, this does not fork a new process, since ":" is a builtin.
See also Example 16-15.

In combination with the >> redirection operator, has no effect on a pre-existing target file (: >> target_file). If the file did not previously exist, creates it.

Note	
This applies to regular files, not pipes, symlinks, and certain special files.

May be used to begin a comment line, although this is not recommended. Using # for a comment turns off error checking for the remainder of that line, so almost anything may appear in a comment. However, this is not the case with :.
: This is a comment that generates an error, ( if [ $x -eq 3] ).
===

===
A colon is acceptable as a function name.
:()
{
  echo "The name of this function is "$FUNCNAME" "
  # Why use a colon as a function name?
  # It's a way of obfuscating your code.
}

:

# The name of this function is :
This is not portable behavior, and therefore not a recommended practice. In fact, more recent releases of Bash do not permit this usage. An underscore _ works, though.


A colon can serve as a placeholder in an otherwise empty function.

not_empty ()
{
  :
} # Contains a : (null command), and so is not empty.
===
!
reverse (or negate) the sense of a test or exit status [bang]. The ! operator inverts the exit status of the command to which it is applied (see Example 6-2). It also inverts the meaning of a test operator. This can, for example, change the sense of equal ( = ) to not-equal ( != ). The ! operator is a Bash keyword.

In a different context, the ! also appears in indirect variable references.

In yet another context, from the command line, the ! invokes the Bash history mechanism (see Appendix L). Note that within a script, the history mechanism is disabled.
===

*
wild card [asterisk]. The * character serves as a "wild card" for filename expansion in globbing. By itself, it matches every filename in a given directory.

bash$ echo *
abs-book.sgml add-drive.sh agram.sh alias.sh
	      

The * also represents any number (or zero) characters in a regular expression.

** A double asterisk can represent the exponentiation operator or extended file-match globbing.

===
Example 10-7. Using parameter substitution and error messages

#!/bin/bash

#  Check some of the system's environmental variables.
#  This is good preventative maintenance.
#  If, for example, $USER, the name of the person at the console, is not set,
#+ the machine will not recognize you.

: ${HOSTNAME?} ${USER?} ${HOME?} ${MAIL?}
  echo
  echo "Name of the machine is $HOSTNAME."
  echo "You are $USER."
  echo "Your home directory is $HOME."
  echo "Your mail INBOX is located in $MAIL."
  echo
  echo "If you are reading this message,"
  echo "critical environmental variables have been set."
  echo
  echo

# ------------------------------------------------------

#  The ${variablename?} construction can also check
#+ for variables set within the script.

ThisVariable=Value-of-ThisVariable
#  Note, by the way, that string variables may be set
#+ to characters disallowed in their names.
: ${ThisVariable?}
echo "Value of ThisVariable is $ThisVariable".

echo; echo


: ${ZZXy23AB?"ZZXy23AB has not been set."}
#  Since ZZXy23AB has not been set,
#+ then the script terminates with an error message.

# You can specify the error message.
# : ${variablename?"ERROR MESSAGE"}


# Same result with:   dummy_variable=${ZZXy23AB?}
#                     dummy_variable=${ZZXy23AB?"ZXy23AB has not been set."}
#
#                     echo ${ZZXy23AB?} >/dev/null

#  Compare these methods of checking whether a variable has been set
#+ with "set -u" . . .



echo "You will not see this message, because script already terminated."

HERE=0
exit $HERE   # Will NOT exit here.

# In fact, this script will return an exit status (echo $?) of 1.
===
?
test operator. Within certain expressions, the ? indicates a test for a condition.


In a double-parentheses construct, the ? can serve as an element of a C-style trinary operator. [2]

condition?result-if-true:result-if-false

(( var0 = var1<98?9:21 ))
#                ^ ^

# if [ "$var1" -lt 98 ]
# then
#   var0=9
# else
#   var0=21
# fi
===

===
Example 5-2. Escaped Characters

#!/bin/bash
# escaped.sh: escaped characters

#############################################################
### First, let's show some basic escaped-character usage. ###
#############################################################

# Escaping a newline.
# ------------------

echo ""

echo "This will print
as two lines."
# This will print
# as two lines.

echo "This will print \
as one line."
# This will print as one line.

echo; echo

echo "============="


echo "\v\v\v\v"      # Prints \v\v\v\v literally.
# Use the -e option with 'echo' to print escaped characters.
echo "============="
echo "VERTICAL TABS"
echo -e "\v\v\v\v"   # Prints 4 vertical tabs.
echo "=============="

echo "QUOTATION MARK"
echo -e "\042"       # Prints " (quote, octal ASCII character 42).
echo "=============="



# The $'\X' construct makes the -e option unnecessary.

echo; echo "NEWLINE and (maybe) BEEP"
echo $'\n'           # Newline.
echo $'\a'           # Alert (beep).
                     # May only flash, not beep, depending on terminal.

# We have seen $'\nnn" string expansion, and now . . .

# =================================================================== #
# Version 2 of Bash introduced the $'\nnn' string expansion construct.
# =================================================================== #

echo "Introducing the \$\' ... \' string-expansion construct . . . "
echo ". . . featuring more quotation marks."

echo $'\t \042 \t'   # Quote (") framed by tabs.
# Note that  '\nnn' is an octal value.

# It also works with hexadecimal values, in an $'\xhhh' construct.
echo $'\t \x22 \t'  # Quote (") framed by tabs.
# Thank you, Greg Keraunen, for pointing this out.
# Earlier Bash versions allowed '\x022'.

echo


# Assigning ASCII characters to a variable.
# ----------------------------------------
quote=$'\042'        # " assigned to a variable.
echo "$quote Quoted string $quote and this lies outside the quotes."

echo

# Concatenating ASCII chars in a variable.
triple_underline=$'\137\137\137'  # 137 is octal ASCII code for '_'.
echo "$triple_underline UNDERLINE $triple_underline"

echo

ABC=$'\101\102\103\010'           # 101, 102, 103 are octal A, B, C.
echo $ABC

echo

escape=$'\033'                    # 033 is octal for escape.
echo "\"escape\" echoes as $escape"
#                                   no visible output.

echo

exit 0
===
()
command group.
(a=hello; echo $a)

Important	
A listing of commands within parentheses starts a subshell.

Variables inside parentheses, within the subshell, are not visible to the rest of the script. The parent process, the script, cannot read variables created in the child process, the subshell.
a=123
( a=321; )	      

echo "a = $a"   # a = 123
# "a" within parentheses acts like a local variable.

array initialization.
Array=(element1 element2 element3)

===
{xxx,yyy,zzz,...}
Brace expansion.
echo \"{These,words,are,quoted}\"   # " prefix and suffix
# "These" "words" "are" "quoted"


cat {file1,file2,file3} > combined_file
# Concatenates the files file1, file2, and file3 into combined_file.

cp file22.{txt,backup}
# Copies "file22.txt" to "file22.backup"

A command may act upon a comma-separated list of file specs within braces. [5] Filename expansion (globbing) applies to the file specs between the braces.

Caution	
No spaces allowed within the braces unless the spaces are quoted or escaped.

echo {file1,file2}\ :{\ A," B",' C'}

file1 : A file1 : B file1 : C file2 : A file2 : B file2 : C

===
{}
Block of code [curly brackets]. Also referred to as an inline group, this construct, in effect, creates an anonymous function (a function without a name). However, unlike in a "standard" function, the variables inside a code block remain visible to the remainder of the script.

bash$ { local a;
	      a=123; }
bash: local: can only be used in a
function
	      
a=123
{ a=321; }
echo "a = $a"   # a = 321   (value inside code block)

# Thanks, S.C.


The code block enclosed in braces may have I/O redirected to and from it.
===
{}
Block of code [curly brackets]. Also referred to as an inline group, this construct, in effect, creates an anonymous function (a function without a name). However, unlike in a "standard" function, the variables inside a code block remain visible to the remainder of the script.

bash$ { local a;
	      a=123; }
bash: local: can only be used in a
function
	      
a=123
{ a=321; }
echo "a = $a"   # a = 321   (value inside code block)

# Thanks, S.C.


The code block enclosed in braces may have I/O redirected to and from it.

Example 3-1. Code blocks and I/O redirection

#!/bin/bash
# Reading lines in /etc/fstab.

File=/etc/fstab

{
read line1
read line2
} < $File

echo "First line in $File is:"
echo "$line1"
echo
echo "Second line in $File is:"
echo "$line2"

exit 0

# Now, how do you parse the separate fields of each line?
# Hint: use awk, or . . .
# . . . Hans-Joerg Diers suggests using the "set" Bash builtin.
===

Example 3-2. Saving the output of a code block to a file

#!/bin/bash
# rpm-check.sh

#  Queries an rpm file for description, listing,
#+ and whether it can be installed.
#  Saves output to a file.
# 
#  This script illustrates using a code block.

SUCCESS=0
E_NOARGS=65

if [ -z "$1" ]
then
  echo "Usage: `basename $0` rpm-file"
  exit $E_NOARGS
fi  

{ # Begin code block.
  echo
  echo "Archive Description:"
  rpm -qpi $1       # Query description.
  echo
  echo "Archive Listing:"
  rpm -qpl $1       # Query listing.
  echo
  rpm -i --test $1  # Query whether rpm file can be installed.
  if [ "$?" -eq $SUCCESS ]
  then
    echo "$1 can be installed."
  else
    echo "$1 cannot be installed."
  fi  
  echo              # End code block.
} > "$1.test"       # Redirects output of everything in block to file.

echo "Results of rpm test in file $1.test"

# See rpm man page for explanation of options.

exit 0
Note	
Unlike a command group within (parentheses), as above, a code block enclosed by {braces} will not normally launch a subshell. [6]

It is possible to iterate a code block using a non-standard for-loop.

===

{}
placeholder for text. Used after xargs -i (replace strings option). The {} double curly brackets are a placeholder for output text.

ls . | xargs -i -t cp ./{} $1
#            ^^         ^^

# From "ex42.sh" (copydir.sh) example.
===

$[ ... ]
integer expansion.

Evaluate integer expression between $[ ].
a=3
b=7

echo $[$a+$b]   # 10
echo $[$a*$b]   # 21

Note that this usage is deprecated, and has been replaced by the (( ... )) construct.

===

command &>filename redirects both the stdout and the stderr of command to filename.
This is useful for suppressing output when testing for a condition. For example, let us test whether a certain command exists.

bash$ type bogus_command &>/dev/null



bash$ echo $?
1
===

 [j]<>filename
      #  Open file "filename" for reading and writing,
      #+ and assign file descriptor "j" to it.
      #  If "filename" does not exist, create it.
      #  If file descriptor "j" is not specified, default to fd 0, stdin.
      #
      #  An application of this is writing at a specified place in a file. 
      echo 1234567890 > File    # Write string to "File".
      exec 3<> File             # Open "File" and assign fd 3 to it.
      read -n 4 <&3             # Read only 4 characters.
      echo -n . >&3             # Write a decimal point there.
      exec 3>&-                 # Close fd 3.
      cat File                  # ==> 1234.67890
      #  Random access, by golly.
===
     
<<<
redirection used in a here string.


# Instead of:
if echo "$VAR" | grep -q txt   # if [[ $VAR = *txt* ]]
# etc.

# Try:
if grep -q "txt" <<< "$VAR"
then   #         ^^^
   echo "$VAR contains the substring sequence \"txt\""
fi
# Thank you, Sebastian Kaminski, for the suggestion.
===

>|
force redirection (even if the noclobber option is set). This will forcibly overwrite an existing file.
===

&
Run job in background. A command followed by an & will run in the background.

bash$ sleep 10 &
[1] 850
[1]+  Done                    sleep 10

====

-
option, prefix. Option flag for a command or filter. Prefix for an operator. Prefix for a default parameter in parameter substitution.

COMMAND -[Option1][Option2][...]

ls -al

sort -dfu $filename

if [ $file1 -ot $file2 ]
then #      ^
  echo "File $file1 is older than $file2."
fi

if [ "$a" -eq "$b" ]
then #    ^
  echo "$a is equal to $b."
fi

if [ "$c" -eq 24 -a "$d" -eq 47 ]
then #    ^              ^
  echo "$c equals 24 and $d equals 47."
fi


param2=${param1:-$DEFAULTVAL}
#               ^
======
Using set with the -- option explicitly assigns the contents of a variable to the positional parameters. If no variable follows the -- it unsets the positional parameters.

Example 15-18. Reassigning the positional parameters

#!/bin/bash

variable="one two three four five"

set -- $variable
# Sets positional parameters to the contents of "$variable".

first_param=$1
second_param=$2
shift; shift        # Shift past first two positional params.
# shift 2             also works.
remaining_params="$*"

echo
echo "first parameter = $first_param"             # one
echo "second parameter = $second_param"           # two
echo "remaining parameters = $remaining_params"   # three four five

echo; echo

# Again.
set -- $variable
first_param=$1
second_param=$2
echo "first parameter = $first_param"             # one
echo "second parameter = $second_param"           # two

# ======================================================

set --
# Unsets positional parameters if no variable specified.

first_param=$1
second_param=$2
echo "first parameter = $first_param"             # (null value)
echo "second parameter = $second_param"           # (null value)

exit 0

=====

-
redirection from/to stdin or stdout [dash].
=====

-mtime N means files whose age A in days satisfies N ≤ A < N+1. In other words, -mtime N selects files that were last modified between N and N+1 days ago.

-mtime -N means files whose age A satisfies A < N, i.e. files modified less than N days ago. Less intuitively, -mtime +N means files whose age A satisfies N+1 ≤ A, i.e. files modified at least N+1 days ago.

For example, -mtime 1 selects files that were modified between 1 and 2 days ago. -mtime +1 selects files that were modified at least 2 days ago. To get files modified at least 1 day ago, use -mtime +0.

The description “was last modified n*24 hours ago” is only an approximation, and not a very clear one.

If you find these rules hard to remember, use a reference file instead.

touch -d '1 day ago' cutoff
find . -newer cutoff

=====

Fractional 24-hour periods are truncated! That means that “find -mtime +1” says to match files modified two or more days ago.

find . -mtime +0 # find files modified greater than 24 hours ago
find . -mtime 0 # find files modified between now and 1 day ago
# (i.e., in the past 24 hours only)
find . -mtime -1 # find files modified less than 1 day ago (SAME AS -mtime 0)
find . -mtime 1 # find files modified between 24 and 48 hours ago
find . -mtime +1 # find files modified more than 48 hours ago
The following may only work on GNU?

find . -mmin +5 -mmin -10 # find files modified between
# 6 and 9 minutes ago
find / -mmin -10 # modified less than 10 minutes ago

=====






