# Scraper

- - -

## Overview
Secret-Sounds-of-Summer's scraper uses Node.js and CasperJS to download
free audio clips from Freesound.org. These clips are then used to train
the Secret-Sounds-of-Summer's recognizer.
**Dependencies**
1. Node.js
2. PhantomJS
3. CasperJS
4. credentials.txt (containing user/pass combination to Freesound.org)

- - -

## How to Use
Before starting, make sure you have Dependencies 1-3 installed. Then,
create a user account at
[Freesound.org](https://www.freesound.org/home/register/). A user
account is required to download audio clips from Freesound. Save your
username and password into a new file called *credentials.txt*. The first
line should contain your username. The second line should contain your
password.

Then, create a new text file containing search terms, one search term
per line. Then run,
  ./process.sh searchterms.txt
This will compare the terms in searchterms.txt with those in
completed_things.txt. It will add new terms to completed_things.txt and
then go out to Freesound.org and download the first three audio clips it
finds with that new search term. (Note that currently it will only grab
2-channel .mp3 files with a 44100 Hz sample rate. To look for all audio
clips, you can change the search link in freesound_scraper.js).

Currently, completed_things.txt contains all search terms that I
(eddielu) have already searched and scraped for. If you are scraping
from scratch, make sure to indicate that by deleting all terms in
completed_things.txt (i.e. starting with an empty completed_things.txt
file)

The downloaded clips will be stored in a sounds/ folder created after
process.sh has finished running.

