//
//  RSNetworkTool.m
//  Stscm
//
//  Created by mac on 2020/6/8.
//  Copyright © 2020 mac. All rights reserved.
//

#import "RSNetworkTool.h"

@implementation RSNetworkTool



+ (void)networkTableViewHeader:(UITableView *)tableview{
    RSNetworkTool * network = [[RSNetworkTool alloc]init];
    tableview.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        
    }];
    //return network;
}


+ (void)networkTableViewFooter:(UITableView *)tableview{
    RSNetworkTool * network = [[RSNetworkTool alloc]init];
    tableview.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        
    }];
}





@end
