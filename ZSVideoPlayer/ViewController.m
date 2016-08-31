//
//  ViewController.m
//  ZSVideoPlayer
//
//  Created by Tony on 16/8/29.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "ViewController.h"
#import "LRLAVPlayerView.h"
//获取到window
#define Window [[UIApplication sharedApplication].delegate window]
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()<LRLAVPlayDelegate>
@property (nonatomic, strong) LRLAVPlayerView * avplayerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self createAVPlayerView];

}

#pragma mark - 创建用于播放的View
-(void)createAVPlayerView{
    //固定的实例化方法
    self.avplayerView = [LRLAVPlayerView avplayerViewWithVideoUrlStr:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8" andInitialHeight:200.0 andSuperView:self.view];
    
    self.avplayerView.delegate = self;
    [self.view addSubview:self.avplayerView];
    __weak ViewController * weakSelf = self;
    //我的播放器依赖 Masonry 第三方库
    [self.avplayerView setPositionWithPortraitBlock:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(60);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        //添加竖屏时的限制, 这条也是固定的, 因为: _videoHeight 是float* 类型, 我可以通过它, 动态改视频播放器的高度;
        make.height.equalTo(@(*(weakSelf.avplayerView->_videoHeight)));
    } andLandscapeBlock:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_HEIGHT));
        make.height.equalTo(@(SCREEN_WIDTH));
        make.center.equalTo(Window);
    }];
    
}

#pragma mark - 关闭设备自动旋转, 然后手动监测设备旋转方向来旋转avplayerView
-(BOOL)shouldAutorotate{
    return NO;
}



@end
