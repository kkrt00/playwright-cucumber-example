import { expect } from "chai";
import { Given, Then, When } from "cucumber";

declare var page: any;
declare var headless: string;
declare var webrowser: string;
declare var mainpage: string;

/**** Functions ****/
class PageActions {
    
    async getProperty(selector,attribute,type) {
	if (type === 'attribute') {
	    return await page.$eval("xpath="+selector, (element, attribute) => element.getAttribute(attribute), attribute);
	}
	else {
	     return await page.$eval("xpath="+selector, (element, attribute) => element[attribute], attribute);
	}
    }
    
    async navigateTo(link){
	if(link === 'homepage') {
	    link = mainpage;
	}
	return await page.goto(link);
    }
    
    async clickOn(element) {
	return await page.click("//*[text()='"+element+"']");
    }
    
    async inputData(input) {
	return await page.type('[name=number]', input);
    }
    
    async verifyResponse(link) {
	var responsestatus;
        await page.on('response',response => {
	   responsestatus = response.status();
	});
	if(link === 'homepage') {
	   link = mainpage;
	}
       await page.goto(link);
       expect(responsestatus).to.equal(200);
    }
    
    async verifyCalcResultMsg(msg) {
	const test = await page.waitForSelector("xpath=//*[contains(@style,'color: rgb')]", {timeout: 2000});
	const result = await this.getProperty("//*[@id='resultDiv']",'innerText','a');
	expect(result).to.equal(msg);
    }
    
    async verifyTextonPage(text) {
	expect(await this.getProperty("//*[contains(text(),'"+text+"')]",'innerText','aa')).to.not.be.null;

    }
    
    async verifyLayout() {
	await page.setViewport({width:1280,height:800});
	const currentlayout = await page.screenshot();
	var fs = require('fs');
	var ff = '';
	if (webrowser === 'firefox') ff = 'ff_';
	if (headless){
	    var layout = fs.readFileSync('scripts/data/'+ ff + 'layout_headless.png');
	}
	else{
	    var layout = fs.readFileSync('scripts/data/'+ ff + 'layout.png');
	}
	expect(currentlayout).to.deep.equal(layout);
    }
}

const pageAction = new PageActions();

/**** Steps definitions  ****/

Given('Navigate to the {string}', async function(link) {
  await pageAction.navigateTo(link);
});

When('Click on {string}', async function(string) {
  await pageAction.clickOn(string);
});

When('Inputing value {string} into Calculate form', async function(input) {
  await pageAction.inputData(input);
});

Then('Verify that {} is loaded', async function(link) {
  await pageAction.verifyResponse(link);
});

Then('Result message is {string}', async function(result_message) {
  await pageAction.verifyCalcResultMsg(result_message);
});

Then('Verify that text {string} exists', async function(string) {
  await pageAction.verifyTextonPage(string);
});

Then('Wait {int}', async function(ms) {
    await new Promise(r => setTimeout(r,ms));
});

Then('Verify layout', async function() {
    await pageAction.verifyLayout();
});
