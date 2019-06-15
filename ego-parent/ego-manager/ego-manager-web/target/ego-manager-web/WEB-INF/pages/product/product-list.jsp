<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"></c:set>
<html><head>
    <meta charset="UTF-8">
    <title>ego管理后台</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Bootstrap 3.3.4 -->
    <link href="../Public/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <!-- FontAwesome 4.3.0 -->
 	<link href="../Public/bootstrap/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <!-- Ionicons 2.0.0 --
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="../Public/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
    	folder instead of downloading all of them to reduce the load. -->
    <link href="../Public/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css">
    <!-- iCheck -->
    <link href="../Public/plugins/iCheck/flat/blue.css" rel="stylesheet" type="text/css">
    <!-- jQuery 2.1.4 -->
    <script src="../Public/plugins/jQuery/jQuery-2.1.4.min.js"></script>
	<script src="../Public/js/global.js"></script>
    <script src="../Public/js/myFormValidate.js"></script>
    <script src="../Public/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="../Public/js/layer/layer-min.js"></script><link rel="stylesheet" href="../Public/js/layer/skin/layer.css" id="layui_layer_skinlayercss" style=""><!-- 弹窗js 参考文档 http://layer.layui.com/-->
    <script src="../Public/js/myAjax.js"></script>
    <script type="text/javascript">
    function delfunc(obj){
    	layer.confirm('确认删除？', {
    		  btn: ['确定','取消'] //按钮
    		}, function(){
   				$.ajax({
   					type : 'post',
   					url : $(obj).attr('data-url'),
   					data : {act:'del',del_id:$(obj).attr('data-id')},
   					dataType : 'json',
   					success : function(data){
   						if(data==1){
   							layer.msg('操作成功', {icon: 1});
   							$(obj).parent().parent().remove();
   						}else{
   							layer.msg(data, {icon: 2,time: 2000});
   						}
   						layer.closeAll();
   					}
   				})
    		}, function(index){
    			layer.close(index);
    			return false;// 取消
    		}
    	);
    }
    
    //全选
    function selectAll(name,obj){
    	$('input[name*='+name+']').prop('checked', $(obj).checked);
    }   
    
    function get_help(obj){
        layer.open({
            type: 2,
            title: '帮助手册',
            shadeClose: true,
            shade: 0.3,
            area: ['90%', '90%'],
            content: $(obj).attr('data-url'), 
        });
    }
    
    function delAll(obj,name){
    	var a = [];
    	$('input[name*='+name+']').each(function(i,o){
    		if($(o).is(':checked')){
    			a.push($(o).val());
    		}
    	})
    	if(a.length == 0){
    		layer.alert('请选择删除项', {icon: 2});
    		return;
    	}
    	layer.confirm('确认删除？', {btn: ['确定','取消'] }, function(){
    			$.ajax({
    				type : 'get',
    				url : $(obj).attr('data-url'),
    				data : {act:'del',del_id:a},
    				dataType : 'json',
    				success : function(data){
    					if(data == 1){
    						layer.msg('操作成功', {icon: 1});
    						$('input[name*='+name+']').each(function(i,o){
    							if($(o).is(':checked')){
    								$(o).parent().parent().remove();
    							}
    						})
    					}else{
    						layer.msg(data, {icon: 2,time: 2000});
    					}
    					layer.closeAll();
    				}
    			})
    		}, function(index){
    			layer.close(index);
    			return false;// 取消
    		}
    	);	
    }
    </script>        
  <meta name="__hash__" content="934c3c704c4bed5cb4da6cec6353613a_2e4eb53d2afc41d11040df3ef57fa1ca"></head>
  <body style="background-color:#ecf0f5;">
 

<div class="wrapper">
 <div class="breadcrumbs" id="breadcrumbs">
	<ol class="breadcrumb">
	<li><a href="javascript:void();"><i class="fa fa-home"></i>&nbsp;&nbsp;后台首页</a></li>
	        
	        <li><a href="javascript:void();">商品管理</a></li>    
	        <li><a href="javascript:void();">商品列表</a></li>          
	</ol>
</div>

 <style>#search-form > .form-group{margin-left: 10px;}</style>
  <!-- Main content -->
  <section class="content">
    <div class="container-fluid">
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title"><i class="fa fa-list"></i> 商品列表</h3>
        </div>
        <div class="panel-body">
          <div class="navbar navbar-default">
              <form action="" id="search-form2" class="navbar-form form-inline" method="post" onsubmit="return false">
                <div class="form-group">
                  <select name="cat_id" id="cat_id" class="form-control">
                    <option value="">所有分类</option>
                    <option value="779">  0-2岁</option><option value="784">  11-14岁</option><option value="781">  3-6岁</option><option value="159">  3G/4G/5G上网</option><option value="783">  7-10岁</option><option value="402">  沐浴</option><option value="270">  沐浴花洒</option><option value="593">  瑜伽舞蹈</option><option value="457">  翡翠玉石</option><option value="482">  踝靴</option><option value="76"> A 安全座椅</option><option value="647"> A 安全座椅</option><option value="711"> A 安全座椅</option><option value="68"> A 安全自驾</option><option value="713"> A 安全防护</option><option value="615"> A 安全预警仪</option><option value="177"> A 安防监控</option><option value="141"> A 按摩器</option><option value="542"> B 便携桌椅床</option><option value="651"> B 保养维修服务</option><option value="380"> B 保暖内衣</option><option value="245"> B 保暖防护</option><option value="644"> B 保温箱</option><option value="173"> B 保险柜</option><option value="131"> B 冰箱</option><option value="620"> B 冰箱</option><option value="162"> B 办公家具</option><option value="188"> B 办公文具</option><option value="25"> B 办公设备</option><option value="109"> B 办套餐</option><option value="666"> B 北汽新能源</option><option value="328"> B 半身裙</option><option value="686"> B 宝宝护肤</option><option value="687"> B 宝宝洗浴</option><option value="733"> B 宝宝零食</option><option value="280"> B 布艺软饰</option><option value="469"> B 布鞋/绣花鞋</option><option value="278"> B 抱枕靠垫</option><option value="179"> B 本册便签</option><option value="571"> B 板鞋</option><option value="580"> B 比基尼</option><option value="629"> B 玻璃水</option><option value="165"> B 白板</option><option value="183"> B 笔类</option><option value="194"> B 笔记本</option><option value="546"> B 背包</option><option value="628"> B 补漆笔</option><option value="279"> B 被子</option><option value="281"> B 被芯</option><option value="454"> B 铂金</option><option value="200"> C CPU</option><option value="726"> C 产后塑身</option><option value="172"> C 传真设备</option><option value="498"> C 传统布鞋</option><option value="810"> C 传记</option><option value="294"> C 储物家具</option><option value="645"> C 储物箱</option><option value="112"> C 充值卡</option><option value="641"> C 充气泵</option><option value="545"> C 冲浪潜水</option><option value="537"> C 冲锋衣裤</option><option value="259"> C 出行装备</option><option value="763"> C 创意减压</option><option value="243"> C 创意家居</option><option value="34"> C 厨具</option><option value="144"> C 厨卫五金</option><option value="273"> C 厨房卫浴</option><option value="21"> C 厨房电器</option><option value="261"> C 厨房配件</option><option value="140"> C 吹风机</option><option value="417"> C 唇部</option><option value="59"> C 垂钓用品</option><option value="251"> C 宠物主粮</option><option value="252"> C 宠物牵引</option><option value="250"> C 宠物玩具</option><option value="33"> C 宠物生活</option><option value="253"> C 宠物零食</option><option value="254"> C 宠物驱虫</option><option value="301"> C 床</option><option value="283"> C 床单被罩</option><option value="277"> C 床品套件</option><option value="304"> C 床垫</option><option value="285"> C 床垫床褥</option><option value="452"> C 彩宝</option><option value="720"> C 成人奶粉</option><option value="755"> C 成人尿裤</option><option value="218"> C 插座</option><option value="55"> C 潮流女包</option><option value="788"> C 畅读VIP</option><option value="282"> C 窗帘窗纱</option><option value="459"> C 纯金K金饰品</option><option value="264"> C 茶具/咖啡具</option><option value="295"> C 茶几</option><option value="327"> C 衬衫</option><option value="356"> C 衬衫</option><option value="187"> C 财会用品</option><option value="195"> C 超极本</option><option value="632"> C 车内饰品</option><option value="682"> C 车灯</option><option value="627"> C 车蜡</option><option value="638"> C 车衣</option><option value="636"> C 车身装饰件</option><option value="616"> C 车载电台</option><option value="65"> C 车载电器</option><option value="263"> C 餐具</option><option value="290"> C 餐厅家具</option><option value="299"> C 餐桌</option><option value="702"> C 餐椅摇椅</option><option value="734"> D DHA</option><option value="761"> D DIY玩具</option><option value="664"> D 东风雪铁龙</option><option value="619"> D 倒车雷达</option><option value="811"> D 动漫</option><option value="766"> D 动漫玩具</option><option value="104"> D 单反相机</option><option value="437"> D 单肩/斜挎包</option><option value="502"> D 单肩包</option><option value="474"> D 单鞋</option><option value="330"> D 吊带/背心</option><option value="382"> D 吊带/背心</option><option value="309"> D 吊灯</option><option value="238"> D 地毯地垫</option><option value="168"> D 多功能一体机</option><option value="20"> D 大家电</option><option value="381"> D 大码内衣</option><option value="333"> D 大码女装</option><option value="363"> D 大码男装</option><option value="494"> D 定制鞋</option><option value="124"> D 对讲机</option><option value="613"> D 导航仪</option><option value="422"> D 底妆</option><option value="681"> D 底盘装甲/护板</option><option value="721"> D 待产/新生</option><option value="170"> D 打印机</option><option value="341"> D 打底衫</option><option value="396"> D 打底衫</option><option value="345"> D 打底裤</option><option value="389"> D 打底裤袜</option><option value="38"> D 灯具</option><option value="152"> D 灯具</option><option value="271"> D 灯饰照明</option><option value="119"> D 点读机</option><option value="147"> D 电动工具</option><option value="611"> D 电动车</option><option value="709"> D 电动车</option><option value="287"> D 电地毯</option><option value="838"> D 电子/通信</option><option value="87"> D 电子书</option><option value="17"> D 电子教育</option><option value="121"> D 电子词典</option><option value="266"> D 电工电料</option><option value="100"> D 电池 电源 充电器</option><option value="199"> D 电源</option><option value="612"> D 电源</option><option value="120"> D 电纸书</option><option value="150"> D 电线线缆</option><option value="3"> D 电脑、办公</option><option value="444"> D 电脑包</option><option value="214"> D 电脑工具</option><option value="27"> D 电脑整机</option><option value="302"> D 电脑桌</option><option value="291"> D 电脑椅</option><option value="28"> D 电脑配件</option><option value="130"> D 电视</option><option value="297"> D 电视柜</option><option value="129"> D 电话机</option><option value="128"> D 电风扇</option><option value="136"> D 电饭锅</option><option value="448"> D 登山包</option><option value="553"> D 登山攀岩</option><option value="527"> D 登山鞋</option><option value="319"> D 短外套</option><option value="343"> D 短裤</option><option value="357"> D 短裤</option><option value="113"> D 读卡器</option><option value="138"> D 豆浆机</option><option value="557"> D 钓箱鱼包</option><option value="561"> D 钓鱼桌椅</option><option value="562"> D 钓鱼配件</option><option value="785"> E 儿童文学</option><option value="466"> E 儿童表</option><option value="117"> E 耳机/耳麦</option><option value="350"> F 仿皮皮衣</option><option value="366"> F 仿皮皮衣</option><option value="161"> F 复合机</option><option value="122"> F 复读机</option><option value="479"> F 帆布鞋</option><option value="497"> F 帆布鞋</option><option value="563"> F 帆布鞋</option><option value="311"> F 氛围照明</option><option value="820"> F 法律</option><option value="560"> F 浮漂鱼饵</option><option value="231"> F 缝纫/针织用品</option><option value="698"> F 辅食料理机</option><option value="674"> F 防冻液</option><option value="483"> F 防水台</option><option value="642"> F 防盗设备</option><option value="724"> F 防辐射服</option><option value="323"> F 风衣</option><option value="362"> F 风衣</option><option value="6"> G 个人化妆</option><option value="22"> G 个护健康</option><option value="521"> G 功能内衣</option><option value="650"> G 功能升级服务</option><option value="634"> G 功能小件</option><option value="50"> G 功能箱包</option><option value="500"> G 功能鞋</option><option value="749"> G 功能鞋</option><option value="802"> G 古典音乐</option><option value="208"> G 固态硬盘</option><option value="825"> G 国学/古籍</option><option value="837"> G 工业技术</option><option value="375"> G 工装</option><option value="499"> G 工装鞋</option><option value="539"> G 工装鞋</option><option value="671"> G 改装配件</option><option value="731"> G 果泥/果汁</option><option value="774"> G 港台图书</option><option value="814"> G 管理</option><option value="735"> G 钙铁锌/维生素</option><option value="511"> G 高尔夫</option><option value="477"> G 高跟鞋</option><option value="171"> H 会员视频音频</option><option value="110"> H 合约机</option><option value="639"> H 后备箱垫</option><option value="684"> H 后视镜</option><option value="795"> H 婚恋两性</option><option value="347"> H 婚纱</option><option value="550"> H 户外仪表</option><option value="544"> H 户外工具</option><option value="555"> H 户外照明</option><option value="528"> H 户外袜</option><option value="58"> H 户外装备</option><option value="548"> H 户外配饰</option><option value="57"> H 户外鞋服</option><option value="538"> H 户外风衣</option><option value="432"> H 护发</option><option value="429"> H 护肤</option><option value="668"> H 海马</option><option value="707"> H 滑板车</option><option value="523"> H 滑雪服</option><option value="541"> H 滑雪装备</option><option value="678"> H 火花塞</option><option value="185"> H 画具画材</option><option value="786"> H 绘本</option><option value="241"> H 花瓶花艺</option><option value="659"> H 豪华车</option><option value="157"> J 交换机</option><option value="435"> J 假发</option><option value="834"> J 健身保健</option><option value="757"> J 健身玩具</option><option value="63"> J 健身训练</option><option value="596"> J 健身车/动感单车</option><option value="524"> J 军迷服饰</option><option value="554"> J 军迷用品</option><option value="623"> J 净化器</option><option value="233"> J 净化除味</option><option value="260"> J 剪刀菜饭</option><option value="339"> J 加绒裤</option><option value="355"> J 加绒裤</option><option value="376"> J 夹克</option><option value="584"> J 夹克/风衣</option><option value="37"> J 家具</option><option value="828"> J 家居</option><option value="4"> J 家居、家具、家装、厨具</option><option value="718"> J 家居床品</option><option value="257"> J 家居日用</option><option value="97"> J 家庭清洁</option><option value="830"> J 家教与育儿</option><option value="2"> J 家用电器</option><option value="36"> J 家纺</option><option value="35"> J 家装建材</option><option value="32"> J 家装软饰</option><option value="836"> J 建筑</option><option value="556"> J 救援装备</option><option value="797"> J 教材</option><option value="88"> J 教育</option><option value="773"> J 教育音像</option><option value="198"> J 机箱</option><option value="543"> J 极限户外</option><option value="804"> J 爵士蓝调</option><option value="148"> J 监控安防</option><option value="764"> J 积木拼插</option><option value="49"> J 精品男包</option><option value="656"> J 紧凑型车</option><option value="816"> J 经济</option><option value="792"> J 经济金融</option><option value="91"> J 经管励志</option><option value="633"> J 脚垫</option><option value="234"> J 节庆饰品</option><option value="313"> J 节能灯</option><option value="181"> J 计算器</option><option value="842"> J 计算机与互联网</option><option value="815"> J 金融与投资</option><option value="460"> J 金银投资</option><option value="213"> J 键盘</option><option value="106"> J 镜头</option><option value="404"> J 颈部</option><option value="85"> K 刊/原版</option><option value="203"> K 刻录机/光驱</option><option value="189"> K 刻录碟片</option><option value="508"> K 卡包/零钱包</option><option value="43"> K 口腔护理</option><option value="303"> K 客厅家具</option><option value="306"> K 客厅家具</option><option value="146"> K 开关插座</option><option value="272"> K 开关插座</option><option value="840"> K 科学与自然</option><option value="94"> K 科技</option><option value="777"> K 科普</option><option value="843"> K 科普</option><option value="631"> K 空气净化</option><option value="132"> K 空调</option><option value="167"> K 考勤机</option><option value="799"> K 考试</option><option value="748"> K 裤子</option><option value="312"> L LED灯</option><option value="831"> L 两性</option><option value="765"> L 乐器相关</option><option value="286"> L 凉席</option><option value="472"> L 凉鞋</option><option value="751"> L 凉鞋</option><option value="490"> L 凉鞋/沙滩鞋</option><option value="791"> L 励志与成功</option><option value="817"> L 励志与成功</option><option value="822"> L 历史</option><option value="242"> L 帘艺隔断</option><option value="125"> L 录音机</option><option value="754"> L 拉拉裤</option><option value="450"> L 拉杆箱/拉杆包</option><option value="135"> L 料理/榨汁机</option><option value="835"> L 旅游/地图</option><option value="552"> L 旅游用品</option><option value="442"> L 旅行包</option><option value="449"> L 旅行配件</option><option value="54"> L 流行男鞋</option><option value="676"> L 滤清器</option><option value="115"> L 滤镜</option><option value="688"> L 理发器</option><option value="322"> L 礼服</option><option value="517"> L 篮球</option><option value="569"> L 篮球鞋</option><option value="314"> L 落地灯</option><option value="621"> L 蓝牙设备</option><option value="155"> L 路由器</option><option value="673"> L 轮毂</option><option value="509"> L 轮滑滑板</option><option value="670"> L 轮胎</option><option value="344"> L 连衣裙</option><option value="393"> L 连裤袜/丝袜</option><option value="667"> L 陆风</option><option value="276"> L 龙头</option><option value="660"> M MPV</option><option value="789"> M 免费</option><option value="182"> M 墨盒</option><option value="443"> M 妈咪包</option><option value="725"> M 妈咪包/背婴带</option><option value="79"> M 妈妈专区</option><option value="481"> M 妈妈鞋</option><option value="401"> M 抹胸</option><option value="648"> M 摩托车装备</option><option value="340"> M 棉服</option><option value="368"> M 棉服</option><option value="582"> M 棉服</option><option value="768"> M 模型玩具</option><option value="10"> M 母婴用品、儿童玩具</option><option value="336"> M 毛呢大衣</option><option value="359"> M 毛呢大衣</option><option value="289"> M 毛巾浴巾</option><option value="767"> M 毛绒布艺</option><option value="591"> M 毛衫/线衫</option><option value="255"> M 猫砂/尿布</option><option value="730"> M 米粉/菜粉</option><option value="419"> M 美容工具</option><option value="66"> M 美容清洗</option><option value="418"> M 美甲</option><option value="407"> M 美胸</option><option value="394"> M 美腿袜</option><option value="826"> M 美食</option><option value="145"> M 门铃门锁</option><option value="732"> M 面条/粥</option><option value="425"> M 面膜</option><option value="47"> M 面部护肤</option><option value="478"> M 马丁靴</option><option value="326"> M 马甲</option><option value="369"> M 马甲/背心</option><option value="484"> N 内增高</option><option value="196"> N 内存</option><option value="41"> N 内衣</option><option value="750"> N 内衣</option><option value="385"> N 内衣配件</option><option value="841"> N 农林</option><option value="579"> N 女士泳衣</option><option value="390"> N 女式内裤</option><option value="44"> N 女性护理</option><option value="465"> N 女表</option><option value="39"> N 女装</option><option value="468"> N 女靴</option><option value="694"> N 奶瓶奶嘴</option><option value="690"> N 奶瓶清洗</option><option value="78"> N 奶粉</option><option value="82"> N 尿裤湿巾</option><option value="706"> N 扭扭车</option><option value="697"> N 暖奶消毒</option><option value="325"> N 牛仔裤</option><option value="377"> N 牛仔裤</option><option value="438"> N 男士手包</option><option value="578"> N 男士泳衣</option><option value="387"> N 男式内裤</option><option value="464"> N 男表</option><option value="40"> N 男装</option><option value="5"> N 男装、女装、童装、内衣</option><option value="496"> N 男靴</option><option value="354"> P POLO衫</option><option value="513"> P 乒乓球</option><option value="587"> P 乒羽网服</option><option value="564"> P 乒羽网鞋</option><option value="486"> P 坡跟鞋</option><option value="191"> P 平板电脑</option><option value="605"> P 平衡车</option><option value="514"> P 排球</option><option value="265"> P 烹饪锅具</option><option value="342"> P 皮草</option><option value="752"> P 皮鞋/帆布鞋</option><option value="594"> P 跑步机</option><option value="565"> P 跑步鞋</option><option value="653"> P 跑车</option><option value="738"> P 配饰</option><option value="739"> Q 亲子装</option><option value="601"> Q 其他中小型器材</option><option value="599"> Q 其他大型器械</option><option value="606"> Q 其他整车</option><option value="518"> Q 其它</option><option value="558"> Q 其它</option><option value="574"> Q 其它</option><option value="267"> Q 墙地材料</option><option value="248"> Q 墙贴/装饰贴</option><option value="77"> Q 寝居服饰</option><option value="398"> Q 情侣睡衣</option><option value="397"> Q 情趣内衣</option><option value="351"> Q 旗袍/唐装</option><option value="516"> Q 棋牌麻将</option><option value="685"> Q 汽修工具</option><option value="71"> Q 汽车品牌</option><option value="9"> Q 汽车用品</option><option value="67"> Q 汽车装饰</option><option value="70"> Q 汽车车型</option><option value="428"> Q 清洁</option><option value="624"> Q 清洁剂</option><option value="227"> Q 清洁工具</option><option value="46"> Q 清洁用品</option><option value="652"> Q 清洗美容服务</option><option value="737"> Q 清火/开胃</option><option value="383"> Q 秋衣秋裤</option><option value="747"> Q 裙子</option><option value="506"> Q 钱包</option><option value="440"> Q 钱包/卡包</option><option value="809"> Q 青春文学</option><option value="99"> Q 驱虫用品</option><option value="693"> Q 驱蚊防蚊</option><option value="608"> Q 骑行服</option><option value="607"> Q 骑行装备</option><option value="64"> Q 骑行运动</option><option value="92"> R 人文社科</option><option value="691"> R 日常护理</option><option value="433"> R 染发</option><option value="669"> R 润滑油</option><option value="403"> R 润肤</option><option value="134"> R 热水器</option><option value="533"> R 软壳衣裤</option><option value="661"> S SUV</option><option value="704"> S 三轮车</option><option value="662"> S 上海大众</option><option value="743"> S 上衣</option><option value="451"> S 书包</option><option value="292"> S 书房家具</option><option value="675"> S 刹车片/盘</option><option value="439"> S 双肩包</option><option value="505"> S 双肩包</option><option value="298"> S 商业办公</option><option value="493"> S 商务休闲鞋</option><option value="436"> S 商务公文包</option><option value="395"> S 商务男袜</option><option value="391"> S 塑身美体</option><option value="205"> S 声卡/扩展卡</option><option value="86"> S 少儿</option><option value="399"> S 少女文胸</option><option value="609"> S 山地车/公路车</option><option value="212"> S 手写板</option><option value="235"> S 手工/十字绣</option><option value="829"> S 手工DIY</option><option value="780"> S 手工游戏</option><option value="507"> S 手拿包/晚宴包</option><option value="503"> S 手提包</option><option value="123"> S 手机</option><option value="1"> S 手机 、 数码 、 通信</option><option value="18"> S 手机通讯</option><option value="12"> S 手机配件</option><option value="226"> S 手柄方向盘</option><option value="405"> S 手足</option><option value="176"> S 扫描设备</option><option value="221"> S 摄像头</option><option value="105"> S 摄像机</option><option value="813"> S 摄影</option><option value="13"> S 摄影摄像</option><option value="163"> S 摄影机</option><option value="169"> S 收款/POS机</option><option value="228"> S 收纳用品</option><option value="207"> S 散热器</option><option value="89"> S 数字音乐</option><option value="101"> S 数据线,耳机</option><option value="103"> S 数码相机</option><option value="107"> S 数码相框</option><option value="15"> S 数码配件</option><option value="663"> S 斯柯达</option><option value="53"> S 时尚女鞋</option><option value="622"> S 时尚影音</option><option value="827"> S 时尚美妆</option><option value="453"> S 时尚饰品</option><option value="485"> S 松糕鞋</option><option value="262"> S 水具酒具</option><option value="700"> S 水壶/水杯</option><option value="249"> S 水族用品</option><option value="462"> S 水晶玛瑙</option><option value="153"> S 水龙头</option><option value="307"> S 沙发</option><option value="240"> S 沙发垫套/椅垫</option><option value="525"> S 沙滩/凉拖</option><option value="756"> S 湿巾</option><option value="522"> S 溯溪鞋</option><option value="411"> S 漱口水</option><option value="93"> S 生活</option><option value="31"> S 生活日用</option><option value="19"> S 生活电器</option><option value="602"> S 甩脂机</option><option value="386"> S 睡衣/家居服</option><option value="551"> S 睡袋/吊床</option><option value="164"> S 碎纸机</option><option value="819"> S 社会科学</option><option value="794"> S 社科</option><option value="415"> S 私密护理</option><option value="423"> S 腮红</option><option value="184"> S 色带</option><option value="335"> S 设计师/潮牌</option><option value="371"> S 设计师/潮牌</option><option value="42"> S 身体护肤</option><option value="758"> S 适用年龄</option><option value="520"> S 速干衣裤</option><option value="211"> S 鼠标</option><option value="220"> S 鼠标垫</option><option value="332"> T T恤</option><option value="365"> T T恤</option><option value="535"> T T恤</option><option value="581"> T T恤</option><option value="833"> T 体育</option><option value="56"> T 体育用品</option><option value="426"> T 剃须</option><option value="139"> T 剃须刀</option><option value="192"> T 台式机</option><option value="317"> T 台灯</option><option value="512"> T 台球</option><option value="379"> T 唐装/中山装</option><option value="11"> T 图书、音像、电子书</option><option value="456"> T 天然木饰</option><option value="640"> T 头枕腰靠</option><option value="408"> T 套装</option><option value="412"> T 套装</option><option value="420"> T 套装</option><option value="427"> T 套装</option><option value="430"> T 套装</option><option value="741"> T 套装</option><option value="530"> T 徒步鞋</option><option value="166"> T 投影配件</option><option value="570"> T 拖鞋</option><option value="475"> T 拖鞋/人字拖</option><option value="489"> T 拖鞋/人字拖</option><option value="710"> T 提篮式</option><option value="288"> T 毯子</option><option value="672"> T 添加剂</option><option value="127"> T 烫衣机</option><option value="81"> T 童装童鞋</option><option value="75"> T 童车童床</option><option value="310"> T 筒灯射灯</option><option value="649"> T 胎压监测</option><option value="416"> T 脱毛膏</option><option value="683"> T 贴膜</option><option value="102"> T 贴膜,保护套</option><option value="603"> T 踏步机</option><option value="801"> T 通俗流行</option><option value="216"> U UPS</option><option value="217"> U U盘</option><option value="23"> W 五金交电</option><option value="275"> W 五金工具</option><option value="315"> W 五金电器</option><option value="300"> W 卧室家具</option><option value="413"> W 卫生巾</option><option value="414"> W 卫生护垫</option><option value="348"> W 卫衣</option><option value="361"> W 卫衣</option><option value="592"> W 卫衣/套头衫</option><option value="378"> W 卫裤/运动裤</option><option value="74"> W 喂养用品</option><option value="787"> W 外文原版</option><option value="29"> W 外设产品</option><option value="800"> W 外语学习</option><option value="759"> W 娃娃玩具</option><option value="654"> W 微型车</option><option value="137"> W 微波炉</option><option value="178"> W 文具管理</option><option value="26"> W 文具耗材</option><option value="821"> W 文化</option><option value="793"> W 文学</option><option value="808"> W 文学</option><option value="384"> W 文胸</option><option value="728"> W 文胸/内裤</option><option value="400"> W 文胸套装</option><option value="90"> W 文艺</option><option value="547"> W 望远镜</option><option value="595"> W 武术搏击</option><option value="83"> W 玩具乐器</option><option value="699"> W 碗盘叉勺</option><option value="72"> W 维修保养</option><option value="677"> W 维修配件</option><option value="156"> W 网卡</option><option value="510"> W 网球</option><option value="24"> W 网络产品</option><option value="215"> W 网络仪表仪器</option><option value="158"> W 网络存储</option><option value="160"> W 网络盒子</option><option value="154"> W 网络配件</option><option value="284"> W 蚊帐</option><option value="805"> X 乡村民谣</option><option value="392"> X 休闲棉袜</option><option value="529"> X 休闲衣裤</option><option value="329"> X 休闲裤</option><option value="353"> X 休闲裤</option><option value="445"> X 休闲运动包</option><option value="480"> X 休闲鞋</option><option value="491"> X 休闲鞋</option><option value="534"> X 休闲鞋</option><option value="567"> X 休闲鞋</option><option value="695"> X 吸奶器</option><option value="618"> X 吸尘器</option><option value="308"> X 吸顶灯</option><option value="703"> X 学步车</option><option value="118"> X 学生平板</option><option value="190"> X 学生文具</option><option value="655"> X 小型车</option><option value="337"> X 小西装</option><option value="790"> X 小说</option><option value="807"> X 小说</option><option value="823"> X 心理学</option><option value="504"> X 斜挎包</option><option value="204"> X 显卡</option><option value="201"> X 显示器</option><option value="431"> X 洗发</option><option value="48"> X 洗发护发</option><option value="73"> X 洗护用品</option><option value="256"> X 洗护美容</option><option value="232"> X 洗晒/熨烫</option><option value="133"> X 洗衣机</option><option value="689"> X 洗衣液/皂</option><option value="625"> X 洗车工具</option><option value="626"> X 洗车配件</option><option value="446"> X 相机包</option><option value="244"> X 相框/照片墙</option><option value="180"> X 硒鼓/墨粉</option><option value="406"> X 纤体塑形</option><option value="69"> X 线下服务</option><option value="210"> X 线缆</option><option value="679"> X 蓄电池</option><option value="143"> X 血压计</option><option value="617"> X 行车记录仪</option><option value="370"> X 西服</option><option value="373"> X 西服套装</option><option value="374"> X 西裤</option><option value="589"> X 训练服</option><option value="566"> X 训练鞋</option><option value="108"> X 选号码</option><option value="471"> X 雪地靴</option><option value="536"> X 雪地靴</option><option value="321"> X 雪纺衫</option><option value="744"> X 靴子</option><option value="7"> X 鞋、箱包、珠宝、手表</option><option value="305"> X 鞋架/衣帽架</option><option value="476"> X 鞋配件</option><option value="488"> X 鞋配件</option><option value="421"> X 香水</option><option value="630"> X 香水</option><option value="45"> X 香水彩妆</option><option value="247"> X 香薰蜡烛</option><option value="193"> Y 一体机</option><option value="98"> Y 一次性用品</option><option value="665"> Y 一汽奔腾</option><option value="149"> Y 仪表仪器</option><option value="600"> Y 仰卧板/收腹机</option><option value="839"> Y 医学</option><option value="258"> Y 医疗保健</option><option value="598"> Y 哑铃</option><option value="16"> Y 娱乐影视</option><option value="715"> Y 婴儿内衣</option><option value="714"> Y 婴儿外出服</option><option value="753"> Y 婴儿尿裤</option><option value="708"> Y 婴儿床</option><option value="701"> Y 婴儿推车</option><option value="716"> Y 婴儿礼盒</option><option value="717"> Y 婴儿鞋帽袜</option><option value="719"> Y 婴幼奶粉</option><option value="832"> Y 孕产</option><option value="722"> Y 孕妇装</option><option value="727"> Y 孕妈美容</option><option value="723"> Y 孕期营养</option><option value="778"> Y 幼儿启蒙</option><option value="643"> Y 应急救援</option><option value="316"> Y 应急灯/手电</option><option value="772"> Y 影视</option><option value="770"> Y 影视/动漫周边</option><option value="803"> Y 摇滚说唱</option><option value="729"> Y 月子装</option><option value="806"> Y 有声读物</option><option value="274"> Y 油漆涂料</option><option value="576"> Y 泳帽</option><option value="388"> Y 泳衣</option><option value="575"> Y 泳镜</option><option value="230"> Y 浴室用品</option><option value="151"> Y 浴霸/排气扇</option><option value="769"> Y 游戏</option><option value="223"> Y 游戏周边</option><option value="224"> Y 游戏机</option><option value="225"> Y 游戏耳机</option><option value="30"> Y 游戏设备</option><option value="222"> Y 游戏软件</option><option value="577"> Y 游泳包防水包</option><option value="61"> Y 游泳用品</option><option value="746"> Y 演出服</option><option value="410"> Y 牙刷/牙线</option><option value="696"> Y 牙胶安抚</option><option value="409"> Y 牙膏/牙粉</option><option value="762"> Y 益智玩具</option><option value="736"> Y 益生菌/初乳</option><option value="424"> Y 眼部</option><option value="206"> Y 硬盘</option><option value="219"> Y 移动硬盘</option><option value="320"> Y 羊毛衫</option><option value="352"> Y 羊毛衫</option><option value="324"> Y 羊绒衫</option><option value="367"> Y 羊绒衫</option><option value="515"> Y 羽毛球</option><option value="331"> Y 羽绒服</option><option value="364"> Y 羽绒服</option><option value="590"> Y 羽绒服</option><option value="526"> Y 羽绒服/棉服</option><option value="740"> Y 羽绒服/棉服</option><option value="447"> Y 腰包/胸包</option><option value="812"> Y 艺术</option><option value="776"> Y 英文原版书</option><option value="80"> Y 营养辅食</option><option value="293"> Y 衣柜</option><option value="96"> Y 衣物清洁</option><option value="532"> Y 越野跑鞋</option><option value="572"> Y 运动包</option><option value="588"> Y 运动套装</option><option value="8"> Y 运动户外</option><option value="604"> Y 运动护具</option><option value="742"> Y 运动服</option><option value="62"> Y 运动服饰</option><option value="586"> Y 运动背心</option><option value="583"> Y 运动裤</option><option value="585"> Y 运动配饰</option><option value="745"> Y 运动鞋</option><option value="60"> Y 运动鞋包</option><option value="14"> Y 运营商</option><option value="760"> Y 遥控/电动</option><option value="540"> Y 野餐烧烤</option><option value="441"> Y 钥匙包</option><option value="501"> Y 钥匙包</option><option value="461"> Y 银饰</option><option value="296"> Y 阳台/户外</option><option value="229"> Y 雨伞雨具</option><option value="680"> Y 雨刷</option><option value="473"> Y 雨鞋/雨靴</option><option value="492"> Y 雨鞋/雨靴</option><option value="771"> Y 音乐</option><option value="84"> Y 音像</option><option value="116"> Y 音响麦克风</option><option value="126"> Y 饮水机</option><option value="174"> Y 验钞/点钞机</option><option value="470"> Y 鱼嘴鞋</option><option value="559"> Y 鱼竿鱼线</option><option value="568"> Z 专项运动鞋</option><option value="111"> Z 中国移动</option><option value="657"> Z 中型车</option><option value="658"> Z 中大型车</option><option value="798"> Z 中小学教辅</option><option value="338"> Z 中老年女装</option><option value="360"> Z 中老年男装</option><option value="202"> Z 主板</option><option value="818"> Z 哲学/宗教</option><option value="712"> Z 增高垫</option><option value="487"> Z 增高鞋</option><option value="796"> Z 字典词典</option><option value="549"> Z 帐篷/垫子</option><option value="692"> Z 座便器</option><option value="635"> Z 座垫</option><option value="637"> Z 座套</option><option value="463"> Z 座钟挂钟</option><option value="531"> Z 抓绒衣裤</option><option value="610"> Z 折叠车</option><option value="114"> Z 支架</option><option value="824"> Z 政治/军事</option><option value="782"> Z 智力开发</option><option value="467"> Z 智能手表</option><option value="614"> Z 智能驾驶</option><option value="775"> Z 杂志/期刊</option><option value="236"> Z 桌布/罩件</option><option value="334"> Z 正装裤</option><option value="495"> Z 正装鞋</option><option value="458"> Z 珍珠</option><option value="51"> Z 珠宝</option><option value="346"> Z 真皮皮衣</option><option value="358"> Z 真皮皮衣</option><option value="95"> Z 纸品湿巾</option><option value="186"> Z 纸类</option><option value="197"> Z 组装电脑</option><option value="597"> Z 综合训练器</option><option value="705"> Z 自行车</option><option value="646"> Z 自驾野营</option><option value="269"> Z 装修服务</option><option value="209"> Z 装机配件</option><option value="175"> Z 装订/封装机</option><option value="246"> Z 装饰字画</option><option value="239"> Z 装饰摆件</option><option value="268"> Z 装饰材料</option><option value="318"> Z 装饰灯</option><option value="142"> Z 足浴盆</option><option value="519"> Z 足球</option><option value="573"> Z 足球鞋</option><option value="434"> Z 造型</option><option value="349"> Z 针织衫</option><option value="372"> Z 针织衫</option><option value="52"> Z 钟表</option><option value="237"> Z 钟饰</option><option value="455"> Z 钻石</option>                  </select>
                </div>
                <div class="form-group">
                  <select name="brand_id" id="brand_id" class="form-control">
                    <option value="">所有品牌</option>
                        <option value="224">  --   361°</option><option value="80">  --   倩碧/CLINIQUE</option><option value="194">  --   宏碁/acer</option><option value="27">  --   怡达/yida</option><option value="310">  --   斐利比/Philippi</option><option value="118">  --   榄菊</option><option value="258">  --   缪缪/MIU MIU</option><option value="280">  --   蔻驰/COACH</option><option value="214">A  --   A21</option><option value="266">A  --   Amii</option><option value="308">A  --   奥迪双钻/AULDEY</option><option value="64">A  --   安佳/Anchor</option><option value="135">A  --   安佳/Anchor</option><option value="207">A  --   安踏/ANTA ( 男装、女装、童装、内衣 ) </option><option value="231">A  --   安踏/ANTA ( 运动户外 ) </option><option value="237">A  --   昂立/Onlly</option><option value="345">A  --   澳佳宝/BLACKMORES</option><option value="155">A  --   澳西奴</option><option value="309">A  --   澳贝/auby</option><option value="263">A  --   爱华仕/Oiwas</option><option value="328">A  --   爱安德/AND</option><option value="327">A  --   爱科来/arkray</option><option value="73">A  --   艾美/Emmi</option><option value="41">A  --   阿华田/Ovaltine</option><option value="21">A  --   阿尔卑斯/Alpenliebe</option><option value="268">A  --   阿札/A-ZA</option><option value="264">A  --   阿玛尼/EMPORIO ARMANI ( 鞋、箱包、珠宝、手表 ) </option><option value="286">A  --   阿玛尼/EMPORIO ARMANI ( 鞋、箱包、珠宝、手表 ) </option><option value="201">A  --   阿迪达斯/adidas ( 男装、女装、童装、内衣 ) </option><option value="221">A  --   阿迪达斯/adidas ( 运动户外 ) </option><option value="289">B  --   BUREI</option><option value="167">B  --   倍轻松/bero</option><option value="315">B  --   兵兵</option><option value="171">B  --   北欧欧慕/nathome</option><option value="275">B  --   变形金刚/Transformers</option><option value="208">B  --   宝娜斯</option><option value="336">B  --   宝氏/Post</option><option value="257">B  --   宝缇嘉/Bottega Veneta</option><option value="301">B  --   宝视达</option><option value="274">B  --   巴宝莉/Burberry</option><option value="233">B  --   彪马/Puma</option><option value="83">B  --   泊美/PUREMILD</option><option value="25">B  --   波力/PO-LI</option><option value="202">B  --   波司登/Bosideng</option><option value="267">B  --   波斯丹顿/Bostanten</option><option value="33">B  --   百味林</option><option value="79">B  --   碧欧泉/BIOTHERM</option><option value="243">B  --   碧生源/Besunyen</option><option value="296">B  --   秉信</option><option value="96">B  --   贝因美/BEINGMATE</option><option value="70">B  --   贝尔/BEIER</option><option value="265">B  --   贝尔/BEIER ( 鞋、箱包、珠宝、手表 ) </option><option value="177">B  --   贝尔斯顿/BESTDAY</option><option value="311">B  --   邦迪/BAND-AID</option><option value="246">C  --   初元</option><option value="210">C  --   初语/TOYOUTH</option><option value="218">C  --   川崎/kawasaki</option><option value="22">C  --   春光/chun guang</option><option value="173">C  --   春笑</option><option value="42">C  --   晨光/MG</option><option value="298">C  --   灿坤/EUPA</option><option value="121">C  --   超能</option><option value="270">D  --   DOODOO</option><option value="12">D  --   东信/EASTCOM</option><option value="85">D  --   丹姿/DANZ</option><option value="276">D  --   哆啦A梦/Doraemon</option><option value="31">D  --   多力多滋/Doritos</option><option value="92">D  --   多美滋/Dumex</option><option value="68">D  --   多美鲜/Suki</option><option value="142">D  --   多美鲜/Suki</option><option value="76">D  --   大宝/Dabao</option><option value="295">D  --   大富翁/Uncle Wang</option><option value="338">D  --   大王/GOO.N</option><option value="176">D  --   德国博朗/BRAUN</option><option value="52">D  --   德运/Devondale</option><option value="66">D  --   德运/Devondale</option><option value="137">D  --   德运/Devondale</option><option value="337">D  --   德运/Devondale</option><option value="102">D  --   德运/Devondale ( 母婴用品、儿童玩具 ) </option><option value="183">D  --   戴尔/DELL</option><option value="288">D  --   杜嘉班纳/DG</option><option value="112">D  --   滴露/Dettol</option><option value="222">D  --   迪士尼/Disney ( 运动户外 ) </option><option value="282">D  --   迪士尼/Disney ( 鞋、箱包、珠宝、手表 ) </option><option value="115">D  --   雕牌</option><option value="44">D  --   顶好/Soyfresh</option><option value="56">D  --   顶好/Soyfresh</option><option value="254">E  --   ELLE ( 鞋、箱包、珠宝、手表 ) </option><option value="272">E  --   ELLE ( 鞋、箱包、珠宝、手表 ) </option><option value="18">E  --   E人E本</option><option value="297">F  --   福库/Cuckoo</option><option value="81">F  --   芳珂/Fancl</option><option value="54">F  --   风行</option><option value="175">F  --   飞利浦/PHILIPS ( 家用电器 ) </option><option value="7">F  --   飞利浦/PHILIPS ( 手机 、 数码 、 通信 ) </option><option value="278">G  --   GUESS</option><option value="129">G  --   光明</option><option value="165">G  --   光明 ( 家用电器 ) </option><option value="256">G  --   古驰/Gucci</option><option value="232">G  --   哥伦比亚/Columbia</option><option value="252">G  --   广元堂</option><option value="162">G  --   格致诚品</option><option value="38">G  --   桂格/QUAKER</option><option value="61">G  --   葛兰纳诺/GRANAROLO</option><option value="334">G  --   钙尔奇/Caltrate</option><option value="101">G  --   高培/GlodMax</option><option value="10">H  --   HTC</option><option value="343">H  --   亨氏/Heinz</option><option value="1">H  --   华为/HUAWEI</option><option value="146">H  --   华乐/huale</option><option value="37">H  --   华味亨</option><option value="186">H  --   华硕/ASUS</option><option value="340">H  --   和光堂/WaKODO</option><option value="225">H  --   回力/Warrior</option><option value="147">H  --   好伴侣/hao ban lv</option><option value="248">H  --   好医生</option><option value="238">H  --   恒寿堂/HENG SHOU TANG</option><option value="182">H  --   惠普/hp</option><option value="93">H  --   惠氏/Wyeth</option><option value="19">H  --   海信/Hisense</option><option value="143">H  --   海天下</option><option value="14">H  --   海尔/Haier</option><option value="314">H  --   海氏海诺/HAINUO</option><option value="281">H  --   海鸥表/Sea-Gull</option><option value="24">H  --   皇冠/Danisa</option><option value="247">H  --   红桃K</option><option value="331">H  --   花王/Merries</option><option value="200">H  --   花花公子/PLAYBOY</option><option value="131">H  --   鸿福堂/HUNG FOOK TONG</option><option value="307">J  --   九阳/Joyoung</option><option value="89">J  --   京润珍珠</option><option value="91">J  --   娇兰/Guerlain</option><option value="110">J  --   娇妍/JOLLY</option><option value="126">J  --   洁霸/Attack</option><option value="109">J  --   绝对宝贝/JUST BABY</option><option value="84">J  --   近江蔓莎</option><option value="189">J  --   金士顿/Kingston</option><option value="321">J  --   金奥力</option><option value="269">K  --   克路驰/CLUCI</option><option value="174">K  --   凯仕乐/KASRROW</option><option value="229">K  --   凯速</option><option value="251">K  --   凯镛</option><option value="226">K  --   匡威/Converse</option><option value="39">K  --   卡夫/KRAFT</option><option value="330">K  --   卡夫/KRAFT</option><option value="74">K  --   卡姿兰/CARSLAN</option><option value="108">K  --   卡瑞特兹/Karivita</option><option value="341">K  --   可瑞康/Karicare</option><option value="104">K  --   可瑞康/Karicare ( 母婴用品、儿童玩具 ) </option><option value="138">K  --   坎诺拉/Canola</option><option value="179">K  --   康夫/kangfu</option><option value="150">K  --   康尔馨/Canasin</option><option value="32">K  --   康师傅/Master Kong</option><option value="319">K  --   康扉/KANGFEI</option><option value="67">K  --   康维多/Primavita</option><option value="103">K  --   康维多/Primavita ( 母婴用品、儿童玩具 ) </option><option value="116">K  --   开米/Kami</option><option value="300">K  --   开馨宝/KAI XIN BAO</option><option value="191">K  --   开馨宝/KAI XIN BAO ( 电脑、办公 ) </option><option value="141">K  --   科尔沁/KERCHIN</option><option value="180">K  --   酷力</option><option value="333">L  --   LG</option><option value="30">L  --   乐事/Lay s</option><option value="294">L  --   乐比比/LEBIBI</option><option value="140">L  --   乐芝牛/The Laughing Cow</option><option value="163">L  --   六朝家居/luc life</option><option value="145">L  --   兰皇</option><option value="82">L  --   兰芝/LANEIGE</option><option value="78">L  --   兰蔻/LANCOME</option><option value="71">L  --   兰诺斯/Lemnos</option><option value="299">L  --   利仁/LIVEN</option><option value="271">L  --   拉菲斯汀/Lafestin</option><option value="46">L  --   李子园</option><option value="285">L  --   李维斯/Levi s</option><option value="157">L  --   来赉</option><option value="98">L  --   林贝儿/IMPERIAL.XO</option><option value="273">L  --   浪琴/Longines</option><option value="36">L  --   立丰/lifefun</option><option value="119">L  --   立白/Liby</option><option value="124">L  --   绿伞/EVER GREEN</option><option value="34">L  --   绿帝/green king</option><option value="75">L  --   老中医</option><option value="193">L  --   联想/Lenovo</option><option value="154">L  --   莱薇/Lavie</option><option value="123">L  --   蓝月亮</option><option value="158">L  --   路途乐</option><option value="90">L  --   隆力奇/LONGLIQI</option><option value="318">L  --   零听</option><option value="153">L  --   零听 ( 家居、家具、家装、厨具 ) </option><option value="181">L  --   雷瓦/RIWA</option><option value="227">L  --   骆驼/CAMEL</option><option value="234">L  --   骆驼牌</option><option value="159">L  --   龙之涵</option><option value="325">L  --   龙贝儿/Loboor</option><option value="113">M  --   妙管家/MAGIC AMAH</option><option value="2">M  --   摩托罗拉/MOTOROLA</option><option value="106">M  --   明一/wissun</option><option value="199">M  --   明基/BenQ</option><option value="287">M  --   梅花/Titoni</option><option value="213">M  --   梦娜/MengNa</option><option value="152">M  --   梦特娇/MONTAGUT ( 家居、家具、家装、厨具 ) </option><option value="259">M  --   梦特娇/MONTAGUT ( 鞋、箱包、珠宝、手表 ) </option><option value="28">M  --   母亲</option><option value="178">M  --   美克斯/MKS</option><option value="344">M  --   谜尚/MISSHA</option><option value="326">M  --   迈克大夫/microlife</option><option value="230">N  --   NIKKO</option><option value="139">N  --   NPG</option><option value="303">N  --   内野/UCHINO</option><option value="62">N  --   南阳</option><option value="107">N  --   牛奶客/Neolac</option><option value="13">N  --   纽曼/Newsmy</option><option value="250">N  --   纽曼思/Nemans</option><option value="63">N  --   纽瑞滋/Nouriz</option><option value="100">N  --   纽瑞滋/Nouriz ( 母婴用品、儿童玩具 ) </option><option value="220">N  --   耐克/NIKE</option><option value="149">N  --   诺伊曼/noyoke</option><option value="346">N  --   诺优能/Nutrilon</option><option value="5">N  --   诺基亚/NOKIA ( 手机 、 数码 、 通信 ) </option><option value="198">N  --   诺基亚/NOKIA ( 电脑、办公 ) </option><option value="209">O  --   ONEBUYE</option><option value="8">O  --   OPPO</option><option value="215">O  --   OopsCiah</option><option value="322">O  --   欧姆龙/Omron</option><option value="51">O  --   欧德堡/OLDENBURGER</option><option value="65">O  --   欧德堡/OLDENBURGER</option><option value="136">O  --   欧德堡/OLDENBURGER</option><option value="88">O  --   欧莱雅/L OREAL</option><option value="29">P  --   品客/Pringles</option><option value="49">P  --   帕斯卡/PASCUAL</option><option value="60">P  --   帕斯卡/PASCUAL</option><option value="151">P  --   普拉达/PULADA</option><option value="23">P  --   潘高寿</option><option value="236">P  --   潘高寿</option><option value="9">P  --   苹果/Apple ( 手机 、 数码 、 通信 ) </option><option value="184">P  --   苹果/Apple ( 电脑、办公 ) </option><option value="260">P  --   苹果/Apple ( 鞋、箱包、珠宝、手表 ) </option><option value="317">Q  --   强生/Johnson</option><option value="188">Q  --   清华同方</option><option value="206">Q  --   秋水伊人</option><option value="55">Q  --   雀巢/Nestle</option><option value="339">Q  --   雀巢/Nestle</option><option value="160">R  --   日光生活</option><option value="166">R  --   日立/HITACHI</option><option value="255">R  --   瑞士军刀/SWISSGEAR</option><option value="335">R  --   瑞士莲/Lindt</option><option value="72">R  --   瑞慕/swiss mooh</option><option value="216">R  --   若美/nomi</option><option value="219">R  --   锐步/Reebok</option><option value="169">S  --   SKG</option><option value="99">S  --   三元</option><option value="240">S  --   三叶</option><option value="57">S  --   三得利/SUNTORY</option><option value="15">S  --   三星/SAMSUNG</option><option value="196">S  --   三星/SAMSUNG ( 电脑、办公 ) </option><option value="249">S  --   三金</option><option value="35">S  --   上好佳/Oishi</option><option value="130">S  --   双汇/shineway</option><option value="172">S  --   双鸟/twinbird</option><option value="332">S  --   善存/Centrum</option><option value="134">S  --   思念/SYNEAR</option><option value="122">S  --   扇牌</option><option value="277">S  --   施华洛世奇/Swarovski</option><option value="217">S  --   森马/Semir</option><option value="164">S  --   沙宣/VS</option><option value="69">S  --   深蓝健康/DEEP BLUE HEALTH</option><option value="120">S  --   狮王/LION</option><option value="48">S  --   生机谷/LIVING PLANET</option><option value="59">S  --   生机谷/LIVING PLANET</option><option value="4">S  --   索尼/SONY ( 手机 、 数码 、 通信 ) </option><option value="197">S  --   索尼/SONY ( 电脑、办公 ) </option><option value="262">S  --   赛琳/CELINE</option><option value="11">S  --   首信/capital</option><option value="6">T  --   TCL</option><option value="187">T  --   ThinkPad</option><option value="203">T  --   唐狮/Tonlion</option><option value="161">T  --   图强/TU QIANF TOWEL</option><option value="283">T  --   天梭/Tissot</option><option value="284">T  --   天王表/TIAN WANG</option><option value="53">T  --   天香</option><option value="228">T  --   探路者/Toread</option><option value="242">T  --   泰尔</option><option value="223">T  --   特步/Xtep</option><option value="105">T  --   特福芬/Topfer</option><option value="47">T  --   田园/COUNTRY GOODNESS</option><option value="58">T  --   田园/COUNTRY GOODNESS</option><option value="292">T  --   贴贴</option><option value="253">U  --   UTU</option><option value="16">W  --   万利达/malata</option><option value="279">W  --   万宝龙/Montblanc</option><option value="156">W  --   吾家元素</option><option value="132">W  --   味千拉面/AJISEN RAMEN</option><option value="114">W  --   威洁士/Walex</option><option value="111">W  --   威露士/Walch</option><option value="190">W  --   微星/MSI</option><option value="185">W  --   微软/Microsoft</option><option value="144">W  --   湾仔码头</option><option value="40">W  --   维维</option><option value="320">X  --   仙鹤牌</option><option value="313">X  --   信乐/SINO</option><option value="20">X  --   喜之郎/STRONG</option><option value="50">X  --   喜乐</option><option value="342">X  --   夏依/summer eve</option><option value="127">X  --   小林</option><option value="306">X  --   小熊/Bear</option><option value="349">X  --   小米</option><option value="3">X  --   小辣椒</option><option value="128">X  --   新雅/sunya</option><option value="329">X  --   星巴克/STARBUCKS</option><option value="17">X  --   现代/HYUNDAI</option><option value="77">X  --   相宜本草/INOHERB</option><option value="195">X  --   西部数据/WD</option><option value="316">X  --   西门子/SIEMENS</option><option value="261">X  --   香奈儿/CHANEL</option><option value="302">X  --   香百年/Carori</option><option value="291">Y  --   一生一信/Infeel.Me</option><option value="245">Y  --   云南白药/YunnanBaiyao</option><option value="312">Y  --   云南白药/YunnanBaiyao</option><option value="43">Y  --   伊利</option><option value="94">Y  --   伊利 ( 母婴用品、儿童玩具 ) </option><option value="293">Y  --   伊莱克斯/Electrolux</option><option value="168">Y  --   优冠</option><option value="192">Y  --   优派/ViewSonic</option><option value="239">Y  --   养生堂</option><option value="148">Y  --   养鹅人</option><option value="290">Y  --   友邦</option><option value="212">Y  --   幽迷/Youmi</option><option value="241">Y  --   御生堂</option><option value="304">Y  --   悠嘻猴</option><option value="170">Y  --   易简/Yijan</option><option value="244">Y  --   益力健</option><option value="97">Y  --   益力健 ( 母婴用品、儿童玩具 ) </option><option value="125">Y  --   裕华</option><option value="86">Y  --   郁美净</option><option value="45">Y  --   银鹭</option><option value="211">Y  --   雅可希/YAKEXI</option><option value="324">Y  --   雅培/Abbott</option><option value="95">Y  --   雅士利/YASHILY</option><option value="204">Y  --   雅鹿</option><option value="133">Y  --   雨润/Yurun</option><option value="323">Y  --   鱼跃/yuyue</option><option value="305">Z  --   卓朗/ZoomLand</option><option value="26">Z  --   张二嘎</option><option value="87">Z  --   昭贵</option><option value="117">Z  --   正章</option><option value="205">Z  --   真维斯/Jeanswest</option><option value="235">Z  --   自由兵/FREE SOLDIER</option>                  </select>
                </div>                

                <div class="form-group">
                  <select name="is_on_sale" id="is_on_sale" class="form-control">
                    <option value="">全部</option>                  
                    <option value="1">上架</option>
                    <option value="0">下架</option>
                  </select>
                </div>                
                <div class="form-group">
                    <select name="intro" class="form-control">
                        <option value="0">全部</option>
                        <option value="is_new">新品</option>
                        <option value="is_recommend">推荐</option>
                    </select>                
                </div>                  
				<br>
				<br>
                <div class="form-group">
                  <label class="control-label" for="input-order-id">关键词</label>
                  <div class="input-group">
                    <input name="key_word" value="" placeholder="搜索词" id="input-order-id" class="form-control" type="text">
                  </div>
                </div>                  
                <!--排序规则-->
                <input name="orderby1" value="goods_id" type="hidden">
                <input name="orderby2" value="desc" type="hidden">
                <button type="submit" onclick="ajax_get_table('search-form2',1)" id="button-filter search-order" class="btn btn-primary"><i class="fa fa-search"></i> 筛选</button>
                <button type="button" onclick="location.href='${ctx}/product/add'" class="btn btn-primary pull-right"><i class="fa fa-plus"></i>添加新商品</button>
              <input name="__hash__" value="934c3c704c4bed5cb4da6cec6353613a_2e4eb53d2afc41d11040df3ef57fa1ca" type="hidden"></form>
          </div>
          <div id="ajax_return"><form method="post" enctype="multipart/form-data" target="_blank" id="form-order">
    <div class="table-responsive">
        <table class="table table-bordered table-hover">
            <thead>
            <tr>
                <td style="width: 1px;" class="text-center">
                <!--
                    <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);">
                -->    
                </td>                
                <td class="text-right">
                    <a href="javascript:sort('goods_id');">ID</a>
                </td>
                <td class="text-left">
                    <a href="javascript:sort('goods_name');">商品名称</a>
                </td>
                <td class="text-left">
                    <a href="javascript:sort('goods_sn');">货号</a>
                </td>                                
                <td class="text-left">
                    <a href="javascript:sort('cat_id');">分类</a>
                </td>                
                <td class="text-left">
                    <a href="javascript:sort('shop_price');">价格</a>
                </td>
                <td class="text-left">
                    <a href="javascript:void(0);">库存</a>
                </td>                
                <td class="text-center">
                    <a href="javascript:sort('is_on_sale');">上架</a>
                </td>
                <td class="text-center">
                    <a href="javascript:sort('is_recommend');">推荐</a>
                </td>
                <td class="text-center">
                    <a href="javascript:sort('is_new');">新品</a>
                </td>   
                <td class="text-center">
                    <a href="javascript:sort('is_hot');">热卖</a>
                </td>                   
                <td class="text-center">
                    <a href="javascript:sort('sort');">排序</a>
                </td>                   
                <td class="text-center" style="width:135px;">操作</td>
            </tr>
            </thead>
            <tbody>
            <tr>
                    <td class="text-center">
                       <!-- <input type="checkbox" name="selected[]" value="6">-->
                        <input name="shipping_code[]" value="flat.flat" type="hidden">
                    </td>
                    <td class="text-right">143</td>
                    <td class="text-left">haier海尔 BC-93TMPF 93升单门冰箱</td>
                    <td class="text-left">TP0000143</td>
                    <td class="text-left">大家电</td>
                    <td class="text-left">0.01</td>
                    <td class="text-left">
                    <input onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onchange="ajaxUpdateField(this);" name="store_count" size="4" data-table="goods" data-id="143" value="984" type="text">   
                    </td>
                    <td class="text-center">                        
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','143','is_on_sale',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','143','is_recommend',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/cancel.png" onclick="changeTableVal('goods','goods_id','143','is_new',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','143','is_hot',this)" width="20" height="20">
                    </td>                                        
                    <td class="text-center">                         
                        <input onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="this.value=this.value.replace(/[^\d]/g,'')" onchange="updateSort('goods','goods_id','143','sort',this)" size="4" value="50" type="text">
                    </td>                    
                    <td class="text-center">
                        <a target="_blank" href="/index/Home/Goods/goodsInfo/id/143" class="btn btn-info" title="查看详情"><i class="fa fa-eye"></i></a>
                        <a href="product-add.jsp" class="btn btn-primary" title="编辑"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:void(0);" onclick="del('143')" class="btn btn-danger" title="删除"><i class="fa fa-trash-o"></i></a>
                    </td>                        
                </tr><tr>
                    <td class="text-center">
                       <!-- <input type="checkbox" name="selected[]" value="6">-->
                        <input name="shipping_code[]" value="flat.flat" type="hidden">
                    </td>
                    <td class="text-right">142</td>
                    <td class="text-left">海尔（Haier）BCD-251WDGW 251升 无霜两门冰箱（...</td>
                    <td class="text-left">TP0000142</td>
                    <td class="text-left">大家电</td>
                    <td class="text-left">2699.00</td>
                    <td class="text-left">
                    <input onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onchange="ajaxUpdateField(this);" name="store_count" size="4" data-table="goods" data-id="142" value="1000" type="text">   
                    </td>
                    <td class="text-center">                        
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','142','is_on_sale',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','142','is_recommend',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/cancel.png" onclick="changeTableVal('goods','goods_id','142','is_new',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','142','is_hot',this)" width="20" height="20">
                    </td>                                        
                    <td class="text-center">                         
                        <input onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="this.value=this.value.replace(/[^\d]/g,'')" onchange="updateSort('goods','goods_id','142','sort',this)" size="4" value="50" type="text">
                    </td>                    
                    <td class="text-center">
                        <a target="_blank" href="/index/Home/Goods/goodsInfo/id/142" class="btn btn-info" title="查看详情"><i class="fa fa-eye"></i></a>
                        <a href="product-add.jsp" class="btn btn-primary" title="编辑"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:void(0);" onclick="del('142')" class="btn btn-danger" title="删除"><i class="fa fa-trash-o"></i></a>
                    </td>                        
                </tr><tr>
                    <td class="text-center">
                       <!-- <input type="checkbox" name="selected[]" value="6">-->
                        <input name="shipping_code[]" value="flat.flat" type="hidden">
                    </td>
                    <td class="text-right">141</td>
                    <td class="text-left">三星 Galaxy A9高配版 (A9100) 精灵黑 全网通4G...</td>
                    <td class="text-left">TP0000141</td>
                    <td class="text-left">手机</td>
                    <td class="text-left">3499.00</td>
                    <td class="text-left">
                    <input onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onchange="ajaxUpdateField(this);" name="store_count" size="4" data-table="goods" data-id="141" value="1000" type="text">   
                    </td>
                    <td class="text-center">                        
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','141','is_on_sale',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','141','is_recommend',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/cancel.png" onclick="changeTableVal('goods','goods_id','141','is_new',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','141','is_hot',this)" width="20" height="20">
                    </td>                                        
                    <td class="text-center">                         
                        <input onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="this.value=this.value.replace(/[^\d]/g,'')" onchange="updateSort('goods','goods_id','141','sort',this)" size="4" value="50" type="text">
                    </td>                    
                    <td class="text-center">
                        <a target="_blank" href="/index/Home/Goods/goodsInfo/id/141" class="btn btn-info" title="查看详情"><i class="fa fa-eye"></i></a>
                        <a href="product-add.jsp" class="btn btn-primary" title="编辑"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:void(0);" onclick="del('141')" class="btn btn-danger" title="删除"><i class="fa fa-trash-o"></i></a>
                    </td>                        
                </tr><tr>
                    <td class="text-center">
                       <!-- <input type="checkbox" name="selected[]" value="6">-->
                        <input name="shipping_code[]" value="flat.flat" type="hidden">
                    </td>
                    <td class="text-right">140</td>
                    <td class="text-left">Apple iPhone 6s 16GB 玫瑰金色 移动联通电信4...</td>
                    <td class="text-left">TP0000140</td>
                    <td class="text-left">手机</td>
                    <td class="text-left">4858.00</td>
                    <td class="text-left">
                    <input onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onchange="ajaxUpdateField(this);" name="store_count" size="4" data-table="goods" data-id="140" value="1000" type="text">   
                    </td>
                    <td class="text-center">                        
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','140','is_on_sale',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','140','is_recommend',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/cancel.png" onclick="changeTableVal('goods','goods_id','140','is_new',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','140','is_hot',this)" width="20" height="20">
                    </td>                                        
                    <td class="text-center">                         
                        <input onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="this.value=this.value.replace(/[^\d]/g,'')" onchange="updateSort('goods','goods_id','140','sort',this)" size="4" value="50" type="text">
                    </td>                    
                    <td class="text-center">
                        <a target="_blank" href="/index/Home/Goods/goodsInfo/id/140" class="btn btn-info" title="查看详情"><i class="fa fa-eye"></i></a>
                        <a href="product-add.jsp" class="btn btn-primary" title="编辑"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:void(0);" onclick="del('140')" class="btn btn-danger" title="删除"><i class="fa fa-trash-o"></i></a>
                    </td>                        
                </tr><tr>
                    <td class="text-center">
                       <!-- <input type="checkbox" name="selected[]" value="6">-->
                        <input name="shipping_code[]" value="flat.flat" type="hidden">
                    </td>
                    <td class="text-right">139</td>
                    <td class="text-left">天翼小白49元纯流量卡（随机选号 只发辽宁）60元含100元资费</td>
                    <td class="text-left">TP0000139</td>
                    <td class="text-left">选号码</td>
                    <td class="text-left">60.00</td>
                    <td class="text-left">
                    <input onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onchange="ajaxUpdateField(this);" name="store_count" size="4" data-table="goods" data-id="139" value="1000" type="text">   
                    </td>
                    <td class="text-center">                        
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','139','is_on_sale',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','139','is_recommend',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/cancel.png" onclick="changeTableVal('goods','goods_id','139','is_new',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','139','is_hot',this)" width="20" height="20">
                    </td>                                        
                    <td class="text-center">                         
                        <input onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="this.value=this.value.replace(/[^\d]/g,'')" onchange="updateSort('goods','goods_id','139','sort',this)" size="4" value="50" type="text">
                    </td>                    
                    <td class="text-center">
                        <a target="_blank" href="/index/Home/Goods/goodsInfo/id/139" class="btn btn-info" title="查看详情"><i class="fa fa-eye"></i></a>
                        <a href="product-add.jsp" class="btn btn-primary" title="编辑"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:void(0);" onclick="del('139')" class="btn btn-danger" title="删除"><i class="fa fa-trash-o"></i></a>
                    </td>                        
                </tr><tr>
                    <td class="text-center">
                       <!-- <input type="checkbox" name="selected[]" value="6">-->
                        <input name="shipping_code[]" value="flat.flat" type="hidden">
                    </td>
                    <td class="text-right">138</td>
                    <td class="text-left">广州电信卡|4G定制卡|含50话费|手机卡号码卡|上网卡流量卡靓号</td>
                    <td class="text-left">TP0000138</td>
                    <td class="text-left">选号码</td>
                    <td class="text-left">79.00</td>
                    <td class="text-left">
                    <input onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onchange="ajaxUpdateField(this);" name="store_count" size="4" data-table="goods" data-id="138" value="1000" type="text">   
                    </td>
                    <td class="text-center">                        
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','138','is_on_sale',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','138','is_recommend',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/cancel.png" onclick="changeTableVal('goods','goods_id','138','is_new',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','138','is_hot',this)" width="20" height="20">
                    </td>                                        
                    <td class="text-center">                         
                        <input onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="this.value=this.value.replace(/[^\d]/g,'')" onchange="updateSort('goods','goods_id','138','sort',this)" size="4" value="50" type="text">
                    </td>                    
                    <td class="text-center">
                        <a target="_blank" href="/index/Home/Goods/goodsInfo/id/138" class="btn btn-info" title="查看详情"><i class="fa fa-eye"></i></a>
                        <a href="product-add.jsp" class="btn btn-primary" title="编辑"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:void(0);" onclick="del('138')" class="btn btn-danger" title="删除"><i class="fa fa-trash-o"></i></a>
                    </td>                        
                </tr><tr>
                    <td class="text-center">
                       <!-- <input type="checkbox" name="selected[]" value="6">-->
                        <input name="shipping_code[]" value="flat.flat" type="hidden">
                    </td>
                    <td class="text-right">137</td>
                    <td class="text-left">中麦通信4G联通网络手机靓号 170手机卡电话卡靓号卡可选号包邮</td>
                    <td class="text-left">TP0000137</td>
                    <td class="text-left">选号码</td>
                    <td class="text-left">500.00</td>
                    <td class="text-left">
                    <input onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onchange="ajaxUpdateField(this);" name="store_count" size="4" data-table="goods" data-id="137" value="1000" type="text">   
                    </td>
                    <td class="text-center">                        
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','137','is_on_sale',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','137','is_recommend',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/cancel.png" onclick="changeTableVal('goods','goods_id','137','is_new',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','137','is_hot',this)" width="20" height="20">
                    </td>                                        
                    <td class="text-center">                         
                        <input onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="this.value=this.value.replace(/[^\d]/g,'')" onchange="updateSort('goods','goods_id','137','sort',this)" size="4" value="50" type="text">
                    </td>                    
                    <td class="text-center">
                        <a target="_blank" href="/index/Home/Goods/goodsInfo/id/137" class="btn btn-info" title="查看详情"><i class="fa fa-eye"></i></a>
                        <a href="product-add.jsp" class="btn btn-primary" title="编辑"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:void(0);" onclick="del('137')" class="btn btn-danger" title="删除"><i class="fa fa-trash-o"></i></a>
                    </td>                        
                </tr><tr>
                    <td class="text-center">
                       <!-- <input type="checkbox" name="selected[]" value="6">-->
                        <input name="shipping_code[]" value="flat.flat" type="hidden">
                    </td>
                    <td class="text-right">136</td>
                    <td class="text-left">靓号0元送广东联通4G/3G手机卡上网卡大流量套餐全国无漫游选号</td>
                    <td class="text-left">TP0000136</td>
                    <td class="text-left">选号码</td>
                    <td class="text-left">120.00</td>
                    <td class="text-left">
                    <input onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onchange="ajaxUpdateField(this);" name="store_count" size="4" data-table="goods" data-id="136" value="200" type="text">   
                    </td>
                    <td class="text-center">                        
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','136','is_on_sale',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','136','is_recommend',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/cancel.png" onclick="changeTableVal('goods','goods_id','136','is_new',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','136','is_hot',this)" width="20" height="20">
                    </td>                                        
                    <td class="text-center">                         
                        <input onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="this.value=this.value.replace(/[^\d]/g,'')" onchange="updateSort('goods','goods_id','136','sort',this)" size="4" value="50" type="text">
                    </td>                    
                    <td class="text-center">
                        <a target="_blank" href="/index/Home/Goods/goodsInfo/id/136" class="btn btn-info" title="查看详情"><i class="fa fa-eye"></i></a>
                        <a href="product-add.jsp" class="btn btn-primary" title="编辑"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:void(0);" onclick="del('136')" class="btn btn-danger" title="删除"><i class="fa fa-trash-o"></i></a>
                    </td>                        
                </tr><tr>
                    <td class="text-center">
                       <!-- <input type="checkbox" name="selected[]" value="6">-->
                        <input name="shipping_code[]" value="flat.flat" type="hidden">
                    </td>
                    <td class="text-right">135</td>
                    <td class="text-left">重庆电信手机卡电话卡语音卡选靓号3G4G卡内部5折卡低资费（飞）</td>
                    <td class="text-left">TP0000135</td>
                    <td class="text-left">选号码</td>
                    <td class="text-left">60.00</td>
                    <td class="text-left">
                    <input onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onchange="ajaxUpdateField(this);" name="store_count" size="4" data-table="goods" data-id="135" value="1000" type="text">   
                    </td>
                    <td class="text-center">                        
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','135','is_on_sale',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','135','is_recommend',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/cancel.png" onclick="changeTableVal('goods','goods_id','135','is_new',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','135','is_hot',this)" width="20" height="20">
                    </td>                                        
                    <td class="text-center">                         
                        <input onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="this.value=this.value.replace(/[^\d]/g,'')" onchange="updateSort('goods','goods_id','135','sort',this)" size="4" value="50" type="text">
                    </td>                    
                    <td class="text-center">
                        <a target="_blank" href="/index/Home/Goods/goodsInfo/id/135" class="btn btn-info" title="查看详情"><i class="fa fa-eye"></i></a>
                        <a href="product-add.jsp" class="btn btn-primary" title="编辑"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:void(0);" onclick="del('135')" class="btn btn-danger" title="删除"><i class="fa fa-trash-o"></i></a>
                    </td>                        
                </tr><tr>
                    <td class="text-center">
                       <!-- <input type="checkbox" name="selected[]" value="6">-->
                        <input name="shipping_code[]" value="flat.flat" type="hidden">
                    </td>
                    <td class="text-right">134</td>
                    <td class="text-left">中国电信4G号卡手机卡电话卡上网卡 177号段套餐可选 预存120...</td>
                    <td class="text-left">TP0000134</td>
                    <td class="text-left">选号码</td>
                    <td class="text-left">120.00</td>
                    <td class="text-left">
                    <input onkeyup="this.value=this.value.replace(/[^\d.]/g,'')" onpaste="this.value=this.value.replace(/[^\d.]/g,'')" onchange="ajaxUpdateField(this);" name="store_count" size="4" data-table="goods" data-id="134" value="1000" type="text">   
                    </td>
                    <td class="text-center">                        
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','134','is_on_sale',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','134','is_recommend',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/cancel.png" onclick="changeTableVal('goods','goods_id','134','is_new',this)" width="20" height="20">
                    </td>
                    <td class="text-center">
                        <img src="../Public/images/yes.png" onclick="changeTableVal('goods','goods_id','134','is_hot',this)" width="20" height="20">
                    </td>                                        
                    <td class="text-center">                         
                        <input onkeyup="this.value=this.value.replace(/[^\d]/g,'')" onpaste="this.value=this.value.replace(/[^\d]/g,'')" onchange="updateSort('goods','goods_id','134','sort',this)" size="4" value="50" type="text">
                    </td>                    
                    <td class="text-center">
                        <a target="_blank" href="/index/Home/Goods/goodsInfo/id/134" class="btn btn-info" title="查看详情"><i class="fa fa-eye"></i></a>
                        <a href="product-add.jsp" class="btn btn-primary" title="编辑"><i class="fa fa-pencil"></i></a>
                        <a href="javascript:void(0);" onclick="del('134')" class="btn btn-danger" title="删除"><i class="fa fa-trash-o"></i></a>
                    </td>                        
                </tr>            
                </tbody>
        </table>
    </div>
<input name="__hash__" value="00ea0d70ce1e0760a8bf5d90b5e30971_699560bd02bf6cad1be4e51b170eb190" type="hidden"></form>
<div class="row">
    <div class="col-sm-3 text-left"></div>
    <div class="col-sm-9 text-right"><div class="dataTables_paginate paging_simple_numbers"><ul class="pagination">  <li class="paginate_button active"><a tabindex="0" data-dt-idx="1" aria-controls="example1" data-p="1" href="javascript:void(0)">1</a></li><li class="paginate_button"><a class="num" data-p="2" href="javascript:void(0)">2</a></li><li class="paginate_button"><a class="num" data-p="3" href="javascript:void(0)">3</a></li><li class="paginate_button"><a class="num" data-p="4" href="javascript:void(0)">4</a></li><li class="paginate_button"><a class="num" data-p="5" href="javascript:void(0)">5</a></li><li class="paginate_button"><a class="num" data-p="6" href="javascript:void(0)">6</a></li><li class="paginate_button"><a class="num" data-p="7" href="javascript:void(0)">7</a></li><li class="paginate_button"><a class="num" data-p="8" href="javascript:void(0)">8</a></li><li class="paginate_button"><a class="num" data-p="9" href="javascript:void(0)">9</a></li><li class="paginate_button"><a class="num" data-p="10" href="javascript:void(0)">10</a></li><li class="paginate_button"><a class="num" data-p="11" href="javascript:void(0)">11</a></li> <li id="example1_next" class="paginate_button next"><a class="next" data-p="2" href="javascript:void(0)">下一页</a></li> </ul></div></div>
</div>
<script>
    // 点击分页触发的事件
    $(".pagination  a").click(function(){
        cur_page = $(this).data('p');
        ajax_get_table('search-form2',cur_page);
    });
	
    /*
     * 清除静态页面缓存
     */
    function ClearGoodsHtml(goods_id)
    {
    	$.ajax({
				type:'GET',
				url:"/index/Admin/System/ClearGoodsHtml",
				data:{goods_id:goods_id},
				dataType:'json',
				success:function(data){
					layer.alert(data.msg, {icon: 2});								 
				}
		});
    }
    /*
     * 清除商品缩列图缓存
     */
    function ClearGoodsThumb(goods_id)
    {
    	$.ajax({
				type:'GET',
				url:"/index/Admin/System/ClearGoodsThumb",
				data:{goods_id:goods_id},
				dataType:'json',
				success:function(data){
					layer.alert(data.msg, {icon: 2});								 
				}
		});
    }		
</script></div>
        </div>
      </div>
    </div>
    <!-- /.row --> 
  </section>
  <!-- /.content --> 
</div>
<!-- /.content-wrapper --> 
<script>
    $(document).ready(function(){
		// ajax 加载商品列表
        ajax_get_table('search-form2',1);

    });


    // ajax 抓取页面 form 为表单id  page 为当前第几页
    function ajax_get_table(form,page){
		cur_page = page; //当前页面 保存为全局变量
            $.ajax({
                type : "POST",
                url:"/index?m=Admin&c=goods&a=ajaxGoodsList&p="+page,//+tab,
                data : $('#'+form).serialize(),// 你的formid
                success: function(data){
                    $("#ajax_return").html('');
                    $("#ajax_return").append(data);
                }
            });
        }
      
        // 点击排序
        function sort(field)
        {
           $("input[name='orderby1']").val(field);
           var v = $("input[name='orderby2']").val() == 'desc' ? 'asc' : 'desc';             
           $("input[name='orderby2']").val(v);
           ajax_get_table('search-form2',cur_page);
        }
        
        // 删除操作
        function del(id)
        {
            if(!confirm('确定要删除吗?'))
                return false;
		$.ajax({
			url:"/index?m=Admin&c=goods&a=delGoods&id="+id,
			success: function(v){	
                                var v =  eval('('+v+')');                                 
                                if(v.hasOwnProperty('status') && (v.status == 1))
                                        ajax_get_table('search-form2',cur_page);                                                      
                                else
                                        layer.msg(v.msg, {icon: 2,time: 1000}); //alert(v.msg);
			}
		}); 
               return false;
          }
</script> 

</body></html>