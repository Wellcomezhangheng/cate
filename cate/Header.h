//
//  Header.h
//  cate
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 张衡. All rights reserved.
//

#ifndef Header_h
#define Heer_h
#define kwidth [UIScreen mainScreen].bounds.size.width
#define kheight [UIScreen mainScreen].bounds.size.height
#	define ZHLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#define kAppKey @"1877028371"
#define kRedirectURL @"https://api.weibo.com/oauth2/default.html"
#define kBmob @"5e85d3fb9497bf3480f13b9123fdaba0"
#endif /* Header_h */
