function [iris, shuffledIris, irisTrain, irisTest, irisTrainIn, ...
    irisTrainOut, irisTestIn, irisTestOut] = getIris(trainingSize)

    % ������� ��� iris dataset
    load iris.dat;

    % ������ �� �������� ��� iris.dat ����� ������������ ����� ��� �����,
    % ������������ ��� ������ ��� ��� ������������ �� ��� ��� ���������,
    % ���� �� ������� ������ ��� ���� (?) ��� �������
    shuffledIris = iris(randperm(size(iris, 1)), :);

    % ������������ �� ��� ��������� ��� ������ 75 ������� ��� ������������
    % ������, �� ������ �� ��������������� ��� ��� ����������
    irisTrain = shuffledIris(1:trainingSize, :);

    % ������������ �� ��� ���� ��������� ��� ��������� ������� ���
    % ������������ ������, �� ������ �� ��������������� ��� ��� ������
    irisTest = shuffledIris((trainingSize + 1):150, :);

    % �������� ���������
    irisTrainIn = irisTrain(:, 1:4);
    irisTrainOut = irisTrain(:, 5);
    irisTestIn = irisTest(:, 1:4);
    irisTestOut = irisTest(:, 5);
end