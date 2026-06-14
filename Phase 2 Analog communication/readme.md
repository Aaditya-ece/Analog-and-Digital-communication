## AM Communication System
``` matlab

Fs = 100000;
t = 0:1/Fs:0.02;

Am = 1;
Ac = 2;

fm = 100;
fc = 2000;

m = Am*cos(2*pi*fm*t);
c = Ac*cos(2*pi*fc*t);

mu = Am/Ac;

s = Ac*(1 + mu*cos(2*pi*fm*t)).*cos(2*pi*fc*t);

subplot(6,1,1)
plot(t,m)
title('Message Signal')
grid on

subplot(6,1,2)
plot(t,c)
title('Carrier Signal')
grid on

subplot(6,1,3)
plot(t,s)
title('AM Signal')
grid on

env(abs(s))

[b,a] = butter(6, 500/(Fs/2));
recovered = filtfilt(b, a, env);

subplot(6, 1, 1)
plot(t, m);
title("original message");
grid on

subplot(6, 1, 2)
plot(t,s)
title("am signal")
grid on

subplot(6, 1, 3)
plot(t, recovered)
title("recovered message")
grid on

```

<img width="1711" height="954" alt="image" src="https://github.com/user-attachments/assets/b7caa83b-9ebb-4df1-98d2-e5c317a1a643" />
