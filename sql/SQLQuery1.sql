/*工作人员表*/
CREATE TABLE Employee(
	employeeNo INT IDENTITY(100001,1) PRIMARY KEY,		/*工作人员代码*/
	empPassword VARCHAR(32) NOT NULL,					/*工作人员登录密码*/
	title VARCHAR(12),									/*工作人员标题*/
	firstName VARCHAR(12),								/*工作人员名*/
	middleName VARCHAR(12),								/*工作人员中名*/
	lastName VARCHAR(12),								/*工作人员姓*/
	address VARCHAR(60),								/*工作人员家庭地址*/
	workTelExt CHAR(8),									/*工作人员电话分机*/
	homeTelNo CHAR(11),									/*工作人员家庭电话号码*/
	empEmailAddress VARCHAR(30),						/*工作人员电子邮箱地址*/
	socialSecurityNumber CHAR(11),						/*工作人员社会安全号*/
	DOB SMALLDATETIME,									/*工作人员出生日期*/
	position VARCHAR(20),								/*工作人员职位*/
	sex CHAR(2),										/*工作人员性别*/
	salary SMALLINT,									/*工作人员工资*/
	dateStarted SMALLDATETIME							/*工作人员工作起始日期*/
);
/*产品分类表*/
CREATE TABLE ProductCategory(
	categoryNo VARCHAR(6) PRIMARY KEY,					/*产品分类代码*/
	categoryDescription VARCHAR(100)					/*产品类别说明*/
);
/*产品表*/
CREATE TABLE Product(
	productNo INT IDENTITY(1,1) PRIMARY KEY,			/*产品代码*/
	productName VARCHAR(60),							/*产品名称*/
	serialNo CHAR(13),									/*产品编号*/
	unitPrice FLOAT(2),									/*产品单价*/
	quantityOnHand SMALLINT,							/*产品现存数量*/
	reorderLevel CHAR(2),								/*货订货点水平*/
	reorderQuantity SMALLINT,							/*再订购数量*/
	reorderLeadTime SMALLDATETIME,						/*订货提前期*/
	categoryNo VARCHAR(6),								/*产品分类代码*/
	FOREIGN KEY (categoryNo) REFERENCES ProductCategory(categoryNo) 
	/*表级完整性约束条件，categoryNo是外码，被参照表是ProductCategory，被参照列是categoryNo*/
);
/*供应商表*/
CREATE TABLE Supplier(
	supplierNo VARCHAR(11) PRIMARY KEY,					/*供应商代码*/
	supplierName VARCHAR(60),							/*供应商名称*/
	supplierStreet VARCHAR(30),							/*供应商所在街道*/
	supplierCity VARCHAR(30),							/*供应商所在城市*/
	supplierState VARCHAR(30),							/*供应商所在州*/
	supplierZipCode CHAR(6),							/*供应商邮编*/
	suppTelNo CHAR(12),									/*供应商电话号码*/
	suppFaxNo CHAR(13),									/*供应商传真号码*/
	suppEmailAddress VARCHAR(30),						/*供应商电子邮件地址*/
	suppWebAddress VARCHAR(50),							/*供应商网站地址*/
	contactName VARCHAR(8),								/*供应商联系人名字*/
	contactTelNo CHAR(11),								/*供应商联系人电话号码*/
	contactFaxNo CHAR(13),								/*供应商联系人传真号码*/
	contactEmailAddress VARCHAR(30),					/*供应商联系人电子邮件地址*/
	paymentTerms CHAR(8)								/*付款条件*/
);
/*购买订单表*/
CREATE TABLE PurchaseOrder(
	purchaseOrderNo INT IDENTITY(10000001,1) PRIMARY KEY,/*购买订单代码*/
	purchaseOrderDescription VARCHAR(300),				/*购买订单描述*/
	orderDate SMALLDATETIME,							/*订货日期*/
	dateRequired SMALLDATETIME,							/*交货日期*/
	shippedDate SMALLDATETIME,							/*发货日期*/
	freightCharge FLOAT(2),								/*货运费*/
	purchaseProductNo INT,								/*购买产品代码*/
	supplierNo VARCHAR(11),								/*供应商代码*/
	employeeNo INT,										/*工作人员代码*/
	FOREIGN KEY (supplierNo) REFERENCES Supplier(supplierNo),/*表级完整性约束条件，supplierNo是外码，被参照表是Supplier*/
	FOREIGN KEY (employeeNo) REFERENCES Employee(employeeNo)/*表级完整性约束条件，employeeNo是外码，被参照表是Employee*/
);
/*交易表*/
CREATE TABLE [Transaction](
	transactionNo INT IDENTITY(20000001,1) PRIMARY KEY,	/*交易代码*/
	transactionDate SMALLDATETIME,						/*交易日期*/
	transactionDescription VARCHAR(300),				/*交易说明*/
	unitPrice FLOAT(2),									/*单价*/
	unitsOrdered SMALLINT,								/*单位订单*/
	unitsReceived SMALLINT,								/*收到订单*/
	unitsSold SMALLINT,									/*销量*/
	unitsWastage SMALLINT,								/*单位损耗*/
	totalPrice FLOAT(2),								/*总价*/
	productNo INT,										/*产品代码*/
	purchaseOrderNo INT,								/*购买订单代码*/
	FOREIGN KEY (productNo) REFERENCES Product(productNo),/*表级完整性约束条件，productNo是外码，被参照表是Product*/
	FOREIGN KEY (purchaseOrderNo) REFERENCES PurchaseOrder(purchaseOrderNo)/*表级完整性约束条件，purchaseOrderNo是外码，被参照表是PurchaseOrder*/
);
/*客户表*/
CREATE TABLE [User](
	userNo INT IDENTITY(200001,1) PRIMARY KEY,			/*客户代码*/
	userName VARCHAR(8),								/*客户姓名*/
	userPassword VARCHAR(32) NOT NULL,					/*客户登录密码*/
	userAddress VARCHAR(60),							/*客户住址*/
	userTelNo CHAR(11)									/*客户电话号码*/
);
/*客户订单表*/
CREATE TABLE UserOrder(
	userOrderNo INT IDENTITY(30000001,1) PRIMARY KEY,	/*客户订单号码*/
	userNo INT,											/*客户代码*/
	userName VARCHAR(8),								/*客户姓名*/
	userOrderDate SMALLDATETIME,						/*客户购买日期*/
	userOrderDescription VARCHAR(300),				    /*客户订单说明*/
	userAddress VARCHAR(60),							/*客户住址*/
	userTelNo CHAR(11),									/*客户电话号码*/
	productNo INT,										/*产品代码*/
	orderQuantity SMALLINT,								/*订购数量*/
	totalPrice FLOAT(2),								/*总价*/
	userOrderStatus CHAR(6),							/*客户订单状态*/
	FOREIGN KEY (userNo) REFERENCES [User](userNo),		/*表级完整性约束条件，userNo是外码，被参照表是User*/
	FOREIGN KEY (productNo) REFERENCES Product(productNo)/*表级完整性约束条件，productNo是外码，被参照表是Product*/
);