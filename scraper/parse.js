"use strict"

const fs = require('fs');

if (process.argv.length < 3) {
	console.log("Must provide a file to parse");
	process.exit(1);
}

// Takes an array and file name. Prints out items in file name *in order*
function writeLinesInOrder(items, newfile) {
  let writeLine = function(i) {
    if (i >= items.length) {
      return;
    }
    else {
        fs.appendFile(newfile, items[i] +'\n', function(err) {
          throw new Error('Append file error');
        }, function callback() {
          writeLine(i+1);
        });
    }
  };
  writeLine(0);
  return;
}

let file = process.argv[2];
let newfile = "parsed_" + file;
fs.readFile(file, function(err, data) {
	if (err) {
		console.log("Error reading: " + file);
	}
	else {
		let text = data.toString();
		let items = text.split('\n');
		let parsedItems = [];
		for (let i = 0; i < items.length; i++) {
			if (items[i] != "") {
				parsedItems.push(items[i].split(' ').slice(1).join(' ').trim());
			}
		}
		fs.writeFile(newfile, '', function() {
			writeLinesInOrder(parsedItems, newfile);
		});

	}
});