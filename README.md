# PV
A Phase Vocoder based on LabView and MatLab

This is an implementation of Phase-Vocoder in LabView. In the program, user can load an audio file, then playback, stretch/compress and pitch shift it. Ultimately user can then choose to write the modified sound to disk.

## License
This software is distributed under GNUv2 License. For more information, please visit
https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html.

## How to start this software
1. Make sure you have installed LabView 2017 from National Instrument. You can evaluate the software for 30 days.
2. Make sure you have installed MatLab 2015b or newer version. The software requires MatLab server running in the background.
3. After downloading from the repository, open MatLab.
4. After MatLab is opened, double-click pitchVI.vi file to open it in LabView.
5. Click run on LabView front panel to start the program.
<br/><img src="https://github.com/jouyang3/pv/blob/master/images/RunLabView.PNG" width="500">

## How to use this software
### Loading an audio file
First you have to open the audio file. User can perform this action by clicking the button next to the 'file to load' button. Acceptable file formats are 
*. WAVE (.wav)
*. OGG (.ogg)
*. FLAC (.flac)
*. AU (.au)
*. AIFF (.aiff, .aif)
*. AIFC (.aifc)
*. MP3 (.mp3)
*. MPEG-4 AAC (.m4a, .mp4)
<br/><img src="https://github.com/jouyang3/pv/blob/master/images/FP-Violin.PNG" width="500">

### Time-Stretching/Compressing audio file
User has the option to make the file N times shorter or longer. Perform this by 
1. specifying number N in the 'Stretch Ratio' field.
2. clicking the 'Stretch' button.
<br/><img src="https://github.com/jouyang3/pv/blob/master/images/FP-ViolinLong.PNG" width="500">

### Pitch-shifting audio file
User also has the option to make the file an Octave (O) higher or lower than the current audio. An Octave up is 2x the current frequencies and an octave down is 0.5x the current frequencies. Perform this by 
1. specifying number (O) in the 'Pitch Shift (Octave)' field.
2. clicking the 'Shift' button.
<br/><img src="https://github.com/jouyang3/pv/blob/master/images/FP-ViolinHigh.PNG" width="500">

### Playback the modified sound
After making changes accordingly, the user can also playback the sound. Click the 'Play Signal' to playback and 'Stop Playback' to end the session.
<br/><img src="https://github.com/jouyang3/pv/blob/master/images/FP-Playback.PNG" width="500">

### Clearing the Signal
If user is unhappy with the modifications, user can clear the signal via the 'Clear Signal' button. Note that this will clear out the audio loaded in the memory and the user have to manual load the file again.
<br/><img src="https://github.com/jouyang3/pv/blob/master/images/FP-Clear.PNG" width="500">

### Saving the file
After user is satisfied with the changes, he/she can write to the disk by clicking the 'SAVE TO FILE' button. The file dialog will pop-up and user change choose where to save the file. The file will ALWAYS be written as a WAVE (.wav) file. 
<br/><img src="https://github.com/jouyang3/pv/blob/master/images/FP-Save.PNG" width="500">
<br/><img src="https://github.com/jouyang3/pv/blob/master/images/FP-SaveFD.PNG" width="500">

## Developing on the software

### Working on LabView
One can investigate the source-code of the VI and make modifications by selecting [Window] > [Show Block Diagram] in the front panel of LabView program. The program has an Event-Driven structure. The phase-vocoding are all performed in MatLab using the MatLab script node block.

### Working on MatLab
Alternatively, one can incorporate the supplied 'stretch.m' and 'pitchshit.m' functions to their own program. 

#### The STRETCH function
STRETCH stretching or compressing input signals.
   ##### Inputs:
       1. audioSamples - samples read from audioread()
       2. stretchFactor - >1 stretching, <1 compressing.
   ##### Outputs:
       1. stretchedSamples - stretched/compressed audio samples.

#### The PITCHSHIFT function
PITCHSHIFT shifts pitch up or down.
   ##### Input:
       1. audioSamples - samples obtained from audioread()
       2. octave - >0 octave to shift up, <0 octave to shift down
   ##### Output:
       1. psSamples - pitch shifted samples.

## Reference
[[1] TRADITIONAL IMPLEMENTATIONSOF A PHASE-VOCODER: THE TRICKS OF THE TRADE.](http://www.cs.princeton.edu/courses/archive/spr09/cos325/Bernardini.pdf)

[[2] Phase-Vocoder: About this phasiness business](https://www.ee.columbia.edu/~dpwe/papers/LaroD97-phasiness.pdf).

## Authorship
Jun D. Ouyang [jdouyang@ucdavis.edu](mailto://jdouyang@ucdavis.edu)
