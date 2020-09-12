const fs = require('fs');

const estate = fs.readFileSync('./90_DummyEstateData');
const chair = fs.readFileSync('./91_DummyChairData');

const estateData = estate.toString().split('\n');
estateData.shift();
const chairData = chair.toString().split('\n');
chairData.shift();

const estateInsertQueries = [];

for (const data of estateData) {
  const [id, feature] = data.split('\t');

  if (data === '') {
    continue;
  }

  if (feature === '') {
    continue;
  }

  const features = feature.split(',');

  for (const feature of features) {
    estateInsertQueries.push(`(${id}, '${feature}')`)
  }
}

// node generate.js > 3_DummyEstateFeaturesData.sql
// console.log(`INSERT INTO isuumo.estate_features (id, feature_name) VALUES ${estateInsertQueries.join(',')};`);

const chairInsertQueries = [];

for (const data of chairData) {
  const [id, feature] = data.split('\t');

  if (data === '') {
    continue;
  }

  if (feature === '') {
    continue;
  }

  const features = feature.split(',');

  for (const feature of features) {
    chairInsertQueries.push(`(${id}, '${feature}')`)
  }
}

// node generate.js > 4_DummyChairFeaturesData.sql
// console.log(`INSERT INTO isuumo.chair_features (id, feature_name) VALUES ${chairInsertQueries.join(',')};`);
