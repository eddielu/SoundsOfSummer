var casper      = require('casper').create();
var fs          = require('fs');

// Get items to find sound clips for
var file        = casper.cli.raw.get(0);
var items       = fs.read(file).toString().split('\n');
// Get login credentials for Freesound.org
var credentials = fs.read('credentials.txt').toString().split('\n');
var username    = credentials[0];
var password    = credentials[1];



casper.on("remote.message", function(message) {
  this.echo("remote console.log: " + message);
});


// For each item in list, look for audio clips and grab the links to the clips
function scrapeItem(i) {
  //casper.echo("Calling scrapeItem");
  if (i == 0) {
        // First, log in to Freesound.org
    casper.start('https://www.freesound.org/home/login/?next=/', function() {
      this.fill('form[action="."]', {
        'username': username,
        'password': password
      }, true);
    });

    // Wait for login to complete
    casper.waitFor(function check() {
      return this.getTitle().trim() == 'Freesound.org - Freesound.org'
    }, function then() {
      this.echo("Successfully logged on!");
    }, function timeout() {
      this.echo("Timeout while trying to log in");
    });
  }


  var url = "";
  casper.then(function() {
    var query = items[i].split(' ').join('+');
    url = 'https://www.freesound.org/search/?q=' + query;
  });

  casper.thenOpen(url);

  // Get the first few links to audio clips for each query
  var links_to_files = [];
  casper.then(function() {
    console.log("I just opened: " + url);
    links_to_files = casper.evaluate(function() {
      var links = [];
      // Get the first 3 links
      var alinks = document.querySelectorAll('.title'); 
      if (alinks.length >= 1) {
        links.push(alinks[0].href);
      }
      if (alinks.length >= 2) {
        links.push(alinks[1].href);
      }
      if (alinks.length >= 3) {
        links.push(alinks[2].href);
      }
      console.log(links);
      return links;
    });
  });


  // Download the audio clips found
  function downloadLinks(j) {
    //casper.echo("Calling downloadLinks");
    casper.thenOpen(links_to_files[j]);
    casper.then(function() {
      var download_link = casper.evaluate(function() {
          return document.getElementById('download_button').href;
      });
      var path = download_link.split('/');
      var filename = 'sounds/' +  path[path.length-1];
      if (filename.indexOf('.wav') != -1 || filename.indexOf('.mp3') != -1) {
        console.log("Downloading... " + download_link);
        casper.download(download_link, filename);
      }
    });
    if (j < links_to_files - 1) {
      downloadLinks(j+1);
    }
  };
  downloadLinks(0);

  if (i < items.length - 1) {
    scrapeItem(i+1);
  }
};
scrapeItem(0);



casper.run(function () {
    setTimeout(function() {
        phantom.exit();
    }, 0);
});
