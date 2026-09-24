import { Any, FlutterPluginBinding, MessageCodec, PlatformView, PlatformViewFactory, StandardMessageCodec } from '@ohos/flutter_ohos';
import { common, UIAbility } from '@kit.AbilityKit';
import { HashMap } from '@kit.ArkTS';
import BannerView from './BannerView';

export default class BannerAdViewFactory extends PlatformViewFactory {
  binding?: FlutterPluginBinding;
  uIAbility?: UIAbility;

  constructor(binding: FlutterPluginBinding, uIAbility: UIAbility) {
    super(StandardMessageCodec.INSTANCE);
    this.binding = binding;
    this.uIAbility = uIAbility;
  }

  public create(context: common.Context, viewId: number, args: Any): PlatformView {
    //console.log(`BannerView created viewId: ${viewId}, args type: ${typeof args}, args: ${JSON.stringify(args)}`);
    return new BannerView(context, viewId, args, this.binding?.getBinaryMessenger()!, this.uIAbility!);
  }
}
