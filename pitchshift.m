function [ psSamples ] = pitchshift( audioSamples, octave )
%PITCHSHIFT shifts pitch up or down.
%   Input:
%       audioSamples - samples obtained from audioread()
%       octave - >0 octave to shift up, <0 octave to shift down
%   Output:
%       psSamples - pitch shifted samples.

stretchFactor = 2^round(octave);
stretchedSamples = stretch(audioSamples,stretchFactor);
[r,d] = rat(stretchFactor);
len = size(audioSamples,1);
psSamples = resample(stretchedSamples,d,r);
psSamples = psSamples(1:len,:);
end

