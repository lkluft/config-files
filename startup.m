% add directories to the PATH
%addpath(genpath(''));

% set default figure size
scrz = get(0,'ScreenSize');
set(0,'DefaultFigurePosition',[scrz(3)/5 scrz(4)/5 3*scrz(3)/5 3*scrz(4)/5]);
clear scrz;

% welcome message
display('Hallo, Lukas')
