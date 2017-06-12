# PV
A Phase Vocoder based on LabView and MatLab

This is an implementation of Phase-Vocoder in LabView. In the program, user can load an audio file, then playback, stretch/compress and pitch shift it. Ultimately user can then choose to write the modified sound to disk.


## How to start this software
1. Make sure you have installed LabView 2017 from National Instrument. You can evaluate the software for 30 days.
2. Make sure you have installed MatLab 2015b or newer version. The software requires MatLab server running in the background.
3. After downloading from the repository, open MatLab.
4. After MatLab is opened, double-click pitchVI.vi file to open it in LabView.
5. Click run on LabView front panel to start the program.
<br/><img src="https://github.com/ucdart/dart-scpi/blob/master/images/RunLabView.png" width="500">

## How to use this software
1. First you have to open the audio file. User can perform this action by clicking the button next to the 'file to load' button. Acceptable file formats are 
.*. WAVE (.wav)
.*. OGG (.ogg)
.*. FLAC (.flac)
.*. AU (.au)
.*. AIFF (.aiff, .aif)
.*. AIFC (.aifc)
.*. MP3 (.mp3)
.*. MPEG-4 AAC (.m4a, .mp4)


## Developing on the software
One can investigate the source-code of the VI and make modifications by selecting [Window] > [Show Block Diagram] in the front panel of LabView program. The program has an Event-Driven structure. The phase-vocoding are all performed in MatLab using the MatLab script node block.

