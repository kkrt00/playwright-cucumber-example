var features;
var common;
const parameters = JSON.parse(process.env.CUCUMBERPARAMS);

if (parameters['scenario'] === 'smoke') {
    features = `scripts/**/smoke.feature`;
}
else {
    features = `scripts/**/*.feature`;
}

if (parameters['lang'] === 'js') {
common = ` 
  --require scripts/config.js
  --require scripts/steps_definitions.js
  `;
}
else {
common = ` 
  --require scripts/config.ts
  --require scripts/steps_definitions.ts
  --require scripts/myglobal.ts
  --require-module ts-node/register
  `;
}

module.exports = {
      default: `${common} ${features}`
};
