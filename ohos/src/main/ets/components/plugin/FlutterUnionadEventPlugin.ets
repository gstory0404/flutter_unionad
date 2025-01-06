import { Any, EventChannel, FlutterPlugin, FlutterPluginBinding } from '@ohos/flutter_ohos';

import { EventSink, StreamHandler, } from '@ohos/flutter_ohos/src/main/ets/plugin/common/EventChannel';
import FlutterunionadViewConfig from './FlutterunionadViewConfig';

export default class FlutterUnionadEventPlugin implements FlutterPlugin, StreamHandler {
  onListen(args: Any, events: EventSink): void {
    FlutterUnionadEventPlugin.eventSink = events;
  }

  onCancel(args: Any): void {
    FlutterUnionadEventPlugin.eventSink = null
  }

  getUniqueClassName(): string {
    return FlutterunionadViewConfig.adevent;
  }


  private static eventChannel: EventChannel | null = null;
  private static eventSink: EventSink | null = null;
  private static context: Context | null = null;

  static sendContent(content: Record<string, Any>) {
    FlutterUnionadEventPlugin.eventSink?.success(content)
  }

  static sendError(errorCode: string, errorMessage: string, content: Map<string, Any>) {
    FlutterUnionadEventPlugin.eventSink?.error(errorCode, errorMessage, content)
  }


  onAttachedToEngine(binding: FlutterPluginBinding): void {
    FlutterUnionadEventPlugin.eventChannel =
      new EventChannel(binding.getBinaryMessenger(), FlutterunionadViewConfig.adevent);
    FlutterUnionadEventPlugin.eventChannel!!.setStreamHandler(this);
    FlutterUnionadEventPlugin.context = binding.getApplicationContext();
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    FlutterUnionadEventPlugin.eventChannel = null
    FlutterUnionadEventPlugin.eventChannel!!.setStreamHandler(null)
  }
}