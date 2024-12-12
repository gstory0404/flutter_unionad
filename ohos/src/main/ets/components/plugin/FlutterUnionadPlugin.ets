import {
  AbilityAware,
  AbilityPluginBinding,
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import {
  AdLoadType,
  AdSlotBuilder,
  CSJAdSdk,
  CSJRewardAd,
  RewardAdInteractionListener,
  RewardAdLoadListener,
  SDKConfig,
  SDKConfigBuilder
} from '@csj/openadsdk';
import { UIAbility } from '@kit.AbilityKit';

/** FlutterUnionadPlugin **/
export default class FlutterUnionadPlugin implements FlutterPlugin, MethodCallHandler, AbilityAware {
  private channel: MethodChannel | null = null;
  private applicationContext: Context | null = null;
  private uiAbility: UIAbility | null = null;
  private adCreator = CSJAdSdk.getAdCreator();

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

  onAttachedToAbility(binding: AbilityPluginBinding): void {
    this.uiAbility = binding.getAbility()
  }

  onDetachedFromAbility(): void {
    this.uiAbility = null
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method == "register") {
      let ohosAppId: string = call.args.get("ohosAppId");
      let appName: string = call.args.get("appName");
      let debug: boolean = call.args.get("debug");
      // 创建SDKConfig对象
      let adConfigBuilder = new SDKConfigBuilder()
      let config: SDKConfig = adConfigBuilder
        .appId(ohosAppId)
        .appName(appName)
        .allowShowNotify(true)
        .debug(debug)
        .build()

      // 初始化SDK
      CSJAdSdk.init(this.applicationContext, config) //context类型必须为UIAbility，否则可能存在展示异常场景

      // 启动SDK
      CSJAdSdk.start();
      result.success(true)
    } else if (call.method == "getSDKVersion") {
      result.success(CSJAdSdk.getSDKVersion())
    } else if (call.method == "getThemeStatus") {
      //todo 没做
      result.success(0)
    } else if (call.method == "loadRewardVideoAd") {
      let ohosCodeId: string = call.args.get("ohosCodeId");
      let adSlot = new AdSlotBuilder()
        .setCodeId(ohosCodeId)
        .setAdLoadType(AdLoadType.LOAD)// .setMediaExtra(mediaExtra)
        .build()
      let adInteractionListener: RewardAdInteractionListener = {
        onShow: () => {
        },
        onSkip: () => {
        },
        onClick: () => {
        },
        onComplete: () => {
        },
        onClose: () => {
        },
        onRewardArrived: (isVerify, rewardType, extraInfo) => {
        }
      }
      let mLoadListener: RewardAdLoadListener = {
        onAdLoaded: (rewardAd: CSJRewardAd) => {
          // 广告基础信息加载完成
          if (this.uiAbility != null) {
            rewardAd.setInteractionListener(adInteractionListener)
            rewardAd.showRewardAd(this.uiAbility.context.windowStage)
          }
        },
        onAdCached: (rewardAd: CSJRewardAd) => {
          // 广告基础信息与素材缓存完成
        },
        onError: (code: number, message: string) => {
          console.log("onError,code:"+code+",message:"+message)
        }
      }
      this.adCreator.loadRewardAd(adSlot, mLoadListener)
      result.success(true)
    } else {
      result.notImplemented()
    }
  }
}