//
//  NetSpeedController.m
//  Xib使用
//
//  Created by 微光星芒 on 2018/11/20.
//  Copyright © 2018 微光星芒. All rights reserved.
//

#import "NetSpeedController.h"

#include <ifaddrs.h>

#include <arpa/inet.h>

#include <net/if.h>

@interface NetSpeedController ()

@property (nonatomic, copy) NSTimer *timer;

@end

@implementation NetSpeedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getInternetface) userInfo:nil repeats:YES];
    
    [_timer fireDate];
}

-(void)viewWillDisappear:(BOOL)animated{
    [_timer invalidate];
}


- (void)getInternetface {
    
    long long hehe = [self getInterfaceBytes];
    
    NSLog(@"hehe:%lld",hehe);
    
}



/*获取网络流量信息*/

- (long long) getInterfaceBytes

{
    
    struct ifaddrs *ifa_list = 0, *ifa;
    
    if (getifaddrs(&ifa_list) == -1)
        
    {
        
        return 0;
        
    }
    
    
    
    uint32_t iBytes = 0;
    
    uint32_t oBytes = 0;
    
    
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
        
    {
        
        if (AF_LINK != ifa->ifa_addr->sa_family)
            
            continue;
        
        
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            
            continue;
        
        
        
        if (ifa->ifa_data == 0)
            
            continue;
        
        
        
        /* Not a loopback device. */
        
        if (strncmp(ifa->ifa_name, "lo", 2))
            
        {
            
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
            
        }
        
    }
    
    freeifaddrs(ifa_list);
    
    
    
    NSLog(@"\n[getInterfaceBytes-Total]%d,%d",iBytes,oBytes);
    
    return iBytes + oBytes;
    
}

@end
