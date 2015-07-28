var casper  = require('casper').create();
var fs      = require('fs');

var credentials = fs.read('credentials.txt').toString().split('\n');
var username = credentials[0].trim().toLocaleLowerCase();
var password = credentials[1].trim().toLocaleLowerCase();

casper.start('http://freesound.org/home/login/?next=/', function then() {
  casper.fill('form[action="."]', {
    'username': username,
    'password': password
  }, true);
});

casper.waitFor(function check() {
  return this.getTitle().trim() == 'Freesound.org - Freesound.org';
}, function then() {
  this.echo("Successfully logged on!");
}, function timeout() {
  this.echo("Login was not successful. Current title is: " + this.getTitle().trim());
});

casper.thenOpen('http://freesound.org/people/philip1789/sounds/244370/', function then() {
  var download_link = casper.evaluate(function() {
    return document.getElementById('download_button').href;
  });
  console.log(download_link);
  var path = download_link.split('/');
  var filename = 'sounds/' + path[path.length-1];
  casper.download(download_link, filename);
});


casper.run(function () {
    setTimeout(function() {
        phantom.exit();
    }, 0);
});
