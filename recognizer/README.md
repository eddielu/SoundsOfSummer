# Recognizer

## Overview
Secret-Sounds-of-Summer processes audio clips, training itself to recognize a wide
variety of different sounds. The algorithm dervies from the Fourier transform algorithm
used by Shazam, whereby a signal is fingerprinted based on its peaks in the
time **and** frequency domains. The algorithm has been implemented from scratch with
additional considerations, such as repetition capturing and 
These additional sound processing techniques allow for more accurate recognition of 
shorter and more disparate sound signals.

Currently, Secret-Sounds-of-Summer's recognizer has been trained with over thousands of 
audio clips scraped from the web. Although it is far from perfect, it provides a solid
foundation to build upon. This initial version of the algorithm is currently 
implemented in Matlab because of Matlab's strong signal processing tools/libraries. A
more industry-friendly version in python (which will hopefully incorporate neural networks)
is currently in development.

## How to Use
First, download some audio clips to train the algorithm with. A description of each audio
clip should be reflected in its respective file name. Copy all audio clips into a folder
named `sounds_master`.

Next, we will create our database of fingerprints for each audio clip. Do so by running:
```
make_database
```
with Matlab. This will generate `SONGID.mat` and `HASHTABLE.mat`.

Next, test that everything is working by running:
```
myshazam
```
By default, this randomly selects one of the audio clips in `sounds_master` as input and tries to recognize
the sound based on clips within the database. Naturally, the same audio clip name should be found. 

**Now, let's do something more interesting:** To start 
experimenting with outside sounds, set `recordingOn` within `myshazam.m` to 
```
recordingOn = 1;
```
This will make myshazam use the sound recorded by your computer's microphone as input into
the algorithm. Try making different sounds, such as pen tapping, crumpling paper, or clapping, and 
see if the algorithm has been trained well enough to recognize these sounds! :)
