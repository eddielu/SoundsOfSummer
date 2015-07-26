/*
 * Takes in a file, sorts its lines alphabetically and prints out the results.
 * Author: Eddie Lu
 * Date: 07/24/15
 */
"use strict"
const fs = require('fs');


// File must be given
if (process.argv.length < 3) {
  console.log("File to be sorted must be provided");
  process.exit(1);
}

// Determine new file name
let newfile = "sorted_" + process.argv[2];
if (process.argv.length > 3) {
  newfile = process.argv[3];
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
  
// Read a file, sort the lines, output to a new file
fs.readFile(process.argv[2], function(err, data) {
  if (err) {
    console.log("Something went wrong...")
  }
  else {
    let text = data.toString();
    let items = text.split('\n');
    items.sort();

    // Remove duplicates
    let uniqueItems = [];
    let lastItem = '';
    for (let i = 0; i < items.length; i++) {
      if (lastItem.trim().toLocaleLowerCase() != items[i].trim().toLocaleLowerCase()) {
        uniqueItems.push(items[i].trim().toLocaleLowerCase());
        lastItem = items[i];
      }
    }
    uniqueItems.sort();
      
    // Write to file
    fs.writeFile(newfile, '', function(err) {
      throw new Error('Write(clear) file error');
    }, function callback() {
      writeLinesInOrder(uniqueItems, newfile);
      console.log("Done! Successfully written to " + newfile);
    });

  }
});
