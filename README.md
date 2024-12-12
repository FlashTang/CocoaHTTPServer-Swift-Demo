注意事项：
1) 新版Xcode 编译target 必须ios12+ (可以在Podfile中设置)
2) Build Settings - User Script Sandbox : NO
3) 修复CocoaHTTPServer因新版CocoaLumberjack API报错 :
   
   1: 找到 CocoaHTTPServer/HTTPLogging.h
   
   2: 把 `#import "DDLog.h"` 替换为 `#import <CocoaLumberjack/CocoaLumberjack.h>`
   
   3: 新增以下定义：
      ```
      #define HTTP_LOG_OBJC_MAYBE(async, lvl, flg, ctx, frmt, ...) \
      do{ if(HTTP_LOG_ASYNC_ENABLED) LOG_MAYBE(async, lvl, flg, ctx, nil, sel_getName(_cmd), frmt, ##__VA_ARGS__); } while(0)
      
      #define HTTP_LOG_C_MAYBE(async, lvl, flg, ctx, frmt, ...) \
      do{ if(HTTP_LOG_ASYNC_ENABLED) LOG_MAYBE(async, lvl, flg, ctx, nil, __FUNCTION__, frmt, ##__VA_ARGS__); } while(0)
      
      ```

   4: 把整个头文件里的：
   
      所有`LOG_OBJC_MAYBE`改成`HTTP_LOG_OBJC_MAYBE`
   
      所有`LOG_C_MAYBE`改成`HTTP_LOG_C_MAYBE`
   
参考：https://www.jianshu.com/p/b693d660acc1

Notice:
1) Build Target must be iOS 12+ if you use newer version of Xcode (you can change it manually or set in Podfile)
2) Build Settings - User Script Sandbox : NO
3) Fix the error caused by the new version CocoaLumberjack

   1: Find CocoaHTTPServer/HTTPLogging.h
  
   2: Replace `#import "DDLog.h"` with `#import <CocoaLumberjack/CocoaLumberjack.h>`
  
   3: Add the following definition:
      ```
      #define HTTP_LOG_OBJC_MAYBE(async, lvl, flg, ctx, frmt, ...) \
      do{ if(HTTP_LOG_ASYNC_ENABLED) LOG_MAYBE(async, lvl, flg, ctx, nil, sel_getName(_cmd), frmt, ##__VA_ARGS__); } while(0)
      
      #define HTTP_LOG_C_MAYBE(async, lvl, flg, ctx, frmt, ...) \
      do{ if(HTTP_LOG_ASYNC_ENABLED) LOG_MAYBE(async, lvl, flg, ctx, nil, __FUNCTION__, frmt, ##__VA_ARGS__); } while(0)
      ```

   4: Change the entire header file:

      All `LOG_OBJC_MAYBE` to `HTTP_LOG_OBJC_MAYBE`
      
      All `LOG_C_MAYBE` to `HTTP_LOG_C_MAYBE`

 Reference: https://www.jianshu.com/p/b693d660acc1
   
