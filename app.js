const express = require('express');
const logger = require('morgan');
const api = require('./api/flickr');
const app = express();
const port = process.env.PORT || 3000;

app.use(logger('short'));

app.get('/', (req, res) => {
    res.send("Hello flickr api server");
});

app.get('/api/:query', (req, res) => {
    api.search(req.params.query, (error, results) => {
        res.send(results);
    })
});

app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});