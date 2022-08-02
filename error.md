## Android

### 1、AAPT: error: unexpected element <queries> found in <manifest>.

* 旧版本build无法识别'queries'元素引起，建议修改项目中build中的版本为一下3.3.3、3.4.3、3.5.4、3.6.4、4.0.1中的一种，推荐改为4.0.1或者最新的。
* 图片、广告无法加载请尝试增加http权限，可能存在http资源

## IOS

### 1、CocoaPods could not find compatible versions for pod "Ads-CN":

* sdk库拉取失败，推荐使用pod install --repo-update拉取
* 图片、广告无法加载请尝试增加http权限，可能存在http资源
