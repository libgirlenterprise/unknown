# Unknown
Unknown Generator

## Usage
HTTP GET

http://localhost:5000/			-> get current character

http://localhost:5000/normalize     	-> get number from 0~1. currently it's 0/36, 1/36,...,to 36/36 with 10 decimals

http://localhost:5000/step/:count	-> replace :count with integer. After triggering this, Unknown Generator changes its state. You can get new unknown then.

HTTP POST

http://localhost:5000/next		-> with parameter "count=[:count]&data-type=[:data-type]", you can get next [:count] many unknown characters. Current valid :data-type include raw, zero-36, and normalize.

Start Server in terminal

    unknown

## Installation
get roswell https://github.com/roswell/roswell Then

    ros install sbcl/1.3.16
    ros use sbcl/1.3.16

add this in you bash initial file

    export PATH=$HOME/.roswell/bin:$PATH

Then

    git clone https://shakascchen@bitbucket.org/shakascchen/unknown.git
    ln -s unknown/ ~/.roswell/local-projects/unknown
    cd unknown/roswell
    ros install unknown

You should be able to run
    unknown 

## License
Libgirl	Co., Ltd. All rights reserved.
