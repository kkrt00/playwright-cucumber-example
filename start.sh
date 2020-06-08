#!/bin/sh

if [[ "$1" == "install" ]]; then

    wget https://nodejs.org/dist/v12.17.0/node-v12.17.0-linux-x64.tar.xz
    tar -xJvf node-v12.17.0-linux-x64.tar.xz
    export PATH=$(pwd)/node-v12.17.0-linux-x64/bin:$PATH

    mkdir -p solution/scripts/data/
    mv cucumber.js solution/
    pathtemp=$(pwd)
    mv scripts/data/*.png solution/scripts/data/
    cd scripts
    mv *.js *.feature *.ts $pathtemp/solution/scripts/
    cd ..
    cd solution

    ### JS
    npm i cucumber chai
    ### TS
    npm i typescript ts-node @types/chai @types/cucumber @types/node
    PLAYWRIGHT_BROWSERS_PATH=0 npm i playwright

exit
elif [[ "$1" == "run" ]]; then
    
    pathvar='{"browser":"chromium","headless":false,"scenario":"all","lang":"js"}'
    if [[ "${@:2}" =~ "firefox" ]]; then
	pathvar="${pathvar/chromium/firefox}"   
    fi
    if [[ "${@:2}" =~ "headless" ]]; then
	pathvar="${pathvar/false/true}"   
    fi
    if [[ "${@:2}" =~ "smoke" ]]; then
	pathvar="${pathvar/all/smoke}"   
    fi
    if [[ "${@:2}" =~ "ts" ]]; then
	pathvar="${pathvar/js/ts}"   
    fi

    export CUCUMBERPARAMS=$pathvar
    export PLAYWRIGHT_BROWSERS_PATH=0
    export PATH=$(pwd)/node-v12.17.0-linux-x64/bin:$PATH
    cd solution
    ./node_modules/.bin/cucumber-js 
exit
elif [[ "$1" == "help" ]]; then

    echo
    echo Pass arguments for options: 
    echo --install"  "to run installation
    echo --run"      "to execute with default configuration
    echo run command can be configured with commands 
    echo "	"--headless"  "turn on headless mode, default:off
    echo "	"--firefox"   "use firefox, default: chromium 
    echo "	"--smoke"     "run smoke tests, default: all
    echo
    echo run configuration examples: ./start run firefox headless
    echo "                            "./start run smoke headless
    echo 
    echo --uninstall"  "to clear all files and directories
    echo --help"       "to get this message
    echo

exit    
elif [[ "$1" == "uninstall" ]]; then
    rm -rf solution
    rm -rf node-v*
    rm -f *
fi
