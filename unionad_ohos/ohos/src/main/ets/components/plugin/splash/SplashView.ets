import { Any, BinaryMessenger, MethodChannel, PlatformView } from "@ohos/flutter_ohos";
import { common, UIAbility } from "@kit.AbilityKit";
import { ArrayList, HashMap } from "@kit.ArkTS";
import FlutterunionadViewConfig from "../FlutterunionadViewConfig";
import { SplashBuilder } from "./SplashNativeView";
import { Params } from '@ohos/flutter_ohos/src/main/ets/plugin/platform/PlatformView';
import { window } from "@kit.ArkUI";

export default class SplashView extends PlatformView {
  private mCodeId = "";
  private viewWidth = 0.0
  private viewHeight = 0.0
  private timeout = 3000
  private channel: MethodChannel
  private windowStage?: window.WindowStage

  constructor(context: common.Context, viewId: number, params: HashMap<string, Any>, messenger: BinaryMessenger, uIAbility: UIAbility) {
    super();

    this.mCodeId = params.get("ohosId") as string
    this.viewWidth = params.get("width") as number
    this.viewHeight = params.get("height") as number
    this.timeout = params.get("timeout") as number
    this.channel = new MethodChannel(messenger, FlutterunionadViewConfig.view.splashAdView + "_" + viewId)
    this.windowStage = uIAbility.context.windowStage
  }

  getView(): WrappedBuilder<[Params]> {
    return new WrappedBuilder(SplashBuilder)
  }

  getMCodeId() : string {
    return this.mCodeId
  }

  getViewWidth() : number {
    return this.viewWidth
  }

  getViewHeight() : number {
    return this.viewHeight
  }

  getTimeout() : number {
    return this.timeout
  }

  getChannel() : MethodChannel {
    return this.channel
  }

  getWindowStage() : window.WindowStage {
    return this.windowStage!
  }

  sendMsg(key: string, msg: Any) {
    //console.log("SplashNativeView=>sendMsg: " + key + ", msg: " +  JSON.stringify(msg))
    this.channel.invokeMethod(key, msg)
  }

  dispose(): void {
  }
}