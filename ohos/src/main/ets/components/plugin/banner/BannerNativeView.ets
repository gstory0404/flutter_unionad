import { Params } from '@ohos/flutter_ohos/src/main/ets/plugin/platform/PlatformView';
import { AdSlotBuilder, CSJAdSdk, CSJNativeExpressAd, ExpressAdInteractionListener, NativeExpressAdListener, AdSlot } from '@csj/openadsdk';
import { MethodChannel, Any } from '@ohos/flutter_ohos';
import { NodeController } from '@kit.ArkUI';
import BannerView from './BannerView';
import { ArrayList } from '@kit.ArkTS';

@Component
export struct BannerNativeView {
  @Prop params: Params;
  // 广告对象引用（用于生命周期管理）
  private bannerAd?: CSJNativeExpressAd = undefined
  // ⚠️ 关键：单独存储广告组件的 NodeController，避免重复调用 getAdComponent()
  @State bannerAdComponent?: NodeController = undefined
  // 控制广告是否显示
  @State isShowAd: boolean = false
  bannerView: BannerView = this.params.platformView as BannerView
  mCodeId: string = ''
  acceptWidth: number = 0;
  acceptHeight: number = 0;
  mAdSlot?: AdSlot

  build() {
    Row() {
      // 使用缓存的 bannerAdComponent 而不是每次调用 getAdComponent()
      if (this.bannerAdComponent && this.mAdSlot && this.isShowAd) {
        NodeContainer(this.bannerAdComponent)
          .width(this.mAdSlot.getAcceptWidth())
          .height(this.mAdSlot.getAcceptHeight())
          .alignSelf(ItemAlign.Center)
          .align(Alignment.Center);
      }
    }
  }

  aboutToAppear(): void {
    this.mCodeId = this.bannerView.getMCodeId();
    this.acceptWidth = this.bannerView.getAcceptWidth();
    this.acceptHeight = this.bannerView.getAcceptHeight();

    this.loadAd()
  }

  private loadAd() {
    this.mAdSlot = new AdSlotBuilder()
      .setCodeId(this.mCodeId)
      .setAdCount(1)
      .setAcceptSize(this.acceptWidth, this.acceptHeight)
      .build()

    let mLoadListener: NativeExpressAdListener = {
      onError: (code: number, message: string) => {
        //console.error("BannerView->加载广告失败，code=" + code + "，message=" + message);
        this.bannerView.sendMsg("onFail", `${code}, ${message}`)
      },

      onNativeExpressAdLoad: (ads: ArrayList<CSJNativeExpressAd>) => {
        //console.log("BannerView==onNativeExpressAdLoad......success");
        if (ads && ads.length > 0) {
          // 获取第一个广告
          this.showAd(ads[0])
        }
      }
    }

    let mAdCreator = CSJAdSdk.getAdCreator()
    mAdCreator.loadBannerAd(this.mAdSlot, mLoadListener)
  }

  private showAd(bannerAd: CSJNativeExpressAd) {
    // 设置广告交互监听器
    bannerAd.setExpressInteractionListener({
      onAdClicked: (type: number) => {
        //console.log("BannerView==onAdClicked......");
        this.bannerView.sendMsg("onClick", "Banner广告点击")
      },

      onAdShow: (type: number) => {
        //console.log("BannerView==onAdShow......");
      },

      onRenderFail: (code: number, msg: string) => {
        //console.log("BannerView==onRenderFail...code=" + code + ",msg=" + msg);
        this.bannerView.sendMsg("onFail", `${code}, ${msg}`)
        // 渲染失败，隐藏广告并清空引用
        this.isShowAd = false;
        this.bannerAdComponent = undefined;
        this.bannerAd = undefined;
      },

      onRenderSuccess: (width: number, height: number) => {
        //console.log("BannerView==onRenderSuccess......width=" + width + ",height=" + height);
        // ⚠️ 关键：渲染成功后，保存广告对象和组件引用
        this.bannerAd = bannerAd;
        // 只在渲染成功后获取一次 AdComponent，避免重复调用
        this.bannerAdComponent = bannerAd.getAdComponent();
        this.isShowAd = true;
        
        // 发送 onShow 回调
        let map: Record<string, Any> = {
          "width": width, "height": height
        };
        this.bannerView.sendMsg("onShow", map)
      }
    })

    // 设置 dislike 回调
    this.setDislikeCallback(bannerAd);
    // 设置轮播间隔时间 30秒
    bannerAd.setSlideIntervalTime(30 * 1000)
    // 开始渲染广告
    bannerAd.render(this.getUIContext())
  }

  // 组件销毁时释放广告资源
  aboutToDisappear(): void {
    if (this.bannerAd) {
      this.bannerAd.destroy();
      this.bannerAd = undefined;
      this.bannerAdComponent = undefined;
    }
  }

  private setDislikeCallback(ad: CSJNativeExpressAd) {
    ad.setDislikeCallback({
      /**
       * dislike show
       */
      onShow: () => {
        //console.log("BannerExpressAdPage==dislike......show");
      },

      /**
       * @param position 选择的位置
       * @param value 选择的内容
       * @param enforceRemove 是否强制关闭广告
       */
      onSelected: (position: number, value: string, enforceRemove: boolean) => {
        //console.log("BannerView==dislike......onSelected:position=" + position + ",value:" + value + ",enforce=" + enforceRemove);
        this.bannerView.sendMsg("onDislike", value);
        // 根据 enforceRemove 决定是否隐藏广告（与官方 demo 一致）
        this.isShowAd = !enforceRemove;
        if (enforceRemove) {
          this.bannerAdComponent = undefined;
          this.bannerAd = undefined;
        }
      },

      /**
       * 点击取消
       */
      onCancel: () => {
        //console.log("BannerView==dislike......onCancel");
      }
    })
  }
}

@Builder
export function BannerBuilder(params: Params) {
  BannerNativeView({
    params: params,
  })
}
