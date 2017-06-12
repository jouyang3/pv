function [ stretchedSamples ] = stretch( audioSamples, stretchFactor )
%STRETCH Phase Vocoding - stretching or compressing input signals.
%   Inputs:
%       audioSamples - samples read from audioread()
%       stretchFactor - >1 stretching, <1 compressing.
%   Outputs:
%       stretchedSamples - stretched/compressed audio samples.

audioLen = length(audioSamples);
windowLen = 1024;
analysisLen = 128;
synthesisLen = round(128*stretchFactor);
assert(windowLen > synthesisLen);

channels = size(audioSamples,2);

window = hamming(windowLen);
window = repmat(window,1,channels);
unwrapdata = 2*pi*analysisLen*(0:windowLen-1)'/windowLen;
unwrapdata = repmat(unwrapdata,1,channels);
frameAngle = zeros(windowLen,channels);

prevSynOverlap = zeros(windowLen - synthesisLen,channels);

numSynSamples = round(audioLen*stretchFactor);
stretchedSamples = zeros(numSynSamples,channels);

index = 1;
synIdex = 1;
iteration = 0;

numIter = ceil(audioLen/analysisLen);
while index<audioLen
    
    iteration = iteration+1;
    
    prevFrameAngle = frameAngle;
    
    if index+windowLen < audioLen
        frame = audioSamples(index:(index+windowLen-1),:);
    else
        frame = [audioSamples(index:end,:);zeros(windowLen+index-audioLen-1,channels)];
    end

    frameTime = window.*frame;
    frameFreq = fft(frameTime);
    
    frameAngle = angle(frameFreq);
    frameMag = abs(frameFreq);
    
    frameAngleUnwrap = frameAngle - prevFrameAngle - unwrapdata;

    frameAngleUnwrap = frameAngleUnwrap - round(frameAngleUnwrap/(2*pi))*2*pi;

    frameAngleUnwrap = (frameAngleUnwrap + unwrapdata)*stretchFactor;

%     frameAngleUnwrap = (frameAngle - prevFrameAngle + unwrapdata)*stretchFactor;
    
    if index == 1
        synAngle = frameAngle;
    else
        synAngle = synAngle + frameAngleUnwrap;
    end
    
%     if iteration == 1
%         figure(1);
%         plot(linspace(-1,1,windowLen),fftshift(unwrap(synAngle(:,1))));
%         title(['Iteration ' num2str(iteration)]);
%         xlabel('\omega/2\pi'); ylabel('\theta (radian)');
%         grid on;
%     end
%     
%     if iteration == round(numIter/2)
%         figure(2);
%         plot(linspace(-1,1,windowLen),fftshift(unwrap(synAngle(:,1))));
%         title(['Iteration ' num2str(iteration)]);
%         xlabel('\omega/2\pi'); ylabel('\theta (radian)');
%         grid on;
%     end
%     
%     if iteration == numIter
%         figure(3);
%         plot(linspace(-1,1,windowLen),fftshift(unwrap(synAngle(:,1))));
%         title(['Iteration ' num2str(iteration)]);
%         xlabel('\omega/2\pi'); ylabel('\theta (radian)');
%         grid on;
%     end
    
    frameSynthFreq = frameMag.*exp(1j*synAngle);
    frameSynthTime = real(ifft(frameSynthFreq)).*window;
    
    synOverlap = frameSynthTime(1:end-synthesisLen,:) + prevSynOverlap;
    synFrame = [synOverlap;frameSynthTime(end-synthesisLen+1:end,:)];
    
    stretchedSamples(synIdex:synIdex+synthesisLen-1,:) = synFrame(1:synthesisLen,:);
    prevSynOverlap = synFrame(synthesisLen+1:end,:);
    index = index+analysisLen;
    synIdex = synIdex+synthesisLen;
end

end

