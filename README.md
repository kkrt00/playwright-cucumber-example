# playwright-cucumber-example
Portable and simple example of integration Playwright with Cucumber with Javascript and Typescript
Its using http://qainterview.pythonanywhere.com/ site as a testing platform.

To install on Linux just clone the repository, go the playwright-cucumber-example and run ./start.sh install
To run scenarios just run ./start.sh run
You can also configure execution by chosing which browser should playwright use, which campaign, headless mode and if use JS or TS.
For example to execute only smoke tests on firefox in headless mode with TS just type ./start.sh run firefox smoke headless ts
To get full info about commands of shell script just type ./start.sh help 
