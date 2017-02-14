//
//  BWZFPlayerViewController.m
//  BWiOSResearchMedia
//
//  Created by BobWong on 2017/2/13.
//  Copyright © 2017年 BobWong. All rights reserved.
//

#import "BWZFPlayerViewController.h"
#import "ZFPlayer.h"
#import "AFNetworking.h"
#import "BWVideoManager.h"

@interface BWZFPlayerViewController () <ZFPlayerDelegate>

@property (weak, nonatomic)  IBOutlet UIView *playerSuperView;
@property (strong, nonatomic) ZFPlayerView *playerView;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;

@end

@implementation BWZFPlayerViewController

- (void)dealloc
{
    NSLog(@"%@释放了",self.class);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        [self.playerView play];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.playerView && !self.playerView.isPauseByUser)
    {
        self.isPlaying = YES;
        [self.playerView pause];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.playerView = [[ZFPlayerView alloc] init];
    
    // 自定义视频播放控制视图
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    UIView *backBtn = (UIView *)[controlView valueForKey:@"backBtn"];
    if (backBtn) backBtn.hidden = YES;
    [self.playerView playerControlView:controlView playerModel:self.playerModel];
    
    // 设置代理
    self.playerView.delegate = self;
    
    //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
    // self.playerView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    
    // 打开下载功能（默认没有这个功能）
    self.playerView.hasDownload    = YES;
    // 打开预览图
    self.playerView.hasPreviewView = YES;
    
    // 是否自动播放，默认不自动播放
//    [self.playerView autoPlayTheVideo];
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - ZFPlayerDelegate

- (void)zf_playerBackAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)zf_playerDownload:(NSString *)url
{
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
//    NSString *name = [url lastPathComponent];
//    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
//    // 设置最多同时下载个数（默认是3）
//    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
    
    
    
    [[BWVideoManager sharedManager] downloadVideoWithURL:url];
}

#pragma mark - Getter

- (ZFPlayerModel *)playerModel
{
    if (!_playerModel) {
        _playerModel = [[ZFPlayerModel alloc] init];
        _playerModel.title = @" ";
        
        NSString *URLString = @"http://pubfile.bluemoon.com.cn/group1/M00/04/85/wKgwBliX3zqASBQkAG-e7r3kAYw078.mp4";
        NSURL *URL = [[BWVideoManager sharedManager] getVideoURLWithURLString:URLString];
        NSLog(@"URL is %@", URL);
        
        _playerModel.videoURL = URL;
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.fatherView = self.playerSuperView;
    }
    return _playerModel;
}

@end