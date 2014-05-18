function setSeed(seed)
    % ���� ����������� �������� ��� MATLAB ����� �����������
    % �� ��������������� � RandStream
    if (exist('RandStream') ~= 0)
        s = RandStream('mcg16807', 'Seed', seed);
        RandStream.setGlobalStream(s);
    else
        rand('seed', seed);
        randn('seed', seed);
    end
end