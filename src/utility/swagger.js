const swaggerAutogen = require('swagger-autogen')();

const doc = {
  info: {
    title: 'My API',
    description: 'API documentation',
  },
  host: 'localhost:3000',
  schemes: ['https']
};

const outputFile = './swagger-output.json';
const routes = ['../server.js'];
const endpointsFiles = [
  '../server.js',
  '../router/*.js',
  '../router/**/*.js'
];

function runSwaggerGen() {
//   swaggerAutogen(outputFile, routes, doc).then(() => {
  swaggerAutogen(outputFile, endpointsFiles, doc).then(() => {
    console.log('Swagger documentation generated');
  });
}

runSwaggerGen();

module.exports = { runSwaggerGen };
