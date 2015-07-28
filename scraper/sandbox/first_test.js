var
  casper = require('casper').create();

casper.start('http://www.google.com', function () {
  this.echo(this.getTitle());
});

casper.run();
