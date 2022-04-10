class ApiConstants {
  // ignore: non_constant_identifier_names
  // static final String BASE_URL = 'http://192.168.1.199:8000';
  // static final String BASE_URL = 'https://api.jidaoapp.com';//正式
  static final String BASE_URL = 'https://test.jidaoapp.com';//测试
  // static final String BASE_URL = 'https://alpha.jidaoapp.com';//开发

  /// 测试接口
  static final String test = "/app/user/test";

  /// 文件上传
  static final String upload = "/app/common/upload";

  static final String common = "/app/common/";
  static final String config = "/app/common/config";

  //region 登录注册相关
  /// 用户登录注册
  static final String registerAndLogin = "/app/regAndLogin/phone";

  /// 三方登录
  static final String thirdPartyLogin = "/app/regAndLogin/thirdParty";

  /// 手机号是否存在
  static final String phoneIsExist = "/app/regAndLogin/phoneIsExist";

  /// 发送验证码
  static final String smsCode = "/app/regAndLogin/smsCode";

  /// 人机验证
  static final String verifyCaptcha = "/app/regAndLogin/verifyCaptcha";

  //endregion

  //region 用户相关
  /// 获取用户信息
  static final String userInfo = "/app/user/";

  /// 修改用户信息
  static final String userInfoUpdate = "/app/user/update";

  /// 绑定三方账号
  static final String bindThirdAccount = "/app/user/bindThirdAccount";

  /// 用户地址-增删改查
  static final String userAddress = "/app/user/address";

  //endregion

  //region 钱包
  /// 获取钱包充值项目
  static final String rechargeItem = "/app/recharge/item";

  /// 获取充值详情
  static final String rechargeDetail = "/app/recharge/detail";

  /// 提交充值订单
  static final String rechargeOrder = "/app/recharge/order";

  /// 获取微信支付报文
  static final String wechatRechargePay = "/wxPay/app/recharge/pay";

  /// 获取微信支付报文
  static final String aliPayRechargePay = "/aliPay/app/recharge/pay";

  //endregion

  //region 技师
  /// 获取附近的技师列表
  static final String technician = "/app/technician/";
  ///
  static final String technicianScreen = "/app/technician/screen";

  /// 收藏技师
  static final String favorite = "/app/user/favorite/";

  /// 技师可约时间 [technician]$id$[readyTimeE]
  static final String readyTimeE = "/readyTime";

  /// 技师评价列表 [technician]$id$[evaluationListE]
  static final String evaluationListE = "/evaluate";

  /// 商家信息[common]$id[shopInfo]
  static final String shopInfo = "/shopInfo";

  /// 用户投诉
  static final String userComplaint = "/app/userComplaint";

  /// 服务过我的技师
  static final String servedTechnicians = "/app/userComplaint/technicians";

  /// 用户投诉原因
  static final String userComplaintReasons = "$userComplaint/reasons";



  //endregion

  //region 客服
  static final String noticeList = '/app/user/notice';
  static final String message = '/app/message/';
  static final String messageRead = '/app/message/read';
  static final String userSig = '/app/tim/userSig';
  static final String unReadNum = '/app/message/unReadNum';

  //endregion

  //region 订单

  /// 用户订单列表
  static final String order = "/app/serviceOrder/";

  static final String refundDetail = "/app/serviceOrder/refund/";

  /// 用户下单
  static final String commitOrder = "/app/serviceOrder/order";

  /// 余额支付
  static final String orderPay = "/app/serviceOrder/pay";

  /// 支付结果查询
  static final String payResultE = "/payStatus";

  /// 获取微信支付报文
  static final String wechatServicePay = "/wxPay/app/service/pay";

  /// 获取微信支付报文
  static final String aliPayServicePay = "/aliPay/app/service/pay";

  /// 订单取消并退款
  static final String orderCancelAndRefund =
      "/app/serviceOrder/cancelAndRefund";

  /// 订单取消
  static final String orderCancel = "/app/serviceOrder/cancel";

  /// 订单删除
  static final String orderDelete = "/app/serviceOrder/delete";

  /// 订单取消原因
  static final String refundReason = "/app/refundReason/";

  /// 订单评价标签
  static final String evaluateTags = "/app/evaluate/tags";

  /// 评价新增
  static final String evaluateAdd = "/app/evaluate/add";

  /// 订单投诉标签
  static final String complaintTags = "/app/complaint/reasons";

  /// 投诉新增
  static final String complaintAdd = "/app/complaint/add";

  /// 投诉详情
  static final String complaint = "/app/complaint/";

  /// 聊天群组ID
  static final String imGroup = "/app/tim/imGroup";

  /// 申请平台介入
  static final String complaintAppeal = "/app/complaint/appeal";

  /// 优惠券
  static final String couponsCount = "/app/serviceOrder/coupons/count";
  static final String couponList = "/app/serviceOrder/coupons";

  /// 计算订单价格
  static final String fee = "/app/serviceOrder/fee";

  /// 投诉取消
  static final String complaintCancel = "/app/complaint/cancel";

  //endregion

  //region 第三方接口
  /// 微信获取
  static final String wechatAccessToken =
      'https://api.weixin.qq.com/sns/oauth2/access_token';
  static final String wechatUserInfo = 'https://api.weixin.qq.com/sns/userinfo';
//endregion

  /// 意见反馈
  static final String feedback = "/app/common/feedback";

}
