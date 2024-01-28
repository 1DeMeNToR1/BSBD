CREATE TABLE ����� (
    ID_����� SERIAL PRIMARY KEY,
    �������� VARCHAR(50) NOT NULL
);
CREATE TABLE ������ (
    ID_������ SERIAL PRIMARY KEY,
    ID_����� INTEGER REFERENCES �����(ID_�����) ON DELETE CASCADE,
    �������� VARCHAR(50) NOT NULL
);
-- �������� ������� ��������_����
CREATE TABLE ��������_���� (
    ID_��������� SERIAL PRIMARY KEY,
    ��� VARCHAR(50),
    ������� VARCHAR(50),
    �������� VARCHAR(50),
    ������� VARCHAR(11),
    ����� VARCHAR(155),
    �����_�� VARCHAR(10)
);

-- �������� ������� ����������
CREATE TABLE ���������� (
    ID_���������� SERIAL PRIMARY KEY,
    ��� VARCHAR(50),
    ������� VARCHAR(50),
    �������� VARCHAR(50),
    ��������� VARCHAR(50),
    ����� VARCHAR(155),
    �����_�������� VARCHAR(11),
    ������� VARCHAR(10)
);

-- �������� ������� ����������
CREATE TABLE ���������� (
    ID_���������� SERIAL PRIMARY KEY,
    ID_������ INTEGER REFERENCES ������(ID_������) ON DELETE CASCADE,
    ��� VARCHAR(4),
    �����_��� VARCHAR(10),
    VIN_����� VARCHAR(18),
    ID_��������� INTEGER REFERENCES ��������_����(ID_���������) ON DELETE CASCADE
);

-- �������� ������� ��������
CREATE TABLE �������� (
    ID_�������� SERIAL PRIMARY KEY,
    ������������ VARCHAR(100),
    ������� VARCHAR(8),
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
    ����_������� DATE,
    ������_������� TEXT,
    ID_������ INTEGER REFERENCES ������(ID_������) ON DELETE CASCADE
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