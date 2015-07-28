/*
 * Takes in a file, sorts its lines alphabetically. Finds and outputs items that are
 * not found in completed_file. Updates completed_file.
 * Author: Eddie Lu
 * Date: 07/24/15
 */
"use strict"
const 
  fs             = require('fs'),
  completed_file = 'completed_things.txt';


/*
 * Takes an array and file name. Prints out items in file name and in
 * completed_file.
 */ 
function writeLinesInOrder(items, newfile) {
  let writeLine = function(i) {
    if (i >= items.length) {
      return;
    }
    else if (items[i].trim() == "") {
      writeLine(i+1);
    }
    else {
      let line = items[i].trim().toLocaleLowerCase() + '\n';
      fs.appendFile(newfile, line, function(err) {
        throw new Error("Append to " + newfile + " file error");
      }, function callback() {
        writeLine(i+1);
      });
    }
  };
  writeLine(0);
  return;
}


/* 
 * Determine if appropriate command line args have been provided.
 * Determine new file name.
 */
function checkArgs() {
  
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
  
  return newfile;
}


/*
 * Find unique/new items in the provided file. Output these items into a new file.
 * Finally, update completed_things to contain these items/terms.
 */ 
function main() {
  
  // File name to write results to
  let newfile = checkArgs();
  // Contains completed items (i.e. terms that have already been scraped for)
  let completed = fs.readFileSync(completed_file).toString();
  let completed_new = completed.split('\n');

  // Read a file, sort the lines, output to a new file
  fs.readFile(process.argv[2], function(err, data) {
    if (err) {
      console.log("Error reading " + process.argv[2]);
      process.exit(1);
    }
    else {
      let text = data.toString();
      let items = text.split('\n');
      items.sort();

      // Remove duplicates
      let uniqueItems = [];
      let lastItem = '';
      for (let i = 0; i < items.length; i++) {
        if (lastItem.trim().toLocaleLowerCase() != items[i].trim().toLocaleLowerCase() && items[i] != "" && completed.indexOf(items[i].trim().toLocaleLowerCase()) == -1) {
          uniqueItems.push(items[i].trim().toLocaleLowerCase());
          completed_new.push(items[i].trim().toLocaleLowerCase());
          lastItem = items[i];
        }
      }
      uniqueItems.sort();        //TODO: double sort is inefficient.
      completed_new.sort();

      // Write sorted and unique items to newfile
      fs.writeFile(newfile, '', function(err) {
        console.log("Error clearing " + newfile);
        process.exit(1);
      }, function callback() {
        writeLinesInOrder(uniqueItems, newfile);
        console.log("Successfully written to " + newfile);
      });
      
      // Update completed_file to contain new elements
      fs.writeFile(completed_file, '', function(err) {
        console.log("Error clearing " + completed_file);
        process.exit(1);
      }, function callback() {
        writeLinesInOrder(completed_new, completed_file);
        console.log("Done! Successfully updated " + completed_file);
      });

    }
  });
}

main();
