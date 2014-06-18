x = ecg(500).';
y = sgolayfilt(x,0,3); % Typical values are: d=0 and F=3,5,9, etc.
y5 = sgolayfilt(x,0,5);
y15 = sgolayfilt(x,0,15);
plot(1:length(x),[x y y5 y15]);
figure
plot(y15)
save('file.mat','y15')