clc;
clear all;
%Dados fornecidos 
fp = 21e3;
fs = fp/4;
Amx = 0.2;
Amn = 55;
Z = 750;
%
%Valores calculados
wp = 2*pi*fp;
ws = 2*pi*fs;
E = (10^(Amx/10)-1)^(1/2);
n = ceil(abs(log((10^(Amn/10)-1)/(10^(Amx/10)-1))/(2*log(ws/wp))));
%   
%Compentes normalizados
C1 = 2*E^(1/n)*sin((2*1-1)*pi/(2*n));
C2 = 2*E^(1/n)*sin((2*3-1)*pi/(2*n));
C3 = 2*E^(1/n)*sin((2*5-1)*pi/(2*n));
L1 = 2*E^(1/n)*sin((2*2-1)*pi/(2*n));
L2 = 2*E^(1/n)*sin((2*4-1)*pi/(2*n));
L3 = 2*E^(1/n)*sin((2*6-1)*pi/(2*n));
%
%Escalonando
C1E = C1/Z;
C2E = C2/Z;
C3E = C3/Z;
L1E = L1*Z;
L2E = L2*Z;
L3E = L3*Z;
%
%Passa baixa para Passa alta
L1PA = 1/(wp*C1E);
L2PA = 1/(wp*C2E);
L3PA = 1/(wp*C3E);
C1PA = 1/(wp*L1E);
C2PA = 1/(wp*L2E);
C3PA = 1/(wp*L3E);
%
%Antoniou
R = 10e3;
C = 10e-12;
R1 = L1PA/(R*C)
R3 = L2PA/(R*C)
R5 = L3PA/(R*C)

%% Import data from text file.antoniou
% Script for importing data from the following text file:
%
%    C:\Users\PC\Documents\S�ntese de Circuitos\Trabalho 02\T02_Antoniou.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2023/07/13 21:37:29

%% Initialize variables.
filename = 'C:\Users\PC\Documents\S�ntese de Circuitos\Trabalho 02\T02_Antoniou.txt';
delimiter = '\t';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\.]*)+[\,]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\.]*)*[\,]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers=='.');
                thousandsRegExp = '^\d+?(\.\d{3})*\,{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = strrep(numbers, '.', '');
                numbers = strrep(numbers, ',', '.');
                numbers = textscan(numbers, '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% Allocate imported array to column variable names
Freq1 = cell2mat(raw(:, 1));
Voutput1 = cell2mat(raw(:, 2));
Phase1 = cell2mat(raw(:, 3));


%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me;
%%

%% Import data from text file.lcpassivo
% Script for importing data from the following text file:
%
%    C:\Users\PC\Documents\S�ntese de Circuitos\Trabalho 02\T02_Passivo.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2023/07/13 21:39:49

%% Initialize variables.
filename = 'C:\Users\PC\Documents\S�ntese de Circuitos\Trabalho 02\T02_Passivo.txt';
delimiter = '\t';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\.]*)+[\,]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\.]*)*[\,]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers=='.');
                thousandsRegExp = '^\d+?(\.\d{3})*\,{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = strrep(numbers, '.', '');
                numbers = strrep(numbers, ',', '.');
                numbers = textscan(numbers, '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% Allocate imported array to column variable names
Freq2 = cell2mat(raw(:, 1));
Voutput2 = cell2mat(raw(:, 2));
Phase2 = cell2mat(raw(:, 3));


%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me;


figure (1)
semilogx(Freq2,Voutput2,Freq1,Voutput1,'--','linewidth',2)
xlabel ( 'Frequ�ncia (Hz)' );
ylabel ('Magnitude (dB)');
figure (2)
semilogx(Freq2,Phase2,Freq1,Phase1,'--','linewidth',2)
xlabel ( 'Frequ�ncia (Hz)' );
ylabel ('Fase (rad)');











