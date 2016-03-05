/*������Ա��*/
CREATE TABLE Employee(
	employeeNo INT IDENTITY(100001,1) PRIMARY KEY,		/*������Ա����*/
	empPassword VARCHAR(32) NOT NULL,					/*������Ա��¼����*/
	title VARCHAR(12),									/*������Ա����*/
	firstName VARCHAR(12),								/*������Ա��*/
	middleName VARCHAR(12),								/*������Ա����*/
	lastName VARCHAR(12),								/*������Ա��*/
	address VARCHAR(60),								/*������Ա��ͥ��ַ*/
	workTelExt CHAR(8),									/*������Ա�绰�ֻ�*/
	homeTelNo CHAR(11),									/*������Ա��ͥ�绰����*/
	empEmailAddress VARCHAR(30),						/*������Ա���������ַ*/
	socialSecurityNumber CHAR(11),						/*������Ա��ᰲȫ��*/
	DOB SMALLDATETIME,									/*������Ա��������*/
	position VARCHAR(20),								/*������Աְλ*/
	sex CHAR(2),										/*������Ա�Ա�*/
	salary SMALLINT,									/*������Ա����*/
	dateStarted SMALLDATETIME							/*������Ա������ʼ����*/
);
/*��Ʒ�����*/
CREATE TABLE ProductCategory(
	categoryNo VARCHAR(6) PRIMARY KEY,					/*��Ʒ�������*/
	categoryDescription VARCHAR(100)					/*��Ʒ���˵��*/
);
/*��Ʒ��*/
CREATE TABLE Product(
	productNo INT IDENTITY(1,1) PRIMARY KEY,			/*��Ʒ����*/
	productName VARCHAR(60),							/*��Ʒ����*/
	serialNo CHAR(13),									/*��Ʒ���*/
	unitPrice FLOAT(2),									/*��Ʒ����*/
	quantityOnHand SMALLINT,							/*��Ʒ�ִ�����*/
	reorderLevel CHAR(2),								/*��������ˮƽ*/
	reorderQuantity SMALLINT,							/*�ٶ�������*/
	reorderLeadTime SMALLDATETIME,						/*������ǰ��*/
	categoryNo VARCHAR(6),								/*��Ʒ�������*/
	FOREIGN KEY (categoryNo) REFERENCES ProductCategory(categoryNo) 
	/*��������Լ��������categoryNo�����룬�����ձ���ProductCategory������������categoryNo*/
);
/*��Ӧ�̱�*/
CREATE TABLE Supplier(
	supplierNo VARCHAR(11) PRIMARY KEY,					/*��Ӧ�̴���*/
	supplierName VARCHAR(60),							/*��Ӧ������*/
	supplierStreet VARCHAR(30),							/*��Ӧ�����ڽֵ�*/
	supplierCity VARCHAR(30),							/*��Ӧ�����ڳ���*/
	supplierState VARCHAR(30),							/*��Ӧ��������*/
	supplierZipCode CHAR(6),							/*��Ӧ���ʱ�*/
	suppTelNo CHAR(12),									/*��Ӧ�̵绰����*/
	suppFaxNo CHAR(13),									/*��Ӧ�̴������*/
	suppEmailAddress VARCHAR(30),						/*��Ӧ�̵����ʼ���ַ*/
	suppWebAddress VARCHAR(50),							/*��Ӧ����վ��ַ*/
	contactName VARCHAR(8),								/*��Ӧ����ϵ������*/
	contactTelNo CHAR(11),								/*��Ӧ����ϵ�˵绰����*/
	contactFaxNo CHAR(13),								/*��Ӧ����ϵ�˴������*/
	contactEmailAddress VARCHAR(30),					/*��Ӧ����ϵ�˵����ʼ���ַ*/
	paymentTerms CHAR(8)								/*��������*/
);
/*���򶩵���*/
CREATE TABLE PurchaseOrder(
	purchaseOrderNo INT IDENTITY(10000001,1) PRIMARY KEY,/*���򶩵�����*/
	purchaseOrderDescription VARCHAR(300),				/*���򶩵�����*/
	orderDate SMALLDATETIME,							/*��������*/
	dateRequired SMALLDATETIME,							/*��������*/
	shippedDate SMALLDATETIME,							/*��������*/
	freightCharge FLOAT(2),								/*���˷�*/
	purchaseProductNo INT,								/*�����Ʒ����*/
	supplierNo VARCHAR(11),								/*��Ӧ�̴���*/
	employeeNo INT,										/*������Ա����*/
	FOREIGN KEY (supplierNo) REFERENCES Supplier(supplierNo),/*��������Լ��������supplierNo�����룬�����ձ���Supplier*/
	FOREIGN KEY (employeeNo) REFERENCES Employee(employeeNo)/*��������Լ��������employeeNo�����룬�����ձ���Employee*/
);
/*���ױ�*/
CREATE TABLE [Transaction](
	transactionNo INT IDENTITY(20000001,1) PRIMARY KEY,	/*���״���*/
	transactionDate SMALLDATETIME,						/*��������*/
	transactionDescription VARCHAR(300),				/*����˵��*/
	unitPrice FLOAT(2),									/*����*/
	unitsOrdered SMALLINT,								/*��λ����*/
	unitsReceived SMALLINT,								/*�յ�����*/
	unitsSold SMALLINT,									/*����*/
	unitsWastage SMALLINT,								/*��λ���*/
	totalPrice FLOAT(2),								/*�ܼ�*/
	productNo INT,										/*��Ʒ����*/
	purchaseOrderNo INT,								/*���򶩵�����*/
	FOREIGN KEY (productNo) REFERENCES Product(productNo),/*��������Լ��������productNo�����룬�����ձ���Product*/
	FOREIGN KEY (purchaseOrderNo) REFERENCES PurchaseOrder(purchaseOrderNo)/*��������Լ��������purchaseOrderNo�����룬�����ձ���PurchaseOrder*/
);
/*�ͻ���*/
CREATE TABLE [User](
	userNo INT IDENTITY(200001,1) PRIMARY KEY,			/*�ͻ�����*/
	userName VARCHAR(8),								/*�ͻ�����*/
	userPassword VARCHAR(32) NOT NULL,					/*�ͻ���¼����*/
	userAddress VARCHAR(60),							/*�ͻ�סַ*/
	userTelNo CHAR(11)									/*�ͻ��绰����*/
);
/*�ͻ�������*/
CREATE TABLE UserOrder(
	userOrderNo INT IDENTITY(30000001,1) PRIMARY KEY,	/*�ͻ���������*/
	userNo INT,											/*�ͻ�����*/
	userName VARCHAR(8),								/*�ͻ�����*/
	userOrderDate SMALLDATETIME,						/*�ͻ���������*/
	userOrderDescription VARCHAR(300),				    /*�ͻ�����˵��*/
	userAddress VARCHAR(60),							/*�ͻ�סַ*/
	userTelNo CHAR(11),									/*�ͻ��绰����*/
	productNo INT,										/*��Ʒ����*/
	orderQuantity SMALLINT,								/*��������*/
	totalPrice FLOAT(2),								/*�ܼ�*/
	userOrderStatus CHAR(6),							/*�ͻ�����״̬*/
	FOREIGN KEY (userNo) REFERENCES [User](userNo),		/*��������Լ��������userNo�����룬�����ձ���User*/
	FOREIGN KEY (productNo) REFERENCES Product(productNo)/*��������Լ��������productNo�����룬�����ձ���Product*/
);