import { Any, BinaryMessenger, MethodChannel, PlatformView } from "@ohos/flutter_ohos";
import { common, UIAbility } from "@kit.AbilityKit";
import { ArrayList, HashMap } from "@kit.ArkTS";
import FlutterunionadViewConfig from "../FlutterunionadViewConfig";
import { BannerBuilder } from "./BannerNativeView";
import { Params } from '@ohos/flutter_ohos/src/main/ets/plugin/platform/PlatformView';

export default class BannerView extends PlatformView {
  private mCodeId = "";
  private acceptWidth = 0.0
  private acceptHeight = 0.0
  private channel: MethodChannel

  constructor(context: common.Context, viewId: number, params: HashMap<string, Any>, messenger: BinaryMessenger, uIAbility: UIAbility) {
    super();

    this.mCodeId = params.get("ohosId") as string
    this.acceptWidth = params.get("width") as number
    this.acceptHeight = params.get("height") as number
    this.channel = new MethodChannel(messenger, FlutterunionadViewConfig.view.bannerAdView + "_" + viewId)
  }

  getView(): WrappedBuilder<[Params]> {
    return new WrappedBuilder(BannerBuilder)
  }

  dispose(): void {
  }

  sendMsg(key: string, msg: Any) {
    this.channel.invokeMethod(key, msg)
  }

  getMCodeId() : string{
    return this.mCodeId
  }

  getAcceptWidth() : number{
    return this.acceptWidth
  }

  getAcceptHeight() : number{
    return this.acceptHeight
  }
}
