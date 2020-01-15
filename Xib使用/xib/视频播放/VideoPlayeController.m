//
//  VideoPlayeController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/7/14.
//  Copyright © 2018年 微光星芒. All rights reserved.
//

#import "VideoPlayeController.h"
#import <MediaPlayer/MediaPlayer.h>
@interface VideoPlayeController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@property (nonatomic, strong) MPMoviePlayerViewController *movieViewPlayer;


@end

@implementation VideoPlayeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频播放";
    
    [self palyWithMPMediaPlayerController];
}

-(void)dealloc{
//    移除通知
//    1.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 1.
 使用MPMediaPlayerController 进行视频播放, 高度封装(有界面), 无法简单自定义界面,使用GPU解码, 状态信息通过通知使用
 */
- (void)palyWithMPMediaPlayerController{
    //播放
    [self.moviePlayer play];
    
    //添加通知
    [self addNotification];
}

/**
    获得本地路径
 */
- (NSURL *)getFileUrl{
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"We_Chat" ofType:@".MP4"];
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    return url;
}

/**
    获取网络视频地址
 */

- (NSURL *)getNetWorkUrl{
//    NSString *url = @"https://www.bilibili.com/video/av15975703/";
    NSString *url = @"http://192.168.1.161/The New Look of OS X Yosemite.mp4";
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL  *Url = [NSURL URLWithString:url];
    return Url;
}


/**
    创建媒体播放控制器
 */

- (MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
//        NSURL *url = [self getNetWorkUrl];
        NSURL *url = [self getFileUrl];
        _moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:url];
        _moviePlayer.view.frame = self.view.bounds;
        
        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}


/**
    添加通知
 */
- (void)addNotification{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
//    播放状态改变，可配合playbakcState属性获取具体状态
    [center addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    
//    播放结束
    [center addObserver:self selector:@selector(mediaPlayerPlaybackFinished) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    
}

- (void)mediaPlayerPlaybackStateChange:(NSNotification *)fication{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放");
            break;
        default:
            NSLog(@"*******%li",(long)self.moviePlayer.playbackState);
            break;
            
    }
}

-(void)mediaPlayerPlaybackFinished:(NSNotification *)fication{
    NSLog(@"*******播放完成%@",self.moviePlayer.playbackState);
}





@end
