const Flickr = require('flickrapi');
const flickrConfig = require('./flickr_config');

function search(query, callback) {
    Flickr.tokenOnly(flickrConfig.flickrOptions, (error, flickr) => {
        if (error) {
            callback(error, null)
        }
        flickr.photos.search({
            text: query,
            tag: query,
            page: 1,
            per_page: 10,
            sort: "relevance"
        }, (error, results) => {
            let photosArray = [];
            let photos = results.photos.photo;
            for (let i in photos) {
                if (photos.hasOwnProperty(i)) {
                    let title = photos[i].title;
                    let url = "https://farm" + photos[i].farm + ".staticflickr.com/" +
                        photos[i].server + "/" + photos[i].id + "_" +
                        photos[i].secret + ".jpg";
                    let source = "flickr";
                    let photo = {
                        title: title,
                        url: url,
                        source: source
                    };
                    photosArray.push(photo);
                }
            }
            callback(null, photosArray);
        })
    });
}

exports.search = search;