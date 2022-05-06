part of '../keystore_manager.dart';

abstract class Web3KeychainManagerInterface {
  /// 当前设备下对所有地址
  List<EthereumAddress> addresses();

  /// 重新扫描目录刷新地址存储情况
  void rescanStorage();

  /// 倒入keystore
  Future<EthereumAddress> importKeystore(String json, String pwd);

  /// 倒入私钥
  Future<EthereumAddress> importPrivateKey(String pkHex, String encryptoPwd);

  /// 倒入助记词
  Future<EthereumAddress> importMemories(String memo, String encryptoPwd);

  /// 指定地址导出Keystore文件
  Future<String> exportKeystore(EthereumAddress address, String pwd);

  /// 指定地址导出明文私钥
  Future<String> exportPrivateKey(EthereumAddress address, String pwd);

  /// 导出地址的助记词（如果有）
  Future<String> exportMemories(EthereumAddress address, String pwd);

  /// 检测对应的地址是否有存储助记词（是否是BIP32创建，或者从助记词倒入）
  Future<bool> existMemories(EthereumAddress address);
  bool existMemoriesSync(EthereumAddress address);

  /// 验证地址的密码
  Future<bool> verifyPassword(EthereumAddress address, String pwd);

  /// 使用对应地址对消息签名
  Future<Uint8List> signMessage(
      EthereumAddress address, String content, String pwd,
      {int chainID});


  /// 新建keychain
  Future<EthereumAddress> generate(String pwd);

  /// 新建keychain
  Future<bool> regenerate(
      EthereumAddress address, String oldPwd, String newPwd);

  /// 创建助记词私钥
  Future<EthereumAddress> generateBIP32(String pwd);

  /// 获取签名凭证对象
  Future<Credentials> getCredentials(EthereumAddress address, String pwd);

  /// 验证后删除
  Future<bool> remove(EthereumAddress address, String pwd,
      {bool removeStorage = false});


  String uint8ToHex(Uint8List byteArr);
}


class Web3KeychainManager implements Web3KeychainManagerInterface {
  /// 存储的目录
  static late Directory _keystoreStorageRootDirectory;

  /// 全局单例，只需要调用一次，重复调用没有效果
  static Future<void> init({String? rootPath}) async {
    if (_instance == null) {
      if (rootPath == null) {
        if (Platform.isIOS || Platform.isAndroid) {
          rootPath = (await getApplicationDocumentsDirectory()).path;
        }
      }

      _keystoreStorageRootDirectory =
          Directory(path.join(rootPath!, "keychain"));

      if (!_keystoreStorageRootDirectory.existsSync()) {
        _keystoreStorageRootDirectory.createSync();
      }

      _instance = Web3KeychainManager();
    }
  }

  static Web3KeychainManager getInstance() {
    assert(_instance != null,
        "call Web3KeychainManager.Init() befor getInstance()");

    return _instance!;
  }

  /// 当前设备下对所有地址
  List<EthereumAddress> addresses() => _addresses;

  /// wallet缓存
  Cacher<EthereumAddress, WalletCache> _walletCacher =
      Cacher<EthereumAddress, WalletCache>();

  void rescanStorage() {
    List<FileSystemEntity> entityList =
        _keystoreStorageRootDirectory.listSync();
    _addresses.clear();
    for (var entity in entityList) {
      /// 对应的路径不是一个json文件直接跳过
      if (path.extension(entity.path) != ".json") {
        continue;
      }

      /// 对应的路径不是一个文件，直接跳过
      if (!(FileSystemEntity.typeSync(entity.path) ==
          FileSystemEntityType.file)) {
        continue;
      }

      /// 获取文件名，因为文件名就是钱包地址
      _addresses.add(
          EthereumAddress.fromHex(path.basenameWithoutExtension(entity.path)));
    }
  }

  /// 倒入keystore
  Future<EthereumAddress> importKeystore(String json, String pwd) async {
    /// 不允许空密码的keystore倒入
    if (pwd.length <= 0) {
      throw Web3KeychainManagerError.errorMissPassword;
    }

    final wallet = Wallet.fromJson(json, pwd);

    final address = await wallet.privateKey.extractAddress();
    if (this.addresses().contains(address)) {
      throw Web3KeychainManagerError.duplicateAccount;
    }
    if (!await this._storageWallet(wallet)) {
      throw Web3KeychainManagerError.isolateStorageError;
    }

    this._addresses.add(address);

    /// 返回地址
    return address;
  }

  /// 倒入私钥
  Future<EthereumAddress> importPrivateKey(
      String pkHex, String encryptoPwd) async {
    if (encryptoPwd.length <= 0) {
      throw Web3KeychainManagerError.errorMissPassword;
    }

    final ks = EthPrivateKey.fromHex(pkHex);

    final wallet = Wallet.createNew(ks, encryptoPwd, new Random.secure());

    final address = await wallet.privateKey.extractAddress();
    if (this.addresses().contains(address)) {
      throw Web3KeychainManagerError.duplicateAccount;
    }
    if (!await this._storageWallet(wallet)) {
      throw Web3KeychainManagerError.isolateStorageError;
    }

    /// 返回地址
    return address;
  }

  /// 倒入助记词
  Future<EthereumAddress> importMemories(
      String mnemonic, String encryptoPwd) async {
    if (encryptoPwd.length <= 0) {
      throw Web3KeychainManagerError.errorMissPassword;
    }

    final bip39Seed = BIP39.mnemonicToSeed(mnemonic);

    final bip32 = BIP32.fromSeed(bip39Seed);

    final account = bip32.derivePath(defaultDerivePath);

    if(account.isNeutered()){
      throw Web3KeychainManagerError.duplicateAccount;
    }
    final ks = EthPrivateKey(account.privateKey!);

    /// 创建keystore文件
    final wallet = Wallet.createNew(ks, encryptoPwd, Random.secure());

    final address = await ks.extractAddress();
    if (this.addresses().contains(address)) {
      // throw Web3KeychainManagerError.duplicateAccount;
      return address;
    }

    if (!await this._storageWallet(wallet, memories: mnemonic)) {
      throw Web3KeychainManagerError.isolateStorageError;
    }

    /// 返回地址
    return address;
  }

  ///生成新钱包
  Future<String> newWallet(String pwd,
      {String? pk, String? mns, String? ks}) async {
    String address = '';
    if (null != pk) {
      address = (await importPrivateKey(pk.trim(), pwd)).hex;
    } else if (null != mns) {
      address = (await importMemories(mns.trim(), pwd)).hex;
    } else if (null != ks) {
      address = (await importKeystore(ks.trim(), pwd)).hex;
    } else {
      address = (await generateBIP32(pwd)).hex;
    }
    return address;
  }

  /// 指定地址导出Keystore文件
  Future<String> exportKeystore(EthereumAddress address, String pwd) async {
    if (pwd.length <= 0) {
      throw Web3KeychainManagerError.errorMissPassword;
    }

    /// 读取文件内容
    final ksFile = File(this._joinKeychainPath(address));

    final ksFileContent = ksFile.readAsStringSync();

    /// 若密码错误，回抛出异常
    final wallet = await this._walletOfAddress(address, pwd);

    if ((await wallet.privateKey.extractAddress()) != address) {
      throw "keystore 对应的地址与选所地址不一致";
    }

    return Future.value(ksFileContent);
  }

  /// 指定地址导出明文私钥
  Future<String> exportPrivateKey(EthereumAddress address, String pwd) async {
    if (pwd == null || pwd.length <= 0) {
      throw Web3KeychainManagerError.errorMissPassword;
    }

    /// 弱密码错误，回抛出异常
    final wallet = await this._walletOfAddress(address, pwd);

    return Future.value(bytesToHex(wallet.privateKey.privateKey));
  }

  Future<String> exportMemories(EthereumAddress address, String pwd) async {
    if (pwd == null || pwd.length <= 0) {
      throw Web3KeychainManagerError.errorMissPassword;
    }

    /// 对应的地址不是通过BIP32创建，或者不是通过助记词倒入的，无法导出
    if (!this.existMemoriesSync(address)) {
      throw Web3KeychainManagerError.errorNotFoundMemories;
    }

    /// 1.通过密码获取私钥，因为私钥是AES的PrivateKey
    final aesKey =
        (await this._walletOfAddress(address, pwd)).privateKey.privateKey;

    /// 2.获取加密的文件内容
    final memoFile = File(this._joinMemorisePath(address));

    /// 3.解密熵
    Uint8List entropy = aesCbcDecrypt(aesKey, memoFile.readAsBytesSync());

    /// 4.熵转化为助记词
    return BIP39.entropyToMnemonic(utf8.decode(entropy));
  }

  Future<bool> existMemories(EthereumAddress address) {
    final memoPath = this._joinMemorisePath(address);

    return File(memoPath).exists();
  }

  bool existMemoriesSync(EthereumAddress address) {
    final memoPath = this._joinMemorisePath(address);

    return File(memoPath).existsSync();
  }

  /// 验证地址的密码
  Future<bool> verifyPassword(EthereumAddress address, String pwd) async {
    /// 若密码错误，会抛出异常
    try {
      await this._walletOfAddress(address, pwd);

      return Future.value(true);
    } catch (e) {
      /// 如果密码不正确会抛出一个 invaildPassword 的异常，但是verifyPassowrd不能够已异常的形式终止，所以函数内部处理异常
      print(e.toString());
      return Future.value(false);
    }
  }

  Future<Uint8List> signMessage(
      EthereumAddress address, String content, String pwd,
      {int? chainID}) async {
    final wallet = await this._walletOfAddress(address, pwd);

    final contentBytes = Uint8List.fromList(utf8.encode(content));

    return wallet.privateKey
        .signPersonalMessage(contentBytes, chainId: chainID);
  }

  Future<EthereumAddress> generate(String pwd) async {
    var rng = new Random.secure();

    final ks = EthPrivateKey.createRandom(rng);

    final wallet = Wallet.createNew(ks, pwd, rng);

    final address = await wallet.privateKey.extractAddress();

    if (!await this._storageWallet(wallet)) {
      throw Web3KeychainManagerError.isolateStorageError;
    }

    /// 返回地址
    return address;
  }

  static const String defaultDerivePath = "m/44'/60'/0'/0/0";
  Future<EthereumAddress> generateBIP32(String pwd) async {
    final mnemonic = BIP39.generateMnemonic();

    final bip39Seed = BIP39.mnemonicToSeed(mnemonic);

    final bip32 = BIP32.fromSeed(bip39Seed);

    final account = bip32.derivePath(defaultDerivePath);
    if(account.isNeutered()){
      throw Web3KeychainManagerError.duplicateAccount;
    }
    final ks = EthPrivateKey(account.privateKey!);

    /// 创建keystore文件
    final wallet = Wallet.createNew(ks, pwd, Random.secure());

    final address = await wallet.privateKey.extractAddress();

    if (!await this._storageWallet(wallet, memories: mnemonic)) {
      throw Web3KeychainManagerError.isolateStorageError;
    }

    /// 返回地址
    return address;
  }

  ///修改密码
  Future<bool> regenerate(
      EthereumAddress address, String oldPwd, String newPwd) async {
    final rng = new Random.secure();
    final oldWallet = await this._walletOfAddress(address, oldPwd);
    final newWallet = Wallet.createNew(oldWallet.privateKey, newPwd, rng);

    if (await this.remove(address, oldPwd)) {
      // 更新缓存
      _walletCacher.setCache(
          address, WalletCache(newWallet, bytesToHex(keccakUtf8(newPwd))));

      return await this._storageWallet(newWallet);
    }

    return Future.value(false);
  }

  /// 验证后删除，不能删除HDKeystore
  Future<bool> remove(EthereumAddress address, String pwd,
      {bool removeStorage = false}) async {
    if (await this.verifyPassword(address, pwd)) {
      /// 密码验证成功
      final ksPath = this._joinKeychainPath(address);

      final ksFile = File(ksPath);

      // String removeDt = DateTime.now().millisecondsSinceEpoch.toString();

      // if (!removeStorage) {
      //   /// 不做真实删除，而是把文件移动到备份文件夹
      //   ksFile.renameSync(ksPath + "_removed_" + removeDt);
      // } else {
      /// 删除文件
      ksFile.deleteSync();
      // }

      /// 删除地址列表
      this._addresses.remove(address);

      /// 删除缓存
      _walletCacher.expire(address);

      return true;
    }

    return false;
  }

  /// 获取签名凭证对象
  Future<Credentials> getCredentials(
      EthereumAddress address, String pwd) async {
    final wallet = await this._walletOfAddress(address, pwd);

    return Future.value(wallet.privateKey);
  }

  Web3KeychainManager() {
    this.rescanStorage();
  }

  Future<bool> _storageWallet(Wallet wallet, {String? memories}) async {
    if (memories == null) {
      return compute(_isolateStorageWallet, [
        wallet,
        this._joinKeychainPath(await wallet.privateKey.extractAddress())
      ]);
    } else {
      return compute(_isolateStorageWallet, [
        wallet,
        this._joinKeychainPath(await wallet.privateKey.extractAddress()),
        memories,
        this._joinMemorisePath(await wallet.privateKey.extractAddress())
      ]);
    }
  }

  static Future<bool> _isolateStorageWallet(List<dynamic> parmas) {
    final Wallet wallet = parmas[0] as Wallet;
    final File ksFile = File(parmas[1] as String);
    String? memories;
    String? memoriesPath;
    if (parmas.length == 4) {
      memories = parmas[2] as String;
      memoriesPath = parmas[3] as String;
    }

    /// 判断文件, 一般不可能存在，因为这个断言如果成立，说明不同的私钥对应了一个相同的地址，几率微乎其微
    assert(!ksFile.existsSync());

    /// 创建文件
    ksFile.createSync();

    /// 写入内容
    ksFile.writeAsStringSync(wallet.toJson());

    /// 写入加密的助记词
    if (memories != null && memoriesPath!=null) {
      /// 使用AES加密存储
      final entropy = BIP39.mnemonicToEntropy(memories);
      final encryptoMemorise =
          aesCbcEncrypt(wallet.privateKey.privateKey, Uint8List.fromList(utf8.encode(entropy)));
      final memoFile = File(memoriesPath);

      memoFile.createSync();
      memoFile.writeAsBytesSync(encryptoMemorise);
    }

    return Future.value(true);
  }

  static Future<Wallet> _isolateWalletOfAddress(List<dynamic> params) async {
    final EthereumAddress address = params[0] as EthereumAddress;
    final String pwd = params[1] as String;
    final String ksFilePath = params[2] as String;

    final ksFile = File(ksFilePath);

    final ksFileContent = ksFile.readAsStringSync();

    final wallet = Wallet.fromJson(ksFileContent, pwd);

    /// 使用任何密码都可以计算出一个地址，但是密码如果不匹配计算出来的地址不会相同，所以如果计算的结果地址不一致，说明密码错误
    if ((await wallet.privateKey.extractAddress()) != address) {
      throw Web3KeychainManagerError.errorInvaildPassword;
    }

    return wallet;
  }

  Future<Wallet> _walletOfAddress(EthereumAddress address, String pwd) {
    // 处理缓存
    final cache = _walletCacher[address];
    if(cache != null){
      if (cache.pwdHash == bytesToHex(keccakUtf8(pwd))) {
        return Future.value(cache.wallet);
      } else {
        throw Web3KeychainManagerError.errorInvaildPassword;
      }
    }

    return compute(_isolateWalletOfAddress,
        [address, pwd, this._joinKeychainPath(address)]).then((wallet) {
      _walletCacher.setCache(
          address, WalletCache(wallet, bytesToHex(keccakUtf8(pwd))));
      return wallet;
    });
  }

  String _joinKeychainPath(EthereumAddress address) {
    return path.join(_keystoreStorageRootDirectory.path,
        address.toString().toLowerCase() + ".json");
  }

  String _joinMemorisePath(EthereumAddress address) {
    return path.join(_keystoreStorageRootDirectory.path,
        address.toString().toLowerCase() + ".memo");
  }

  List<EthereumAddress> _addresses = [];

  static Web3KeychainManager? _instance;

  /// Private method

  static Uint8List iv = Uint8List.fromList(utf8.encode('limowallet.token')) ;
  static Uint8List aesCbcEncrypt(Uint8List key, Uint8List paddedPlaintext) {
    // Create a CBC block cipher with AES, and initialize with key and IV
    final cbc = CBCBlockCipher(AESEngine())
      ..init(true, ParametersWithIV(KeyParameter(key), iv)); // true=encrypt

    // Encrypt the plaintext block-by-block
    final cipherText = Uint8List(paddedPlaintext.length); // allocate space

    var offset = 0;
    while (offset < paddedPlaintext.length) {
      offset += cbc.processBlock(paddedPlaintext, offset, cipherText, offset);
    }
    assert(offset == paddedPlaintext.length);

    return cipherText;
  }

  static Uint8List aesCbcDecrypt(Uint8List key, Uint8List cipherText) {
    // Create a CBC block cipher with AES, and initialize with key and IV
    final cbc = CBCBlockCipher(AESEngine())
      ..init(false, ParametersWithIV(KeyParameter(key), iv)); // false=decrypt

    // Decrypt the cipherText block-by-block
    final paddedPlainText = Uint8List(cipherText.length); // allocate space

    var offset = 0;
    while (offset < cipherText.length) {
      offset += cbc.processBlock(cipherText, offset, paddedPlainText, offset);
    }
    assert(offset == cipherText.length);

    return paddedPlainText;
  }

  String uint8ToHex(Uint8List byteArr) {
    if (byteArr.length == 0) {
      return "";
    }
    Uint8List result = Uint8List(byteArr.length << 1);//创建一个byteArr.length两倍大的数组以存储16进制字符
    var hexTable = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F']; //16进制字符表
    //下面的for循环是通过codeUnitAt()方法取byteArr每一位对应的字符串的“UTF-16代码单元”，如果去掉.codeUnitAt()其实也就直接是16进制字符串
    for (var i = 0; i < byteArr.length; i++) {
      var bit = byteArr[i]; //取传入的byteArr的每一位
      var index = bit >> 4 & 15; //右移4位,取剩下四位,&15相当于&F,也就是&1111
      var i2 = i << 1; //byteArr的每一位对应结果的两位,所以对于结果的操作位数要乘2
      result[i2] = hexTable[index].codeUnitAt(0); //左边的值取字符表,转为Unicode放进resut数组
      index = bit & 15; //取右边四位,相当于01011010&00001111=1010
      result[i2 + 1] = hexTable[index].codeUnitAt(0); //右边的值取字符表,转为Unicode放进resut数组
    }
    //这里为了优化转换成一整个String的效率，所以就在上面的循环中先转成codeUnit再通过String的实例方法来生成字符串，否则需要用result.join("")，这个join()方法的效率低于String.fromCharCodes()方法
    return String.fromCharCodes(result); //Unicode转回为对应字符,生成字符串返回
  }
}
