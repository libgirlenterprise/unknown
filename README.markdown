# Unknown
Unknown Generator

## Usage
### HTTP GET

- http://localhost:5000/			
    Get the current character.

- http://localhost:5000/normalize     	
    Get number from 0~1. currently it's 0/36, 1/36,...,to 36/36 with 10 decimals

- http://localhost:5000/step/:count
    Replace :count with integer. After triggering this, Unknown Generator changes its state. You can get new unknown then.

### HTTP POST

- http://localhost:5000/next	with parameters
    - **count**
        How many unknown characters separated by comma do you want to get.
    - **data-type**
        Current valid data-type include ``raw``, ``zero-to-36``, and ``normalize``.
    - **input-digit-list**
        Indicate each digit to input after getting an unknown digit. More than enough digits in input-digit-list will be ignored. If digits in input-digit-list is less than ``count``, the generator continues without input interference

- Sample curl command
    ```
    curl --data "count=23&data-type=zero-to-36&input-digit-list=a,a,a,a,a,a,a,a,a,a,a,a" http://localhost:5000/next
    ```

- Sample response
    ```
    25,1,10,10,21,18,28,29,36,26,30,24,29,14,10,10,10,10,10,10,10,10,29
    ```

## Installation
Get roswell https://github.com/roswell/roswell Then
```
ros install sbcl/1.3.16
ros use sbcl/1.3.16
```

Add this in you bash initial file.
```
export PATH=$HOME/.roswell/bin:$PATH
```
Then
```
git clone https://github.com/libgirlenterprise/unknown.git
cd ~/.roswell/local-projects
ln -s [cloned project directory] unknown
cd [cloned project directory]/roswell
ros install unknown
```
You should be able to run.
```
unknown 
```
## Copyright
Copyright (c) 2017 Libgirl Co,.Ltd.

## License
Licensed under the LLGPL License.
# Unknown
Unknown Generator

## Usage
###HTTP GET

http://localhost:5000/			-> get current character

http://localhost:5000/normalize     	-> get number from 0~1. currently it's 0/36, 1/36,...,to 36/36 with 10 decimals

http://localhost:5000/step/:count	-> replace :count with integer. After triggering this, Unknown Generator changes its state. You can get new unknown then.

###HTTP POST

http://localhost:5000/next		-> with parameter "count=[:count]&data-type=[:data-type]&input-digit-list=[:input-digit-list]", you can get next [:count] many unknown characters separated by comma. Current valid :data-type include raw, zero-to-36, and normalize. :input-digit-list indicates each digit to input after getting an unknown digit. More than enough digits in input-digit-list will be ignored. If digits in input-digit-list is less than :count, the generator continues without input interference.

Sample curl command

    curl --data "count=23&data-type=zero-to-36&input-digit-list=a,a,a,a,a,a,a,a,a,a,a,a" http://localhost:5000/next

Sample response

    25,1,10,10,21,18,28,29,36,26,30,24,29,14,10,10,10,10,10,10,10,10,29

###Start Server in terminal

    unknown

## Installation
get roswell https://github.com/roswell/roswell Then

    ros install sbcl/1.3.16
    ros use sbcl/1.3.16

add this in you bash initial file

    export PATH=$HOME/.roswell/bin:$PATH

Then

    git clone https://shakascchen@bitbucket.org/shakascchen/unknown.git
    cd ~/.roswell/local-projects
    ln -s [cloned project directory] unknown
    cd [cloned project directory]/roswell
    ros install unknown

You should be able to run

    unknown 

## License
Libgirl	Co., Ltd. All rights reserved.
