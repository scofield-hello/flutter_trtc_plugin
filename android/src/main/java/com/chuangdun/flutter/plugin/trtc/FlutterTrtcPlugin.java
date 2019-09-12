package com.chuangdun.flutter.plugin.trtc;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.text.TextUtils;
import android.util.Log;
import androidx.core.app.ActivityCompat;
import androidx.core.util.Preconditions;
import com.tencent.trtc.TRTCCloudDef;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.util.ArrayList;
import java.util.List;

/** FlutterTrtcPlugin */
public class FlutterTrtcPlugin implements MethodCallHandler{
  private static final String TAG = "FlutterTrtcPlugin";
  private static final String CHANNEL_NAME = "flutter_trtc_plugin";

  private final static int REQ_PERMISSION_CODE = 0x1000;
  private final static String[] REQUIRED_PERMISSIONS = {
      Manifest.permission.WRITE_EXTERNAL_STORAGE,
      Manifest.permission.READ_EXTERNAL_STORAGE,
      Manifest.permission.CAMERA,
      Manifest.permission.RECORD_AUDIO
  };
  /**加入或创建房间.*/
  private static final String METHOD_JOIN_ROOM = "joinRoom";
  /**腾讯TRTC App Id,整数.*/
  private static final String ARG_APP_ID = "app_id";
  /**用户ID.*/
  private static final String ARG_USER_ID = "user_id";
  /**用户签名.*/
  private static final String ARG_USER_SIG = "user_sig";
  /**用户角色 20:主播, 21:观众.*/
  private static final String ARG_USER_ROLE = "user_role";
  /**房间ID,整数*/
  private static final String ARG_ROOM_ID = "room_id";
  /**应用场景 0:视频电话,1:直播.*/
  private static final String ARG_SCENE_TYPE = "scene_type";
  /**是否自定义视频文件,false:非自定义,true:自定义(需传文件路径参数).*/
  private static final String ARG_IS_CUSTOM_VIDEO_CAPTURE = "is_custom_video_capture";
  /**视频文件路径.*/
  private static final String ARG_CUSTOM_VIDEO_URI = "custom_video_uri";

  static MethodChannel channel;

  private Activity mActivity;
  private Context mActiveContext;

  private FlutterTrtcPlugin(Activity activity, Context context) {
    this.mActivity = activity;
    this.mActiveContext = context;
  }
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
    final FlutterTrtcPlugin plugin = new FlutterTrtcPlugin(registrar.activity(),
        registrar.activeContext());
    channel.setMethodCallHandler(plugin);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals(METHOD_JOIN_ROOM)) {
      joinRoom(call, result);
    } else {
      result.notImplemented();
    }
  }

  private void joinRoom(MethodCall call, Result result){
    if (checkPermission()){
      try {
        Integer appId = call.argument(ARG_APP_ID);
        String userId = call.argument(ARG_USER_ID);
        String userSig = call.argument(ARG_USER_SIG);
        Integer userRole = call.argument(ARG_USER_ROLE);
        Integer roomId = call.argument(ARG_ROOM_ID);
        Integer sceneType = call.argument(ARG_SCENE_TYPE);
        Boolean isCustomVideoCapture = call.argument(ARG_IS_CUSTOM_VIDEO_CAPTURE);
        String customVideoUri = call.argument(ARG_CUSTOM_VIDEO_URI);
        Preconditions.checkArgument(appId != null && appId > 0, "无效的APP ID.");
        Preconditions.checkArgument(!TextUtils.isEmpty(userId), "无效的用户ID.");
        Preconditions.checkArgument(!TextUtils.isEmpty(userSig), "无效的签名信息.");
        Preconditions.checkArgument(roomId != null && roomId > 0, "无效的房间ID.");
        Preconditions.checkArgument(sceneType != null, "无效的场景类型.");
        Preconditions.checkArgument(sceneType == TRTCCloudDef.TRTC_APP_SCENE_VIDEOCALL
            || sceneType == TRTCCloudDef.TRTC_APP_SCENE_LIVE, "无效的场景类型.");
        Preconditions.checkArgument(userRole != null, "无效的用户角色.");
        Preconditions.checkArgument(userRole == TRTCCloudDef.TRTCRoleAnchor
            || userRole == TRTCCloudDef.TRTCRoleAudience, "无效的用户角色.");
        if (sceneType == TRTCCloudDef.TRTC_APP_SCENE_VIDEOCALL){
          Preconditions.checkArgument(userRole == TRTCCloudDef.TRTCRoleAnchor,
              "视频通话场景下不能指定为观众角色.");
        }
        Preconditions.checkArgument(isCustomVideoCapture != null, "无效的外部采集参数.");
        if (isCustomVideoCapture){
          Preconditions.checkArgument(!TextUtils.isEmpty(customVideoUri), "无效的视频文件路径.");
        }
        if (TextUtils.isEmpty(customVideoUri)){
          isCustomVideoCapture = false;
        }
        Intent intent = new Intent(mActivity, TRTCMainActivity.class);
        intent.putExtra(TRTCMainActivity.KEY_SDK_APP_ID, appId);
        intent.putExtra(TRTCMainActivity.KEY_USER_SIG,   userSig);
        intent.putExtra(TRTCMainActivity.KEY_ROOM_ID, roomId);
        intent.putExtra(TRTCMainActivity.KEY_USER_ID, userId);
        intent.putExtra(TRTCMainActivity.KEY_APP_SCENE, sceneType);
        intent.putExtra(TRTCMainActivity.KEY_ROLE, userRole);
        intent.putExtra(TRTCMainActivity.KEY_CUSTOM_CAPTURE, isCustomVideoCapture);
        intent.putExtra(TRTCMainActivity.KEY_VIDEO_FILE_PATH, customVideoUri);
        mActivity.startActivity(intent);
        result.success(null);
      }catch (IllegalArgumentException e){
        Log.e(TAG, "joinRoom: ", e);
        result.error("ILLEGAL_ARGUMENT", e.getMessage(), null);
      }
    }else{
      Log.w(TAG, "joinRoom: 未授予必要的权限.");
      result.error("PERMISSION_DENIED", "您必须授予必要的权限才能使用.", null);
    }
  }

  private boolean checkPermission() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
      List<String> permissions = new ArrayList<>(4);
      for (String permission : REQUIRED_PERMISSIONS){
        if (PackageManager.PERMISSION_GRANTED
            != ActivityCompat.checkSelfPermission(mActiveContext, permission)) {
          permissions.add(permission);
        }
      }
      if (permissions.size() != 0) {
        ActivityCompat.requestPermissions(mActivity, permissions.toArray(new String[0]),
            REQ_PERMISSION_CODE);
        return false;
      }
    }
    return true;
  }
}
