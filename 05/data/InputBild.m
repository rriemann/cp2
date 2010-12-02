% BildInput.m

% Oliver Witzel, Januar 2006, Ulli Wolff Nov. 2007

% Einlesen eines Bildes im tif Format

raw = double(imread('testbild.tif','TIF'));
whos raw % zeige matrix an

% raw ist nun eine Matrix deren Elemente Information ueber die Pixel
% enthalten; es wurden auch noch Datentyp uint8 (8-Bit integer ohne Vorzeichen)
% in 64-Bit Gleitkomma verwandelt

% Anzeige des (und anderer) Bilder geht so:
% Das folgende dient zur korrekten Interpretation der Zahlen in raw:
   colormap('Gray');
   image(raw); title('Original');
