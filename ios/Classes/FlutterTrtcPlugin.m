#import "FlutterTrtcPlugin.h"
#import <TXLiteAVSDK_Professional/TRTCCloud.h>
#import "TRTCMainViewController.h"
#import "TRTCFloatWindow.h"
@implementation FlutterTrtcPlugin{
    NSString *_appId;
    NSString *_userId;
    NSString *_userSig;
    NSString *_roomId;
    int _devMode;
    int _isCustomVideoCapture;
    NSString *_customVideoUri;
    int _sceneType;
    int _userRole;
    TRTCMainViewController *_TRTCMainController;
    UIViewController *_viewController;
}
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_trtc_plugin"
            binaryMessenger:[registrar messenger]];
  FlutterTrtcPlugin* instance = [[FlutterTrtcPlugin alloc] init];
    if (@available(iOS 5.0, *)) {
           UIViewController *viewController =
           [UIApplication sharedApplication].delegate.window.rootViewController;
           instance =
           [[FlutterTrtcPlugin alloc] initWithViewController:viewController];
       } else {
           // Fallback on earlier versions
       }
  [registrar addMethodCallDelegate:instance channel:channel];
    
}
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"joinRoom" isEqualToString:call.method]) {
      NSLog(@"获取房间号信息：%@", call.arguments);
      NSDictionary *dic = call.arguments;
      _appId = dic[@"app_id"];
      _userId = dic[@"user_id"];
      _userSig = dic[@"user_sig"];
      _roomId = dic[@"room_id"];
      if ([TRTCFloatWindow sharedInstance].localView) {
             [[TRTCFloatWindow sharedInstance] close];
         }else {
             TRTCParams *params = [[TRTCParams alloc] init];
             params.sdkAppId = (UInt32)_appId.integerValue;
             params.userId = _userId;
             params.userSig = _userSig;
             params.roomId = (UInt32)_roomId.integerValue;
             params.role = _userRole;
             _TRTCMainController.param = params;
             _TRTCMainController.enableCustomVideoCapture = 1;
             _TRTCMainController.appScene = _sceneType;
             _TRTCMainController.modalPresentationStyle = UIModalPresentationFullScreen;
             [_viewController presentViewController:_TRTCMainController animated:YES completion:nil];
         }
      
      
  } else {
    result(FlutterMethodNotImplemented);
  }
}

#pragma mark -初始化
- (instancetype)initWithViewController:(UIViewController *)viewController {
  self = [super init];
  if (self) {
    _viewController = viewController;
    _TRTCMainController = [[TRTCMainViewController alloc] init];
  }
  return self;
}
@end
