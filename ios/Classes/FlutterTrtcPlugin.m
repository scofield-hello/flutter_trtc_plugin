#import "FlutterTrtcPlugin.h"
#import <TXLiteAVSDK_TRTC/TRTCCloud.h>
#import "TRTCMainViewController.h"
#import "TRTCFloatWindow.h"
#import <AVFoundation/AVFoundation.h>

@implementation FlutterTrtcPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_trtc_plugin"
            binaryMessenger:[registrar messenger]];
  FlutterTrtcPlugin* instance = [[FlutterTrtcPlugin alloc] init];
    if (@available(iOS 5.0, *)) {
           UIViewController *viewController =
           [UIApplication sharedApplication].delegate.window.rootViewController;
           instance =
           [[FlutterTrtcPlugin alloc] initWithController:viewController];
       } else {
           // Fallback on earlier versions
       }
  [registrar addMethodCallDelegate:instance channel:channel];
    
}
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"joinRoom" isEqualToString:call.method]) {
      NSLog(@"进入/创建房间 参数列表：%@", call.arguments);
      NSDictionary *argument = call.arguments;
      NSNumber *appId = [argument objectForKey:@"app_id"];
      NSNumber *roomId = [argument objectForKey:@"room_id"];
      NSString *userId = [argument objectForKey:@"user_id"];
      NSString *userSig = [argument objectForKey:@"user_sig"];
      NSInteger userRole = [(NSNumber*)[argument objectForKey:@"user_role"] integerValue];
      NSInteger scenType = [(NSNumber*)[argument objectForKey:@"scene_type"] integerValue];
      BOOL isDevMode = [(NSNumber*)[argument objectForKey:@"dev_mode"] boolValue];
      BOOL isCustomVideoCapture = [(NSNumber*)[argument objectForKey: @"is_custom_video_capture"] boolValue];
      NSString *customVideoUri = [argument objectForKey:@"customVideoUri"];
      if ([TRTCFloatWindow sharedInstance].localView) {
             [[TRTCFloatWindow sharedInstance] close];
         }else {
             TRTCParams *params = [[TRTCParams alloc] init];
             params.sdkAppId = appId.intValue;//(UInt32)_appId.integerValue;
             params.roomId = roomId.intValue;//(UInt32)_roomId.integerValue;
             params.userId = userId;
             params.userSig = userSig;
             params.role = userRole == TRTCRoleAnchor ? TRTCRoleAnchor:TRTCRoleAudience;
             TRTCAppScene appScene = scenType == TRTCAppSceneVideoCall
             ? TRTCAppSceneVideoCall: TRTCAppSceneLIVE;
             AVAsset *asset = nil;
             if(customVideoUri){
                 NSURL *assetUrl = [NSURL URLWithString:customVideoUri];
                 asset = [AVAsset assetWithURL:assetUrl];
             }
             
             TRTCMainViewController *controller = [[TRTCMainViewController alloc] initWithParams:params
                 appScene:appScene
                 enableCustomVideoCapture:isCustomVideoCapture
                 customVideoAsset:asset
                 devMode:isDevMode];
             controller.modalPresentationStyle = UIModalPresentationFullScreen;
             [self.mainController presentViewController:controller animated:YES completion:nil];
         }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

#pragma mark -初始化
- (instancetype)initWithController:(UIViewController *)viewController {
  self = [super init];
  if (self) {
      self.mainController = viewController;
  }
  return self;
}
@end
