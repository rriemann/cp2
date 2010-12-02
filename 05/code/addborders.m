raw = double(imread('../data/testbild.tif','TIF'));
whos raw % zeige matrix an

colormap('Gray');
image(raw); title('Original');