//
//  ELLaunchManager.m
//  ELENews
//
//  Created by EL on 2017/12/27.
//  Copyright © 2017年 ElegantLiar. All rights reserved.
//

#import "ELLaunchManager.h"
#import "ELLaunchBean.h"

@implementation ELLaunchManager

+ (void)load{
    [self shareManager];
}

+ (ELLaunchManager *)shareManager{
    static ELLaunchManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[ELLaunchManager alloc] init];
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        //在UIApplicationDidFinishLaunching时初始化开屏广告,做到对业务层无干扰,当然你也可以直接在AppDelegate didFinishLaunchingWithOptions方法中初始化
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            //初始化开屏广告
            [self setupXHLaunchAd];
        }];
    }
    return self;
}

- (void)setupXHLaunchAd{
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [XHLaunchAd setLaunchSourceType:SourceTypeLaunchImage];
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [XHLaunchAd setWaitDataDuration:3];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:[ELNetWorkBaseParams baseParams]];
    NSString *url = @"http://api.app.happyjuzi.com/common/setting";
    
    [[ELHTTPManager manager] GET:url
                      parameters:params
                        progress:nil
                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                             
                             ELLaunchBean *lauchBean = [ELLaunchBean yy_modelWithJSON:[responseObject objectForKey:@"data"]];
                             //配置广告数据
                             XHLaunchVideoAdConfiguration *videoAdconfiguration = [XHLaunchVideoAdConfiguration new];
                             //广告停留时间
                             videoAdconfiguration.duration = 4;
                             //广告frame
                             videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
                             //广告视频URLString/或本地视频名(请带上后缀)
                             //注意:视频广告只支持先缓存,下次显示(看效果请二次运行)
                             videoAdconfiguration.videoNameOrURLString = lauchBean.splash.splash;
                             //视频缩放模式
                             videoAdconfiguration.scalingMode = MPMovieScalingModeAspectFill;
                             //是否只循环播放一次
                             videoAdconfiguration.videoCycleOnce = YES;
                             //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
//                             videoAdconfiguration.openModel = model.openUrl;
                             //广告显示完成动画
                             videoAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
                             //广告显示完成动画时间
                             videoAdconfiguration.showFinishAnimateTime = 0.8;
                             //后台返回时,是否显示广告
                             videoAdconfiguration.showEnterForeground = NO;
                             //跳过按钮类型
                             videoAdconfiguration.skipButtonType = SkipTypeTimeText;
                             //视频已缓存 - 显示一个 "已预载" 视图 (可选)
//                             if([XHLaunchAd checkVideoInCacheWithURL:[NSURL URLWithString:model.content]]){
//                                 //设置要添加的自定义视图(可选)
//                                 videoAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
//
//                             }
                             
                             [XHLaunchAd videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
                             
                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                             
                         }];
    
}


@end
