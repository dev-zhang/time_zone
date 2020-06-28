package com.xiaoxiami.time_zone;

import androidx.annotation.NonNull;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * TimeZonePlugin
 */
public class TimeZonePlugin implements FlutterPlugin, MethodCallHandler {
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "time_zone");
        channel.setMethodCallHandler(new TimeZonePlugin());
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "time_zone");
        channel.setMethodCallHandler(new TimeZonePlugin());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getTimeZoneData")) {
            Map<String, Object> map = getTimeZone();
            result.success(map);
        } else {
            result.notImplemented();
        }
    }

    private Map<String, Object> getTimeZone() {
        TimeZone zone = TimeZone.getDefault();
        String zoneID = zone.getID();
        long modifiedTimeZone = 0;
        try {
            Calendar cal = Calendar.getInstance();
            int offset = cal.get(Calendar.ZONE_OFFSET);
            cal.add(Calendar.MILLISECOND, -offset);
            Long timeStampUTC = cal.getTimeInMillis();
            Long timeStamp = System.currentTimeMillis();
            Long timeZone = (timeStamp - timeStampUTC) / (1000 * 3600);

            SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");

            Date time = new Date(timeStamp);
            TimeZone tz = TimeZone.getTimeZone("UTC");
            sdf.setTimeZone(tz);
            String strTime = sdf.format(time);

            Date time2 = new Date(timeStampUTC);
            TimeZone tz2 = TimeZone.getTimeZone("UTC");
            sdf.setTimeZone(tz2);
            String strTime2 = sdf.format(time2);
            long time1 = sdf.parse(strTime).getTime();
            long time3 = sdf.parse(strTime2).getTime();

            long result = (time1 - time3) / (1000 * 3600);
            modifiedTimeZone = result;
        } catch (ParseException e) {
            e.printStackTrace();
            modifiedTimeZone = 0;
        }
        Map<String, Object> map = new HashMap();
        map.put("id", zoneID);
        map.put("offset", modifiedTimeZone);
        return map;
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }
}
