% add directories to the PATH
addpath(genpath('/Users/u300509/Documents/atmlab/atmlab'));
atmlab_init

% set default figure size
scrz = get(0,'ScreenSize');
set(0,'DefaultFigurePosition',[scrz(3)/5 scrz(4)/5 3*scrz(3)/5 3*scrz(4)/5]);
clear scrz;
