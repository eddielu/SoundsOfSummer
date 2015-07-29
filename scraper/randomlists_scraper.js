/*
 * CasperJS script to scrape the random items produced on randomlists.com
 *
 * Author: Eddie Lu
 * Date: 7/29/15
 *
 */

var casper = require('casper').create();

// Enable Remote messaging
//casper.on("remote.message", function(message) {
//  this.echo("remote console.log: " + message);
//});

// Tell randomlists to generate 200 items
casper.start('https://www.randomlists.com/things', function() {
  this.fill('form#options', {
    'qty': '200',
    'dup': false
  }, true);
});

// Wait until the items have been generated, and then output the itmes to stdout
casper.waitFor(function check() {
  return this.evaluate(function() {
    return document.querySelectorAll('li').length >= 200;
  });
}, function then() {
  var items = this.evaluate(function() {
    var picsAndNames = document.querySelectorAll('.name');
    console.log("HELLO " + picsAndNames.length);
    var names = [];
    for (var i = 0; i < picsAndNames.length; i++) {
      console.log("HELLO "+ picsAndNames[i].innerHTML);
      names.push(picsAndNames[i].innerHTML);
    }
    return names;
  });

  for (var i = 0; i < items.length; i++) {
    this.echo(items[i]);
  }
});

// run script
casper.run(function () {
    setTimeout(function() {
        phantom.exit();
    }, 0);
});
