const express = require('express');
const logger = require('morgan');
const app = express();
const port = process.env.PORT || 3000;

app.use(logger('short'));

app.get('/', (req, res) => {
    res.send("Hello flickr api server");
});

app.get('/:name', (req, res) => {
    res.send("Hello" + req.params.name + "~~");
});

app.listen(port, () => {
    console.log(`Listening on port ${port}`);
});