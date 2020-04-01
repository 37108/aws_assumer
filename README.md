# aws_assumer
easy way to switch IAM Role

## Prerequirement
- bash
- fzf
- gnu grep

## Setting
1. add [`_assume.sh`](/assume.sh) anywhere
2. modify [`_assume.sh`](/assume.sh)
  - change SERIAL_NUMBER
  - change SOURCE_PROFILE

3. create an alias like this.
  ```
  alias assume='source /path/to/_assume'
  ```
4. reload your .bash_profile
  ```
  source ~/.bash_profile
  ```
