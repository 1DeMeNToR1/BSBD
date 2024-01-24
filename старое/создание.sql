-- �������� ������� ��������_����
CREATE TABLE ��������_���� (
    ID_��������� SERIAL PRIMARY KEY,
    ��� VARCHAR(50),
    ������� VARCHAR(50),
    �������� VARCHAR(50),
    ������� VARCHAR(15),
    ����� VARCHAR(255),
    �����_�� VARCHAR(20)
);

-- �������� ������� ����������
CREATE TABLE ���������� (
    ID_���������� SERIAL PRIMARY KEY,
    ��� VARCHAR(50),
    ������� VARCHAR(50),
    �������� VARCHAR(50),
    ��������� VARCHAR(50),
    ����� VARCHAR(255),
    �����_�������� VARCHAR(15),
    ������� VARCHAR(20)
);

-- �������� ������� ����������
CREATE TABLE ���������� (
    ID_���������� SERIAL PRIMARY KEY,
    ����� VARCHAR(50),
    ������ VARCHAR(50),
    ��� INTEGER,
    �����_��� VARCHAR(20),
    VIN_����� VARCHAR(18),
    ID_��������� INTEGER REFERENCES ��������_����(ID_���������) ON DELETE CASCADE
);

-- �������� ������� ��������
CREATE TABLE �������� (
    ID_�������� SERIAL PRIMARY KEY,
    ������������ VARCHAR(100),
    ������� VARCHAR(20),
    �������� TEXT,
    ��������� DECIMAL(10, 2)
);

-- �������� ������� ������
CREATE TABLE ������ (
    ID_������ SERIAL PRIMARY KEY,
    ����_������ DATE,
    ������_������ VARCHAR(50),
    ��������_�������� TEXT,
    ID_���������� INTEGER REFERENCES ����������(ID_����������) ON DELETE CASCADE
);

-- �������� ������� ���������_��������_�_������
CREATE TABLE ���������_��������_�_������ (
    ID_���������_�������� SERIAL PRIMARY KEY,
    ID_������ INTEGER REFERENCES ������(ID_������) ON DELETE CASCADE,
    ������ VARCHAR(50),
    ����_���������_������� TIMESTAMP,
    ID_�������� INTEGER REFERENCES ��������(ID_��������) ON DELETE CASCADE,
    ���������� INTEGER
);

-- �������� ������� �������
CREATE TABLE ������� (
    ID_������� SERIAL PRIMARY KEY,
    �����_������� DECIMAL(10, 2),
    ����_������� DATE
);

-- �������� ������� ������
CREATE TABLE ������ (
    ID_������ SERIAL PRIMARY KEY,
    ���_������ VARCHAR(100),
    ��������_������ TEXT,
    ���������_������ DECIMAL(10, 2)
);

-- �������� ������� ������_������
CREATE TABLE ������_������ (
    ID_������� SERIAL PRIMARY KEY,
    ID_���������� INTEGER REFERENCES ����������(ID_����������) ON DELETE CASCADE,
    ���� DATE,
    �����_������_������ TIME,
    �����_���������_������ TIME
);

-- �������� ������� ������_�_������
CREATE TABLE ������_�_������ (
    ID_�������_������ SERIAL PRIMARY KEY,
    ID_����� INTEGER REFERENCES ������(ID_������) ON DELETE CASCADE,
    ������ VARCHAR(50),
    ����_��������� TIMESTAMP,
    ID_���������� INTEGER REFERENCES ����������(ID_����������) ON DELETE CASCADE,
    ID_������ INTEGER REFERENCES ������(ID_������) ON DELETE CASCADE
);