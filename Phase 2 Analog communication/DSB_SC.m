% using sine
clc;
clear;
close all;

Fs = 100000;
t = 0:1/Fs:0.02;

fm = 500;
fc = 5000;

m = cos(2*pi*fm*t);
c = cos(2*pi*fc*t);

% AM
mu = .8;
am = (1 + mu*m).*c;

% DSB-SC
dsb = m.*c;

% 6th order filter

[b,a]= butter(6, 1000/(Fs/2));

% envelop detector
env = abs(am);
recov_am = filter(b, a, env);

% coherent detector

coh_out = dsb.*c;
recov_dsb = filter(b, a, coh_out);

plot(t, m)
title("message signal")

plot(t, c)
title("carrier signal")

plot(t, am)
title("amp. modulated signal")

plot(t, dsb)
title("dsb sc modulated signal")

plot(t, m,'b',t, recov_am, 'g--')
title("recovered am signal")

plot(t,m,'b',t,recov_dsb,'r--');
title("recovrf dsb  signal")

%%
%using Cosine

clc;
clear;
close all;

Fs = 100000;
t = 0:1/Fs:0.02;

fm = 500;
fc = 5000;

m = cos(2*pi*fm*t);       % Message
c = cos(2*pi*fc*t);       % Carrier

% AM
mu = 1;
am = (1 + mu*m).*c;

% DSB-SC
dsb = m.*c;

figure;
subplot(3,1,1);
plot(t,m);
title('Message Signal');

subplot(3,1,2);
plot(t,am);
title('AM Signal');

subplot(3,1,3);
plot(t,dsb);
title('DSB-SC Signal');

%% Envelope Detection for AM
env_am = abs(hilbert(am));   % Envelope extraction
figure;
plot(t,m,'b',t,env_am,'r--');
title('Envelope Detection of AM');
legend('Original Message','Recovered Message');

%% Coherent Detection for DSB-SC
% Multiply with local carrier (same frequency & phase)
coherent_out = dsb .* c;

% Low-pass filter to remove high-frequency terms
[b,a] = butter(6, (fm*2)/(Fs));   % LPF cutoff slightly above fm
rec_dsb = filter(b,a,coherent_out);

figure;
plot(t,m,'b',t,rec_dsb,'r--');
title('Coherent Detection of DSB-SC');
legend('Original Message','Recovered Message');

%%

%%

%%