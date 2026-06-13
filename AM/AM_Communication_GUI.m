function AM_Communication_GUI
    % Sampling setup
    Fs = 100000;
    t = 0:1/Fs:0.02;
    Am = 1; % fixed message amplitude
    fm = 100; % fixed message frequency

    % Create figure
    f = figure('Name','AM Communication System','NumberTitle','off');

    % Sliders
    uicontrol('Style','text','Position',[20 370 120 20],'String','Carrier Freq (Hz)');
    carrierSlider = uicontrol('Style','slider','Min',500,'Max',5000,'Value',2000,...
        'Position',[150 370 300 20],'Callback',@updatePlot);

    uicontrol('Style','text','Position',[20 340 120 20],'String','Modulation Index');
    muSlider = uicontrol('Style','slider','Min',0.1,'Max',2,'Value',0.5,...
        'Position',[150 340 300 20],'Callback',@updatePlot);

    uicontrol('Style','text','Position',[20 310 120 20],'String','Noise Level');
    noiseSlider = uicontrol('Style','slider','Min',0,'Max',1,'Value',0.2,...
        'Position',[150 310 300 20],'Callback',@updatePlot);

    % Initial plot
    updatePlot();

    function updatePlot(~,~)
        fc = get(carrierSlider,'Value');
        mu = get(muSlider,'Value');
        noise_level = get(noiseSlider,'Value');

        % Signals
        m = Am*cos(2*pi*fm*t);
        c = cos(2*pi*fc*t);
        s = (1 + mu*m).*c;

        % Channel (add noise)
        noisy_signal = s + noise_level*randn(size(s));

        % Envelope detection
        env_signal = abs(hilbert(noisy_signal));

        % Low-pass filter
        [b,a] = butter(6, 500/(Fs/2));
        recovered = filtfilt(b,a,env_signal);

        % Plot results
        subplot(6,1,1); plot(t,m); title('Message Signal'); grid on;
        subplot(6,1,2); plot(t,c); title('Carrier Signal'); grid on;
        subplot(6,1,3); plot(t,s); title('AM Signal'); grid on;
        subplot(6,1,4); plot(t,noisy_signal); title('Noisy Channel Output'); grid on;
        subplot(6,1,5); plot(t,env_signal); title('Envelope Detector Output'); grid on;
        subplot(6,1,6); plot(t,recovered); title('Recovered Message'); grid on;
    end
end
