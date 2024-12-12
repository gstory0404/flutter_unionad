import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import {
  CSJAdSdk,
  SDKConfig,
  SDKConfigBuilder
} from '@csj/openadsdk';

/** FlutterUnionadPlugin **/
export default class FlutterUnionadPlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;
  private applicationContext: Context | null = null;

  constructor() {
  }

  getUniqueClassName(): string {
    return "FlutterUnionadPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), "flutter_unionad");
    this.channel.setMethodCallHandler(this)
    this.applicationContext = binding.getApplicationContext();
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null)
    }
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method == "register") {

      // 创建SDKConfig对象
      let adConfigBuilder = new SDKConfigBuilder()
      let config: SDKConfig = adConfigBuilder
        .appId("5638354")
        .appName("穿山甲Demo")
        .allowShowNotify(true)
        .debug(true)
        .build()

      // 初始化SDK
      CSJAdSdk.init(this.applicationContext, config)  //context类型必须为UIAbility，否则可能存在展示异常场景

      // 启动SDK
      CSJAdSdk.start();
      result.success(true)
    }else if (call.method == "getSDKVersion") {
      // 创建SDKConfig对象
      let adConfigBuilder = new SDKConfigBuilder()
      let config: SDKConfig = adConfigBuilder
        .appId("5638354")
        .appName("穿山甲Demo")
        .allowShowNotify(true)
        .debug(true)
        .build()

      // 初始化SDK
      CSJAdSdk.init(this.applicationContext, config)  //context类型必须为UIAbility，否则可能存在展示异常场景

      // 启动SDK
      CSJAdSdk.start();
      result.success(true)
    } else {
      result.notImplemented()
    }
  }
}