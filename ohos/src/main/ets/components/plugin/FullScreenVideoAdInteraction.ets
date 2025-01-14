import { Any, Log } from '@ohos/flutter_ohos';
import {
  AdSlotBuilder,
  CSJAdCreator,
  CSJAdSdk,
  CSJFullAd,
  FullAdInteractionListener,
  FullAdLoadListener
} from '@csj/openadsdk';
import FlutterUnionadEventPlugin from './FlutterUnionadEventPlugin';
import { window } from '@kit.ArkUI';

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/21 15:48
 */
export default class FullScreenVideoAdInteraction {
  private static TAG = "FullScreenVideoExpressAd"
  static mContext: Context | null = null
  static mActivity: window.WindowStage | null = null
  private static mttFullVideoAd: CSJFullAd | null = null
  //广告所需参数
  private static mCodeId: string | null = null
  private static orientation: number = 1
  private static mAdCreator: CSJAdCreator | null

  static init(
    context: Context,
    mActivity: window.WindowStage | null,
    mCodeId: string | null,
    orientation: number | null,
  ): void {
    FullScreenVideoAdInteraction.mContext = context
    FullScreenVideoAdInteraction.mActivity = mActivity
    FullScreenVideoAdInteraction.mCodeId = mCodeId
    FullScreenVideoAdInteraction.orientation = orientation!!
    FullScreenVideoAdInteraction.loadFullScreenVideoAd()
  }

  private static loadFullScreenVideoAd() {
    Log.e(FullScreenVideoAdInteraction.TAG, "广告位id  $mCodeId")
    FullScreenVideoAdInteraction.mAdCreator = CSJAdSdk.getAdCreator()
    //设置广告参数
    let adSlot = new AdSlotBuilder().setCodeId(FullScreenVideoAdInteraction.mCodeId)//广告位id
      .setOrientation(FullScreenVideoAdInteraction.orientation).build()
    let mLoadListener: FullAdLoadListener = {
      onAdLoaded: (fullAd: CSJFullAd) => {
        // 广告基础信息加载完成
        Log.e(FullScreenVideoAdInteraction.TAG, "fullScreenVideoAdInteraction loaded")
        FullScreenVideoAdInteraction.mttFullVideoAd = fullAd
        let map: Record<string, Any> = {
          "adType": "fullScreenVideoAdInteraction", "onAdMethod": "onReady"
        }
        FlutterUnionadEventPlugin.sendContent(map)
      },
      onAdCached: (fullAd: CSJFullAd) => {
        // 广告基础信息与素材缓存完成
        Log.e(FullScreenVideoAdInteraction.TAG, "fullScreenVideoAdInteraction video cached2")
      },
      onError: (code: number, message: string) => {
        Log.e(FullScreenVideoAdInteraction.TAG, "fullScreenVideoAd加载失败  $code === > $message")
        let map: Record<string, Any> = {
          "adType": "fullScreenVideoAdInteraction",
          "onAdMethod": "onFail",
          "error": code + message
        }
        FlutterUnionadEventPlugin.sendContent(map)
      }
    }
    //加载全屏视频
    FullScreenVideoAdInteraction.mAdCreator.loadFullAd(adSlot, mLoadListener)

  }

  static showAd() {
    if (FullScreenVideoAdInteraction.mttFullVideoAd == null) {
      let map: Record<string, Any> = {
        "adType": "fullScreenVideoAdInteraction",
        "onAdMethod": "onUnReady",
        "error": "广告预加载未完成"
      }
      FlutterUnionadEventPlugin.sendContent(map)
      return
    }
    let adInteractionListener: FullAdInteractionListener = {
      onShow: () => {
        Log.e(FullScreenVideoAdInteraction.TAG, "fullScreenVideoAdInteraction show")
        let map: Record<string, Any> = {
          "adType": "fullScreenVideoAdInteraction", "onAdMethod": "onShow"
        }
        FlutterUnionadEventPlugin.sendContent(map)
      },
      onSkip: () => {
        Log.e(FullScreenVideoAdInteraction.TAG, "fullScreenVideoAd skipped")
        let map: Record<string, Any> = {
          "adType": "fullScreenVideoAdInteraction", "onAdMethod": "onSkip"
        }
        FlutterUnionadEventPlugin.sendContent(map)
      },
      onClick: () => {
        Log.e(FullScreenVideoAdInteraction.TAG, "fullScreenVideoAd click")
        let map: Record<string, Any> = {
          "adType": "fullScreenVideoAdInteraction", "onAdMethod": "onClick"
        }
        FlutterUnionadEventPlugin.sendContent(map)
      },
      onClose: () => {
        Log.e(FullScreenVideoAdInteraction.TAG, "fullScreenVideoAd close")
        let map: Record<string, Any> = {
          "adType": "fullScreenVideoAdInteraction", "onAdMethod": "onClose"
        }
        FlutterUnionadEventPlugin.sendContent(map)
      },
      onComplete: () => {
        Log.e(FullScreenVideoAdInteraction.TAG, "fullScreenVideoAd complete")
        let map: Record<string, Any> = {
          "adType": "fullScreenVideoAdInteraction", "onAdMethod": "onFinish"
        }
        FlutterUnionadEventPlugin.sendContent(map)
      }
    }
    FullScreenVideoAdInteraction.mttFullVideoAd?.setInteractionListener(adInteractionListener)
    FullScreenVideoAdInteraction.mttFullVideoAd?.showFullAd(FullScreenVideoAdInteraction.mActivity)
  }
}