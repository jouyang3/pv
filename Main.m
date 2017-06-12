%% Voilin stretching
clear;
filename = 'Violin.wav';
[audioSamples,Fs] = audioread(filename);

fprintf('Pitch shifting...\n');

synAudio = stretch(audioSamples,2);

player = audioplayer(synAudio,Fs);
% play(player);

%pause;


%% Pitch shifting with overlap
len = size(audioSamples,1);
qtr = round(len/4);

startIdx = qtr+1-13000;
endIdx = 3*qtr+22000;
overlap1 = 20000;
overlap2 = 50000;
segment = audioSamples(startIdx:endIdx-1+overlap2,:);

Y = pitchshift(segment,-1);
%spectrogram(audioSamples(:,1),hamming(1024),1024-128,1024,'yaxis')

start = audioSamples(1:startIdx-1+overlap1,:);
mid = Y;
trail = audioSamples(endIdx+1:end,:);

trans1 = start(startIdx:end,:)+mid(1:overlap1,:);
trans2 = mid(end-overlap2+1:end,:)+trail(1:overlap2,:);

output = [start(1:startIdx-1,:);...
        trans1;...
        mid(overlap1-1:end-overlap2,:);...
        trans2;...
        trail(overlap2-1:end,:);];
player = audioplayer(output,Fs);
% play(player);

% Pitch shifting and filtering
[songSamples,FsSong] = audioread('24K Magic Hi.wav');
fs = 8000/FsSong; fp = 5000/FsSong;
h = firpm(23, [0,fp/8,fp/4,fp/2,fp,fs,0.5,1],[1,1,1,1,1,0,0,0]);
songOutput = filter(h,1,songSamples);

player = audioplayer(songOutput,Fs);
play(player);
