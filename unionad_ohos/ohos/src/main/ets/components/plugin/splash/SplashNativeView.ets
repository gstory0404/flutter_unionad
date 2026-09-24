import { Params } from '@ohos/flutter_ohos/src/main/ets/plugin/platform/PlatformView';
import { AdSlotBuilder, CSJAdSdk, CSJSplashAd, CSJSplashAdCloseType, CSJSplashAdInteractionListener, CSJSplashAdLoadListener, CSJSplashAdLoadParam, ExpressAdInteractionListener, NativeExpressAdListener } from '@csj/openadsdk';
import { MethodChannel } from '@ohos/flutter_ohos';
import { window, NodeController } from '@kit.ArkUI';
import SplashView from "./SplashView"

@Component
export struct SplashNativeView {
  @Prop params: Params;
  splashView: SplashView = this.params.platformView as SplashView
  @State splashAd?: CSJSplashAd = undefined
  timeout: number = 3000;
  mCodeId: string = '';
  viewWidth: number = 0;
  viewHeight: number = 0;
  windowStage?: window.WindowStage;
  @State isClose: boolean = false
  @State mWindow?: window.Window = undefined
  mAdCreator = CSJAdSdk.getAdCreator()
  @State splashAdComponent: NodeController | undefined = undefined

  build() {
    if (!this.isClose) {
      Row() {
        if (this.splashAd && this.splashAdComponent) {
          NodeContainer(this.splashAdComponent);
        }
      }.width(this.viewWidth).height(this.viewHeight)
    }
  }

  aboutToAppear(): void {
    this.mCodeId = this.splashView.getMCodeId();
    this.viewWidth = this.splashView.getViewWidth();
    this.viewHeight = this.splashView.getViewHeight();
    this.windowStage = this.splashView.getWindowStage();
    this.timeout = this.splashView.getTimeout();

    let adSlot = new AdSlotBuilder()
      .setCodeId(this.mCodeId)
      .setAcceptSize(this.viewWidth, this.viewHeight)
      .build()

    let mSplashAdInteractionListener: CSJSplashAdInteractionListener = {
      onDidShow: () => {
        //console.log("SplashNativeView->开屏回调 - onDidShow")
        //this.channel?.invokeMethod("onShow", "开屏广告展示成功")
        this.splashView.sendMsg("onShow", "开屏广告展示成功")
      },

      onDidClose: (closeType: CSJSplashAdCloseType) => {
        //console.log(`SplashNativeView->开屏回调 - onDidClose 关闭原因：${closeType.value}`)
        if (closeType == CSJSplashAdCloseType.CLICK_SKIP) {
          //this.channel?.invokeMethod("onSkip", "开屏广告跳过")
          this.splashView.sendMsg("onSkip", "开屏广告跳过")
        } else {
          //this.channel?.invokeMethod("onFinish", "开屏广告倒计时结束")
          this.splashView.sendMsg("onFinish", "开屏广告倒计时结束")
        }
        this.splashAd = undefined
        // 方式二：需自行移除广告
        this.mWindow?.destroyWindow()
      },

      onDidClick: () => {
        //console.log("SplashNativeView->开屏回调 - onDidClick")
        //this.channel?.invokeMethod("onClick", "开屏广告点击")
        this.splashView.sendMsg("onClick", "开屏广告点击")
      },

      onVideoDidPlayFinish: () => {

      },

      onVideoDidPlayFail: () => {
        //console.log("SplashNativeView->开屏回调 - onVideoDidPlayFail")
        //this.channel?.invokeMethod("onFail", "开屏广告播放失败")
        this.splashView.sendMsg("onFail", "开屏广告播放失败")
        this.isClose = true;
        this.mWindow?.destroyWindow()
      }
    }

    let expressLoadAdListener: CSJSplashAdLoadListener = {
      onError: (code: number, message: string) => {
        //广告加载失败
        //this.channel?.invokeMethod("onFail", `${code}, ${message}`);
        this.splashView.sendMsg("onFail", `${code}, ${message}`);
        this.isClose = true;
        this.mWindow?.destroyWindow()
      },
      onAdLoaded: (splashAd: CSJSplashAd) => {
        // 开屏加载成功
        this.splashAd = splashAd;
        this.splashAd.setInteractionListener(mSplashAdInteractionListener)
      },
      onRenderSuccess: (splashAd: CSJSplashAd): void => {
        let mainWindow = this.windowStage?.getMainWindowSync();
        this.mWindow = mainWindow
        this.splashAdComponent = this.splashAd!.getAdComponent(false, this.mWindow)
      },
      onRenderFail: (code: number, message: string): void => {
        this.splashView.sendMsg("onFail", `${code}, ${message}`);
      }
    }

    let loadParam = new CSJSplashAdLoadParam(adSlot, expressLoadAdListener, this.getUIContext(), this.timeout)
    this.mAdCreator.loadSplashAd(loadParam)
  }
}

@Builder
export function SplashBuilder(params: Params) {
  SplashNativeView({
    params: params,
  })
}