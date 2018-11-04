const Flickr = require('flickrapi');
const flickrConfig = require('./flickr_config');

Flickr.tokenOnly(flickrConfig.flickrOptions, (error, flickr) => {
    if (error) {
        console.log(error);
    }
    flickr.photos.search({
        text: "Coffee",
        tag: "Coffee",
        page: 1,
        per_page: 10,
        sort: "relevance"
    }, (error, results) => {
        let photosArray = [];
        let photos = results.photos.photo;
        for (let i in photos) {
            let title = photos[i].title;
            let url = "https://farm" + photos[i].farm + ".staticflickr.com/" +
                photos[i].server + "/" + photos[i].id + "_" +
                photos[i].secret + ".jpg";
            let source = "flickr";
            let photo = {
                title: title,
                url: url,
                source: source
            }
            photosArray.push(photo);
        }
        console.log(photosArray);
    })
});
