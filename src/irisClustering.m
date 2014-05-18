function [trainRMSE, checkRMSE, badTrainFis, badCheckFis] = ...
    irisClustering(seed, radius, squashFactor, acceptRatio, ...
    rejectRatio, epochs)

    % ������� seed ���� �� �������� �� ���� ������������ �� ���� ��������
    setSeed(seed);

    % ������� ��� iris dataset
    [iris, shuffledIris, irisTrain, irisTest, irisTrainIn, ...
        irisTrainOut, irisTestIn, irisTestOut] = getIris(75);

    % ���������� FIS �� subtractive clustering
    fis = genfis2(irisTrainIn, irisTrainOut, radius, ...
        [min(iris); max(iris)], [squashFactor acceptRatio rejectRatio 0]);

    % ���������� ��� FIS
    [trainFis, trainError, stepSize, checkFis, checkError] = ...
        anfis(irisTrain, fis, epochs, [], irisTest);

    % ���������� FIS ����������� �� �������� �������, ��� ������ ���������
    trainFisOut = round(evalfis(irisTestIn, trainFis));
    trainRMSE = norm(trainFisOut - irisTestOut)/sqrt(length(trainFisOut));
    badTrainFis = size(find((trainFisOut == irisTestOut) == 0), 1);

    % ���������� FIS ������� �� �������� �������, ��� ������ ���������
    checkFisOut = round(evalfis(irisTestIn, checkFis));
    checkRMSE = norm(checkFisOut - irisTestOut)/sqrt(length(checkFisOut));
    badCheckFis = size(find((checkFisOut == irisTestOut) == 0), 1);

    % �������� ���������
    fprintf('����� ������������ �� FIS �����������: %d (%.2f%%)\n', ...
        badTrainFis, badTrainFis / size(irisTest, 1) * 100);
    fprintf('����� ������������ �� FIS �������: %d (%.2f%%)\n', ...
        badCheckFis, badCheckFis / size(irisTest, 1) * 100);
end