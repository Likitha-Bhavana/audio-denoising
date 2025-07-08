% Load your noisy audio signal
[cleanAudio,fs] = audioread('sample_audio1.wav');

% Play the clear audio
play1=audioplayer(cleanAudio,fs) % fs is the sampling frequency of your audio
playblocking(play1); % Plays audio1
pause(1); % Wait for 1 second

t=([0:length(cleanAudio)-1])/fs;
subplot(5,1,1);
 plot(t,cleanAudio)
title('Graph of clean audio signal')
 grid on 
xlabel('Time')
ylabel('Amplitude')
 
% Generate white noise 
noise = 0.1 * randn(size(cleanAudio));

% Add the white noise to the original audio
noisyAudio = cleanAudio + noise;

% Play the noisy audio
play2=audioplayer(noisyAudio, fs)
playblocking(play2); % Plays audio2
pause(1); % Wait for 1 second

subplot(5,1,2);
 plot(t,noisyAudio)
title('Graph of noisy audio signal')
 grid on 
xlabel('Time')
ylabel('Amplitude')

% Compute the FFT of the noisy audio signal
nfft = length(noisyAudio);
freq= (0:(nfft/2-1)) * fs / nfft;
L=1:floor(nfft/2);
fftSignal = fft(noisyAudio, nfft);

 subplot(5,1,3)
 plot(freq(L),fftSignal(L))
 title('Graph of fft of noisy audio signal')
  grid on 
 xlabel('frequency')
 ylabel('Amplitude')
 
 % Compute the Power Spectral Density (PSD)
%psd = (1/nfft) * abs(fftSignal(1:nfft/2)).^2;
psd = fftSignal.*conj(fftSignal)/nfft;

threshold= psd>0.3;
PSDclean=psd.*threshold;

subplot(5,1,4)
plot(freq(L),psd(L))
hold on
plot(freq(L),PSDclean(L))
legend('noisy','clean')
title("Power spectral density")


fftsignal=threshold.*fftSignal;
denoisedAudio=ifft(fftsignal);

subplot(5,1,5);
plot(t,denoisedAudio)
title("filtered Audio signal")
ylim([-1 1])

play3=audioplayer(denoisedAudio, fs)
playblocking(play3); % Plays audio3





