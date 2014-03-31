% ��������� ����������
clear;

% ������� seed ���� �� �������� �� ���� ������������ �� ���� ��������
s = RandStream('mcg16807', 'Seed', 3);
RandStream.setGlobalStream(s);

RADIUS = 0.8;

% ������� ��� iris dataset
load iris.dat;

% ������ �� �������� ��� iris.dat ����� ������������ ����� ��� �����,
% ������������ ��� ������ ��� ��� ������������ �� ��� ��� ���������,
% ���� �� ������� ������ ��� ���� (?) ��� �������
shuffledIris = iris(randperm(size(iris, 1)), :);

% ������������ �� ��� ��������� ��� ������ 75 ������� ��� ������������
% ������, �� ������ �� ��������������� ��� ��� ����������
irisTrain = shuffledIris(1:75, :);

% ������������ �� ��� ���� ��������� ��� ��������� ������� ��� ������������
% ������, �� ������ �� ��������������� ��� ��� ������
irisTest = shuffledIris(76:150, :);

% �������� ���������
irisTrainIn = irisTrain(:, 1:4);
irisTrainOut = irisTrain(:, 5);
irisTestIn = irisTest(:, 1:4);
irisTestOut = irisTest(:, 5);

% ���������� FIS �� subtractive clustering
fis = genfis2(irisTrainIn, irisTrainOut, RADIUS, [min(iris); max(iris)]);

% ���������� ��� FIS �� 8000 ������
[trainFis, trainError, stepSize, checkFis, checkError] = ...
    anfis(irisTrain, fis, 8000, [], irisTest);

% ���������� FIS ����������� �� �������� �������, ��� ������ ���������
trainFisOut = round(evalfis(irisTestIn, trainFis));
trainRMSE = norm(trainFisOut - irisTestOut) / sqrt(length(trainFisOut));
badTrainFis = size(find((trainFisOut == irisTestOut) == 0), 1);

% ���������� FIS ������� �� �������� �������, ��� ������ ���������
checkFisOut = round(evalfis(irisTestIn, checkFis));
checkRMSE = norm(checkFisOut - irisTestOut) / sqrt(length(checkFisOut));
badCheckFis = size(find((checkFisOut == irisTestOut) == 0), 1);

% �������� ���������
fprintf('����� ������������ �� FIS �����������: %d (%.2f%%)\n', ...
    badTrainFis, badTrainFis / size(irisTest, 1) * 100);
fprintf('����� ������������ �� FIS �������: %d (%.2f%%)\n', ...
    badCheckFis, badCheckFis / size(irisTest, 1) * 100);