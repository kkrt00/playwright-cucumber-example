const pw = require('playwright');
const { BeforeAll, Before, After, AfterAll } = require('cucumber');

// Configuration variables
const parameters = JSON.parse(process.env.CUCUMBERPARAMS);
global.mainpage = "http://qainterview.pythonanywhere.com/";
global.headless = parameters['headless'];
global.webrowser = parameters['browser'];

// Launch options.
const options = {
  headless: global.headless
};

// Create a global browser
BeforeAll(async () => {
    global.browser = await pw[global.webrowser].launch(options);  
});

AfterAll(async () => {
  await global.browser.close();
});

// Refresh browser context on every test.
Before(async () => {
    global.context = await global.browser.newContext();
    global.page = await global.context.newPage();
});

After(async () => {
  await global.page.close();
  await global.context.close();
});

