#库存控制（Inventory Control）

JSP结合Microsoft SQL Server数据库实现。一个公司希望为控制它的库存建立一个数据库，库存中的产品被分为几类，如服装、食品和文具。当产品需要从供应商那里重新订购时，工作人员需要提出一个购买订单。跟踪记录要提供买进、卖出的货物以及其他的费用。

主要功能模块有工作人员登录模块，客户登录模块，提出购买订单模块，填写购买订单模块，购买订单模块，确定交易模块，增加产品模块，验收货物模块，填写验收产品模块，发货模块，客户注册模块，客户购买模块，填写客户订单模块，历史购买模块，客户信息修改模块等。

##目录内容

- code（源代码）
- data（数据文件）
- sql（SQL语句文件）

##代码解释

- index.jsp

网站主页，点击工作人员登录还是客户登录。

操作结果：点击工作人员登录进入工作人员登录页面，点击客户登录进入客户登录页面。
- emp-login.jsp

工作人员登录，输入工作人员编号和密码，是否记住登录状态，点击登录。

操作结果：跳转到emp-login-check.jsp，验证工作人员登录信息是否正确。以表单的形式提交工作人员编号、密码、是否记住登录状态。
- emp-login-check.jsp

接收emp-login.jsp提交的工作人员编号、密码、是否记住登录状态。连接数据库库存控制工作人员表Employee。

操作结果：判断工作人员编号、密码是否匹配，若匹配，判断工作人员职位，根据工作人员职位跳转到不同的页面（购买订单人员跳转到emp-purchase.jsp，确定交易人员跳转到emp-confirm.jsp，验收货物人员跳转到emp-accept.jsp，发货人员跳转到emp-deliver.jsp），否则重定向到emp-login.jsp。
- emp-purchase.jsp

购买订单人员登录成功跳转到这个页面，购买订单人员根据产品订货点水平，高的提出购买订单，点击再次购买。

操作结果：跳转到emp-purchase-add.jsp，通过URL传产品代码productNo的值。
- emp-purchase-add.jsp

接收产品代码productNo的值，填写购买订单的购买订单描述、订货日期、交货日期、发货日期、供应商（Supplier表），点击提交购买订单。
操作结果：跳转到emp-purchase-place.jsp，增加记录到购买订单表PurchaseOrder。以表单的形式提交购买订单描述、订货日期、交货日期、发货日期、供应商。
- emp-purchase-place.jsp

接收emp-purchase-add.jsp提交的购买订单描述、订货日期、交货日期、发货日期、供应商。连接数据库库存控制购买订单表PurchaseOrder。

操作结果：增加记录到购买订单表PurchaseOrder，重定向到emp-purchase-order.jsp。
- emp-purchase-order.jsp

所有购买订单人员提出的购买订单表，购买订单人员可以对自己提出的购买订单操作删除。

操作结果：跳转到emp-purchase-order-delete.jsp，通过URL传购买订单代码purchaseOrderNo的值。
- emp-purchase-order-delete.jsp

接收购买订单代码purchaseOrderNo的值。

操作结果：删除购买订单表PurchaseOrder某行记录，重定向到emp-purchase-order.jsp。
- emp-confirm.jsp

确定交易人员登录成功跳转到这个页面，确定交易人员对所有购买订单人员提出的购买订单进行交易和删除操作。

操作结果：点击交易跳转到emp-confirm-place.jsp，通过URL传购买订单代码purchaseOrderNo的值和购买产品代码purchaseProductNo的值；点击删除跳转到emp-confirm-place.jsp，通过URL传购买订单代码purchaseOrderNo的值。
- emp-confirm-place.jsp

接收购买订单代码purchaseOrderNo的值和购买产品代码purchaseProductNo的值。

操作结果：判断purchaseProductNo是否为null。若purchaseProductNo为null，删除购买订单表PurchaseOrder某行记录，否则通过产品表 Product和购买订单表PurchaseOrder将购买订单信息增加到交易表Transaction。重定向到emp-confirm.jsp。
- emp-product-add.jsp

增加产品到产品表Product中，填写产品名称、产品编号、产品单价、产品现存数量、订货点水平、再购买数量、订货提前期、产品分类代码（ProductCategory表）。

操作结果：跳转到emp-product-place.jsp页面，以表单的形式提交产品名称、产品编号、产品单价、产品现存数量、订货点水平、再购买数量、订货提前期、产品分类代码。
- emp-product-place.jsp

接收产品名称、产品编号、产品单价、产品现存数量、订货点水平、再购买数量、订货提前期、产品分类代码。

操作结果：增加记录到产品表Product，重定向到emp-product-add.jsp。
- emp-accept.jsp

验收货物人员登录成功跳转到这个页面，验收货物人员根据购买产品是否入库来验收货物。

操作结果：跳转到emp-accept-place.jsp，通过URL传交易代码transactionNo的值。
- emp-accept-place.jsp

填写验收产品，填写交易表收到订单、销量、单位损耗，点击提交。

操作结果：跳转到emp-accept-make.jsp，更新交易表Transaction某行记录。以表单的形式提交收到订单、销量、单位损耗，以及隐藏提交交易代码、产品单价、单位订单、产品代码。
- emp-accept-make.jsp

接收收到订单、销量、单位损耗、交易代码、产品单价、单位订单、产品代码，修改交易表Transaction、产品表Product。

操作结果：更新交易表Transaction、产品表Product某行记录。
- emp-deliver.jsp

发货人员登录成功跳转到这个页面，发货人员对客户订单进行发货操作，点击已付款。

操作结果：跳转到emp-deliver-place.jsp，通过URL传客户订单代码userOrderNo的值。
- emp-deliver-place.jsp

修改客户订单状态。

操作结果：更新客户订单表UserOrder某行记录，将客户订单状态置为“已发货”。
- user-login.jsp

客户登录，输入客户名和密码，是否记住登录状态，点击登录。

操作结果：跳转到user-login-check.jsp，验证客户登录信息是否正确。以表单的形式提交客户名、密码、是否记住登录状态。
- user-login-check.jsp

接收user-login.jsp提交的客户名、密码、是否记住登录状态。连接数据库库存控制客户表User。

操作结果：判断客户名、密码是否匹配，若匹配，跳转到user-purchase.jsp，否则重定向到user-login.jsp。
- user-purchase.jsp

客户登录成功跳转到这个页面，客户可对产品购买，点击购买。

操作结果：跳转到user-purchase-add.jsp，通过URL传产品代码productNo的值。
- user-purchase-add.jsp

接收产品代码productNo的值，填写客户购买订单的客户订单说明、订购数量，点击确定或者点击修改个人信息。

操作结果：点击确定跳转到user-purchase-place.jsp，以表单的形式提交客户订单说明、订购数量，以及隐藏提交产品单价、现存数量；点击修改个人信息跳转到user-information-modify.jsp，修改客户个人信息。
- user-purchase-place.jsp

接收客户订单说明、订购数量、产品单价、现存数量。

操作结果：增加记录到客户订单表UserOrder，根据订购数量将产品表Product现存数量、订货点水平做相应的修改，重定向到user-purchase.jsp。
- user-purchase-history.jsp

客户历史购买。

操作结果：客户查看历史购买。
- user-information-modify.jsp

客户信息修改，填写客户收货地址、客户电话号码，点击修改。

操作结果：跳转到user-information-modify-place.jsp，以表单的形式提交客户收货地址、客户电话号码。
- user-information-modify-place.jsp

接收客户收货地址、客户电话号码。

操作结果：更新客户表User某行记录，重定向到user-purchase.jsp。
- user-register.jsp

客户注册，填写客户信息、密码、收货地址、电话号码，点击注册。

操作结果：跳转到user-register-make.jsp，以表单的形式提交客户信息、密码、收货地址、电话号码。
- user-register-make.jsp

接收客户信息、密码、收货地址、电话号码，判断客户注册是否合法。

操作结果：客户注册合法，增加记录到客户表User，跳转到到user-login.jsp，否则重定向到user-register.jsp。

## 流程图

![流程图][1]

## 用户手册

- 本项目需要在前台开发工具NetBeans IDE 8.0.2和后台数据库Microsoft SQL Server 2014结合下运行。
- 当Microsoft SQL Server 2014连接到服务器、NetBeans IDE 8.0.2服务连接到数据库库存控制的时候，在NetBeans IDE 8.0.2点击项目inventoryControl中的index.jsp并右击选择运行文件，NetBeans IDE 8.0.2即可运行inventoryControl项目。以下为项目运行后的界面，通过点击工作人员登录或者客户登录进入相应的登录页面。

![首页][2]

- 根据每一步的提示，完成相应的操作。
- 关闭浏览器退出。

## 测试结果

1、通过《数据库原理及应用》课程设计，充分实践了数据库基本表的创建、数据查询、数据更新等操作。

2、购买订单人员有权根据订货点水平对产品表中的产品提出购买订单和对自己提出的购买订单进行删除操作。

![提出购买订单][3]

![购买订单][4]

3、确定交易人员有权对所有购买订单人员提出的购买订单进行交易和删除操作之外，还有权增加产品到产品表。

![确定交易][5]

![增加产品][6]

4、验收货物人员有权根据购买产品是否入库来验收货物。

![验收货物][7]

5、发货人员有权对客户订单进行发货操作。

![发货][8]

6、客户不仅有权购买产品、查看自己的历史购买，还有权修改个人信息。

![客户购买][9]

![我的历史购买][10]

![客户信息修改][11]

7、新客户通过注册获取客户所以权限。

![客户注册][12]

  [1]: https://github.com/basfed/inventory-control/blob/master/images/flow-chart.png
  [2]: https://github.com/basfed/inventory-control/blob/master/images/home.png
  [3]: https://github.com/basfed/inventory-control/blob/master/images/1.png
  [4]: https://github.com/basfed/inventory-control/blob/master/images/2.png
  [5]: https://github.com/basfed/inventory-control/blob/master/images/3.png
  [6]: https://github.com/basfed/inventory-control/blob/master/images/4.png
  [7]: https://github.com/basfed/inventory-control/blob/master/images/5.png
  [8]: https://github.com/basfed/inventory-control/blob/master/images/6.png
  [9]: https://github.com/basfed/inventory-control/blob/master/images/7.png
  [10]: https://github.com/basfed/inventory-control/blob/master/images/8.png
  [11]: https://github.com/basfed/inventory-control/blob/master/images/9.png
  [12]: https://github.com/basfed/inventory-control/blob/master/images/10.png