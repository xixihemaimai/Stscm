//
//  RSBaseViewController.m
//  OAManage
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSBaseViewController.h"
//工作台
#import "RSStscmController.h"
//我的
#import "RSMineViewController.h"
//消息
#import "RSMessageViewController.h"
//注册
#import "RSRegisterViewController.h"
//密码注册
#import "RSPasswordViewController.h"
//登录
#import "RSLoginViewController.h"
//修改电话号码
#import "RSChagePhoneNumberViewController.h"

#import <CoreLocation/CoreLocation.h>
#import "AmendCoordinate.h"


@interface RSBaseViewController ()<CLLocationManagerDelegate>

@property (nonatomic,strong)CLLocationManager * locaationManager;


@end

@implementation RSBaseViewController

- (UICollectionView *)collectionview{
    if (_collectionview) {
        
//        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        //iteme的设置也可以使用UICollectionViewDelegateFlowLayout的代理,如下注释
//        flowLayout.minimumInteritemSpacing = 0;
//        flowLayout.minimumLineSpacing =0;
//        flowLayout.itemSize = CGSizeMake(SCW/7, SCW/7); // cell的大小
//        flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, SCW/7);
//        [_collectionview setCollectionViewLayout:flowLayout];
        
        _collectionview = [[UICollectionView alloc]init];
        [_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"COLLECTIONVIEWID"];
        _collectionview.delegate = self;
    }
    return _collectionview;
}



- (UITableView *)tableview{
    if (!_tableview) {
       // CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
        //CGRectMake(0, navY + navHeight, SCW, SCH - (navY + navHeight))
       // CGFloat navY = self.navigationController.navigationBar.frame.origin.y;
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

- (ZZQEmptyView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[ZZQEmptyView alloc] initWithView:self.view];
        _emptyView.emptyMode = ZZQEmptyViewModeNoData;
        _emptyView.label.text = @"暂无数据";
        [_emptyView.button setTitle:@"点击重新加载" forState:UIControlStateNormal];
        _emptyView.hidden = NO;
        _emptyView.button.hidden = YES;
        _emptyView.showtype = @"0";
        
        [_emptyView.button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    return _emptyView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithDyColorChangObject:self.view andHexLightColorStr:@"#ffffff" andHexDarkColorStr:@"#000000"];
    if (@available(iOS 11.0, *)) {
      self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
      self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];

    
    //已经登录
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSData * data = [user objectForKey:@"usermodel"];
//    RSUserModel * usermodel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    UserInfo * userInfo = [UserInfoContext sharedUserInfoContext].userInfo = [Usertilities GetNSUserDefaults];
    NSLog(@"============323===============%@",userInfo.userPhone);
    if (![self isKindOfClass:[RSLoginViewController class]]) {
        if (userInfo.loginToken.length > 0) {
            
        }else{
            //没有登录中
            [Usertilities clearLocalUserModel];
        }
    }
    
    [self.view addSubview:self.tableview];
    
    if ([self isKindOfClass:[RSStscmController class]] || [self isKindOfClass:[RSMineViewController class]] || [self isKindOfClass:[RSMessageViewController class]] || [self isKindOfClass:[RSRegisterViewController class]] || [self isKindOfClass:[RSPasswordViewController class]] || [self isKindOfClass:[RSLoginViewController class]] || [self isKindOfClass:[RSChagePhoneNumberViewController class]]) {
        
        self.tableview.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .topSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 0);
        
    }else{
        
       self.tableview.sd_layout
       .leftSpaceToView(self.view, 0)
       .rightSpaceToView(self.view, 0)
       .topSpaceToView(self.navigationController.navigationBar, 0)
       .bottomSpaceToView(self.view, 0);
        
    }
    [self.view addSubview:self.emptyView];
    
    if ([self isKindOfClass:[RSPasswordViewController class]] || [self isKindOfClass:[RSMineViewController class]]  || [self isKindOfClass:[RSMessageViewController class]] ) {
        RSWeakself
        //下拉刷新
        self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakSelf.pageNum = 1;
            NSLog(@"--------------------%ld",weakSelf.pageNum);
            weakSelf.customBlock(weakSelf.pageNum);
            [weakSelf.tableview.mj_header endRefreshing];
        }];
        //上拉刷新
        self.tableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            weakSelf.pageNum++;
            weakSelf.customBlock(weakSelf.pageNum);
            [weakSelf.tableview.mj_footer endRefreshing];
        }];
    }
    
    if ([self isKindOfClass:[RSRegisterViewController class]] || [self isKindOfClass:[RSLoginViewController class]] || [self isKindOfClass:[RSPasswordViewController class]] || [self isKindOfClass:[RSStscmController class]]) {
        self.navigationController.navigationBar.hidden = YES;
    }else{
        self.navigationController.navigationBar.hidden = NO;
    }
    
    
    
    
    
    
    if ([self isKindOfClass:[RSLoginViewController class]] || [self isKindOfClass:[RSPasswordViewController class]]) {
        if ([self checkLocationServiceIsEnabled]) {
            [self createCLManager];
        }
    }
}


- (BOOL)checkLocationServiceIsEnabled{
    // 该方法是类方法，和我们创建的管理器没有关系
    if ([CLLocationManager locationServicesEnabled]) {
        return YES;
    }
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"系统定位尚未打开，请到【设定-隐私】中手动打开" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * tipsAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:tipsAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    return NO;
}

- (void)createCLManager{
    // 创建CoreLocation管理对象
    self.locaationManager = [[CLLocationManager alloc]init];
    // 设定定位精准度
    [self.locaationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    // 设定DistanceFilter可以在用户移动指定距离之后触发更新事件（100米更新一次）
    [self.locaationManager setDistanceFilter:5.0];
    // 设置代理
    self.locaationManager.delegate = self;
    // 开始更新定位
    [self.locaationManager startUpdatingLocation];
}
// 代理方法，定位权限检查
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:{
            NSLog(@"用户还未决定授权");
            // 主动获得授权
            [self.locaationManager requestWhenInUseAuthorization];
            break;
        }
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            // 主动获得授权
            [self.locaationManager requestWhenInUseAuthorization];
            break;
        }
        case kCLAuthorizationStatusDenied:{
            // 此时使用主动获取方法也不能申请定位权限
            // 类方法，判断是否开启定位服务
            if ([CLLocationManager locationServicesEnabled]) {
                NSLog(@"定位服务开启，被拒绝");
            } else {
                NSLog(@"定位服务关闭，不可用");
            }
            break;
        }
        case kCLAuthorizationStatusAuthorizedAlways:{
            NSLog(@"获得前后台授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            NSLog(@"获得前台授权");
            break;
        }
        default:
            break;
    }
}

-  (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [self backlearningCLLocationLocations:locations];
}

//- (void)learningCLLocationLocations:(NSArray<CLLocation *> *)locations{
//    // locations是一个数组提供了一连串的用户定位，所以在这里我们只取最后一个（当前最后的定位）
//       CLLocation * newLocation = [locations lastObject];
//       // 判空处理
//       if (newLocation.horizontalAccuracy < 0) {
//           UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位错误，请检查手机网络以及定位" preferredStyle:UIAlertControllerStyleAlert];
//           UIAlertAction * tipsAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
//           [alertVC addAction:tipsAction];
//           [self presentViewController:alertVC animated:YES completion:nil];
//           return;
//       }
//       // 获取定位经纬度
//       CLLocationCoordinate2D coor2D = newLocation.coordinate;
//       NSLog(@"纬度为:%f, 经度为:%f", coor2D.latitude, coor2D.longitude);
//       // 获取定位海拔高度
//       CLLocationDistance altitude = newLocation.altitude;
//       NSLog(@"高度为:%f", altitude);
//       // 获取定位水平精确度, 垂直精确度
//       CLLocationAccuracy horizontalAcc = newLocation.horizontalAccuracy;
//       CLLocationAccuracy verticalAcc = newLocation.verticalAccuracy;
//       NSLog(@"%f, %f", horizontalAcc, verticalAcc);
//       // 停止更新位置
//       [self.locaationManager stopUpdatingLocation];
//}

- (void)backlearningCLLocationLocations:(NSArray<CLLocation *> *)locations{
    /**
     定位管理器返回的位置是用CLLoation实例表示的，里面包含了有关位置的重要信息
     比如：
     CLLocationCoordinate2D 用来表示经纬度坐标
     使用方式:
     CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude) 创建一个经纬度坐标
     coordinate.latitude,coordinate.longitude 读取经纬度

     CLLocationDistance  用来表示实际位置和返回坐标之间的距离（以米为单位）
     使用方式：获取
     location.altitude

     CLLocationAccuracy 地理坐标的准确性
     使用方式：获取
     location.horizontalAccuracy; 指定坐标的水平精度(以米为单位)
     location.verticalAccuracy; 高度值的精度(以米为单位)

     timestamp 时间戳，指出何时在定位管理器获取的位置
     使用方式：获取
     location.timestamp

     CLLocationSpeed 装置运动的速度(以米每秒为单位)
     使用方式：获取
     location.speed

     CLLocationDirection 方位角以相对于真北的角度来测量的方位角
     使用方式：获取
     location.course
     */
    //已经很详细的表达出来啦，这些数据可能会有用，希望大家能记下来。虽然我们已经获取了定位的数据，但这些数据我们确实看着不懂，那我们该怎么办呢？苹果提供了一个CLGeocoder类，这个类是用于在地理坐标和地名之间转换的接口，也就是常说的逆地理编码（反地理编码）

    // 反地理编码(根据当前的经纬度获取具体的位置信息)
    CLLocation * newLocation = [locations lastObject];

     CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    NSLog(@"--------000000000-------------经度:%f-------------纬度:%f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
//    if (![AmendCoordinate isLocationOutOfChina:[newLocation coordinate]]) {
//        CLLocationCoordinate2D gcj02 = CLLocationCoordinate2DMake(newLocation.coordinate.latitude,newLocation.coordinate.longitude);
//        CLLocationCoordinate2D coord = [AmendCoordinate transformFromBDToGCJ:gcj02];
//        NSLog(@"--------232323-------------经度:%f-------------纬度:%f",coord.latitude,coord.longitude);
//        CLLocationCoordinate2D coord_bd9 = [AmendCoordinate transformFromGCJToBD:[newLocation coordinate]];
//        NSLog(@"--------+++++++-------------经度:%f-------------纬度:%f",coord_bd9.latitude,coord_bd9.longitude);
//        CLLocationCoordinate2D coord_bd8 = [AmendCoordinate transformFromGCJToBD:coord];
//        NSLog(@"--------=======-------------经度:%f-------------纬度:%f",coord_bd8.latitude,coord_bd8.longitude);
//        CLLocation * cl = [[CLLocation alloc] initWithLatitude:coord_bd8.latitude longitude:coord_bd8.longitude];
//        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//                for (CLPlacemark *placeMark in placemarks) {
//                    NSLog(@"------------位置:%@", placeMark.name);
//                    NSLog(@"街道:%@", placeMark.thoroughfare);
//                    NSLog(@"子街道:%@", placeMark.subThoroughfare);
//                    NSLog(@"市:%@", placeMark.locality);
//                    NSLog(@"区\\县:%@", placeMark.subLocality);
//                    NSLog(@"行政区:%@", placeMark.administrativeArea);
//                    NSLog(@"国家:%@", placeMark.country);
//
//                }
//        }];
//    }else{
        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
           CLPlacemark *placeMark = placemarks.firstObject;
            self.placeMark = [NSString stringWithFormat:@"%@%@%@",placeMark.country,placeMark.administrativeArea,placeMark.locality];
//                   for (CLPlacemark *placeMark in placemarks) {
//                       NSLog(@"++++++++位置:%@", placeMark.name);
//                       NSLog(@"街道:%@", placeMark.thoroughfare);
//                       NSLog(@"子街道:%@", placeMark.subThoroughfare);
//                       NSLog(@"市:%@", placeMark.locality);
//                       NSLog(@"区\\县:%@", placeMark.subLocality);
//                       NSLog(@"行政区:%@", placeMark.administrativeArea);
//                       NSLog(@"国家:%@", placeMark.country);
//                   }
            
            if (self.placeMark == nil) {
                self.placeMark = @"未知";
            }
        }];
//    }
    // 停止更新位置
    [self.locaationManager stopUpdatingLocation];
}
// 代理方法，错误处理
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
    // 如果管理器未能获取位置，可能是GPS或者网络信号不可用等情况，这时候不要再继续消耗性能
    // 停止更新位置
    [self.locaationManager stopUpdatingLocation];
}




- (void)setRegisterUIView:(UIView *)superview andTitle:(NSString *)title{
    
    UIView * view = [[UIView alloc]init];
    view.frame = CGRectMake(34,120,48,34);
    [superview addSubview:view];
    
    UIView * view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(4,21,40,8);
    view1.layer.backgroundColor = [UIColor colorWithRed:252/255.0 green:200/255.0 blue:40/255.0 alpha:1.0].CGColor;
    view1.layer.cornerRadius = 4;
    [view addSubview:view1];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,0,48,34);
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"PingFangSC" size:24];
    label.numberOfLines = 0;
    [view addSubview:label];
    label.alpha = 1.0;
}


//FIXME:UITableviewDatagete和UITablevieDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CELLID = @"CELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CELLID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableview deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0;
}

//FIXME:UICollectionViewDelegate
//有多少的分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

//每个分组里有多少个item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //根据identifier从缓冲池里去出cell
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"COLLECTIONVIEWID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}


//FIXME:去掉空格
- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

//公司名称
- (BOOL)isContrainChineseStr:(NSString *)company
{
    NSString *regex = @"^[\u4e00-\u9fa5]{0,19}$";
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate1 evaluateWithObject:company];
}

- (BOOL)isEnglishAndChinese:(NSString *)textf{
    //@"^[\u4e00-\u9fa5a-zA-Z]*$" [a-zA-Z\u4e00-\u9fa5]+
    NSString *regex = @"^[a-zA-Z\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:textf];
}

-(BOOL)istext:(UITextField *)textf
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if (textf.text.length<=0||textf.text==nil||[textf.text isEqualToString:@""]||[textf.text isKindOfClass:[NSNull class]]||[[textf.text stringByTrimmingCharactersInSet:set]length]==0)
    {
        return YES;
    }
    else{
        return NO;
    }
}

-(BOOL)isnstring:(NSString *)textf;
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    if (textf.length<=0||textf==nil||[textf isEqualToString:@""]||[textf isKindOfClass:[NSNull class]]||[[textf stringByTrimmingCharactersInSet:set]length]==0)
    {
        return YES;
    }
    else
        return NO;
}
//密码验证
- (BOOL)isValidPassword:(NSString *)pwd {
    //以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~18
    NSString *regex = @"^(""[a-zA-Z]|[0-9]){6,20}$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:pwd];
}
//手机号验证
- (BOOL)isTrueMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^1(3|5|7|8|4)\\d{9}";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:mobile];
    // NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSString * MOBILE = @"^((13[0-9])|(15[^4])|(18[0,1,2,3,5-9])|(17[0-8])|(19[8,9])|(166)|(147))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobile];
}
/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL) validateCarNo:(NSString*) carNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    //NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}
/**密码设置有大小写字母和数字*/
- (BOOL)validatePassword:(NSString *)passWord
{
    //NSString *passWordRegex = @"^[a-zA-Z0-9]{6,18}+$";
    //NSString * passWordRegex = @"[0-9a-zA-Z\u4e00-\u9fa5\\.\\*\\)\\(\\+\\$\\[\\?\\\\\\^\\{\\|\\]\\}%%%@\'\",。‘、-【】·！_——=:;；<>《》‘’“”!#~]+";
    NSString *passWordRegex = @"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}
/* 身份证
 *
 *
 */
-(BOOL)checkUserID:(NSString *)userID
{
    //长度不为18的都排除掉
    if (userID.length!=18) {
        return NO;
    }
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            idCardWiSum+= subStrIndex * idCardWiIndex;
        }
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
}
/**
 *  判断名称是否合法
 *  @param name 名称
 *  @return yes / no
 */
-(BOOL)isNameValid:(NSString *)name
{
    BOOL isValid = NO;
    if (name.length > 0)
    {
        for (NSInteger i=0; i<name.length; i++)
        {
            unichar chr = [name characterAtIndex:i];
            if (chr < 0x80)
            { //字符
                if (chr >= 'a' && chr <= 'z')
                {
                    isValid = YES;
                }
                else if (chr >= 'A' && chr <= 'Z')
                {
                    isValid = YES;
                }
                else if (chr >= '0' && chr <= '9')
                {
                    isValid = YES;
                }
                else if (chr == '-' || chr == '_')
                {
                    isValid = YES;
                }
                else
                {
                    isValid = NO;
                }
            }
            else if (chr >= 0x4e00 && chr < 0x9fa5)
            { //中文
                isValid = YES;
            }
            else
            { //无效字符
                isValid = NO;
            }
            if (!isValid)
            {
                break;
            }
        }
    }
    return isValid;
}
// 昵称
- (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

- (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{2,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal string:(NSString *)str;
{
    NSString *hanzi = containChinese ? @"\\u4e00-\\u9fa5" : @"";
    NSString *first = firstCannotBeDigtal ? @"^[a-zA-Z_]" : @"";
    NSString *lengthRegex = [NSString stringWithFormat:@"(?=^.{%@,%@}$)", @(minLenth), @(maxLenth)];
    NSString *digtalRegex = containDigtal ? @"(?=(.*\\\\d.*){1})" : @"";
    NSString *letterRegex = containLetter ? @"(?=(.*[a-zA-Z].*){1})" : @"";
    NSString *characterRegex = [NSString stringWithFormat:@"(?:%@[%@A-Za-z0-9%@]+)", first, hanzi, containOtherCharacter ? containOtherCharacter : @""];
    NSString *regex = [NSString stringWithFormat:@"%@%@%@%@", lengthRegex, digtalRegex, letterRegex, characterRegex];
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [phoneTest evaluateWithObject:str];
}


//根据金额内容进行判断，如果是只有整数位，就显示整数金额，如果是有小数位，就取小数位后两位，小数点后若为0则去掉不显示
-(NSString *)cutStr:(double)pNum
{
    NSString *res=[NSString stringWithFormat:@"%.2f",pNum];
    if(([res intValue]-pNum)==0.0)
    {
        res=[NSString stringWithFormat:@"%d",(int)pNum];
    }
    return res;
}

- (BOOL)isPureNumandCharacters:(NSString *)string
{
    if(string.length!=6)
    {
        return NO;
    }
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

- (BOOL) deptNumInputShouldNumber:(NSString *)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}





//获取当前系统时间的时间戳
#pragma mark - 获取当前时间的 时间戳
- (NSInteger)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    //NSLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];
    //NSLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}



//将某个时间转化成 时间戳
#pragma mark - 将某个时间转化成 时间戳
- (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    //NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}


//获取文件的大小
-(float)sizeOfDirectory:(NSString *)dir{
    NSDirectoryEnumerator *direnum = [[NSFileManager defaultManager] enumeratorAtPath:dir];
    NSString *pname;
    int64_t s=0;
    while (pname = [direnum nextObject]){
        //NSLog(@"pname   %@",pname);
        NSDictionary *currentdict=[direnum fileAttributes];
        NSString *filesize=[NSString stringWithFormat:@"%@",[currentdict objectForKey:NSFileSize]];
        NSString *filetype=[currentdict objectForKey:NSFileType];
        
        if([filetype isEqualToString:NSFileTypeDirectory]) continue;
        s=s+[filesize longLongValue];
    }
    return s*1.0;
}


//根据路径删除文件
-(BOOL)deleteFileByPath:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL res=[fileManager removeItemAtPath:path error:nil];
    return res;
   // NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:path]?@"YES":@"NO");
}




- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
  //  [IQKeyboardManager sharedManager].enable = YES;
}

#pragma mark -- 将数组拆分成固定长度
 
/**
 *  将数组拆分成固定长度的子数组
 *
 *  @param array 需要拆分的数组
 *
 *  @param subSize 指定长度
 *
 */
- (NSArray *)splitArray: (NSArray *)array withSubSize : (int)subSize{
  //数组将被拆分成指定长度数组的个数
  unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
  //用来保存指定长度数组的可变数组对象
  NSMutableArray *arr = [[NSMutableArray alloc] init];
  //利用总个数进行循环，将指定长度的元素加入数组
  for (int i = 0; i < count; i ++) {
    //数组下标
    int index = i * subSize;
    //保存拆分的固定长度的数组元素的可变数组
    NSMutableArray *arr1 = [[NSMutableArray alloc] init];
    //移除子数组的所有元素
    [arr1 removeAllObjects];
    int j = index;
    //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
    while (j < subSize*(i + 1) && j < array.count) {
      [arr1 addObject:[array objectAtIndex:j]];
      j += 1;
    }
    //将子数组添加到保存子数组的数组中
    [arr addObject:[arr1 copy]];
  }
  return [arr copy];
}



//- (NSMutableArray *)changeArrayRule:(NSArray *)contentarray{
//    NSMutableArray *dateMutablearray = [NSMutableArray array];
//    NSMutableArray *array = [NSMutableArray arrayWithArray:contentarray];
//    for (int i = 0; i < array.count; i ++) {
//        //NSString *string = array[i];
//        RSMailModel * taobaoInventoryDetmodel = array[i];
//        NSMutableArray *tempArray = [NSMutableArray array];
//        [tempArray addObject:taobaoInventoryDetmodel];
//        for (int j = i+1;j < array.count; j ++) {
//            RSMailModel * taobaoInventoryDetmodel1 = array[j];
//            if([taobaoInventoryDetmodel1.department isEqualToString:taobaoInventoryDetmodel.department]){
//                [tempArray addObject:taobaoInventoryDetmodel1];
//                [array removeObjectAtIndex:j];
//                j = j - 1;
//            }
//        }
//        [dateMutablearray addObject:tempArray];
//    }
//    return dateMutablearray;
//}


//- (NSMutableArray *)changeNewArrayRule:(NSArray *)contentarray{
//    NSMutableArray *dateMutablearray = [NSMutableArray array];
//    NSMutableArray *array = [NSMutableArray arrayWithArray:contentarray];
//    for (int i = 0; i < array.count; i ++) {
//        //NSString *string = array[i];
//        RSSLPieceModel * slpiecemodel = array[i];
//        NSMutableArray *tempArray = [NSMutableArray array];
//        [tempArray addObject:slpiecemodel];
//        for (int j = i+1;j < array.count; j ++) {
//            RSSLPieceModel * slpiecemodel1 = array[j];
//            if([slpiecemodel1.turnsNo isEqualToString:slpiecemodel.turnsNo]){
//                [tempArray addObject:slpiecemodel1];
//                [array removeObjectAtIndex:j];
//                j = j - 1;
//            }
//        }
//        [dateMutablearray addObject:tempArray];
//    }
//    return dateMutablearray;
//}






//根据时间来获取星期几
- (NSString*)weekDayStr:(NSString*)format{
    NSString *weekDayStr = nil;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    if(format.length>=10) {
        NSString *nowString = [format substringToIndex:10];
        NSArray *array = [nowString componentsSeparatedByString:@"-"];
        if(array.count==0) {
            array = [nowString componentsSeparatedByString:@"/"];
        }
        if(array.count>=3) {
            NSInteger year = [[array objectAtIndex:0] integerValue];
            NSInteger month = [[array objectAtIndex:1] integerValue];
            NSInteger day = [[array objectAtIndex:2] integerValue];
            [comps setYear:year];
            [comps setMonth:month];
            [comps setDay:day];
        }
    }
    //日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //获取传入date
    NSDate *_date = [gregorian dateFromComponents:comps];
    NSDateComponents *weekdayComponents = [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger week = [weekdayComponents weekday];
    switch(week) {
        case 1:
            weekDayStr =@"星期日";
            break;
        case 2:
            weekDayStr =@"星期一";
            break;
        case 3:
            weekDayStr =@"星期二";
            break;
        case 4:
            weekDayStr =@"星期三";
            break;
        case 5:
            weekDayStr =@"星期四";
            break;
        case 6:
            weekDayStr =@"星期五";
            break;
        case 7:
            weekDayStr =@"星期六";
            break;
        default:
            weekDayStr =@"";
            break;
    }
    return weekDayStr;
}

-(NSString *)UIImageToBase64Str:(UIImage *) image
{
NSData *data = UIImageJPEGRepresentation(image, 1.0f);
NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
return encodedImageStr;
}


- (NSString *)fileToToBase64Data:(NSData *)data{
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    return encodedImageStr;
}


- (NSString *)typeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @".jpeg";
        case 0x89:
            return @".png";
        case 0x47:
            return @".gif";
        case 0x49:
        case 0x4D:
            return @".tiff";
    }
    return nil;
}


//判断文件是否已经在沙盒中存在
-(BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

- (NSString *)dataChangString{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

- (void)showDisplayTheTimeToSelectTime:(UIButton *)firstTimeBtn andSecondTime:(UIButton *)secondTimeBtn{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitMonth fromDate:currentDate];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:0];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:currentDate options:0];
    NSString *beforDate = [dateFormatter stringFromDate:newdate];
    NSString * newBefordate = [beforDate substringToIndex:8];
    newBefordate = [NSString stringWithFormat:@"%@01",newBefordate];
    [firstTimeBtn setTitle:newBefordate forState:UIControlStateNormal];
    [secondTimeBtn setTitle:currentDateString forState:UIControlStateNormal];
}

-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

 /**
  *  自适应字体
  */
 -(CGSize)sizeWithString:(NSString*)string font:(UIFont*)font width:(float)width{
   CGRect rect = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading    |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
   return rect.size;
}


//短信按键
- (void)messageTimeUbutton:(UIButton *)sender{
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
                sender.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [sender setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0] forState:0];
                //To do
                [UIView commitAnimations];
                sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (UIViewController*)backViewController{
    NSInteger myIndex = [self.navigationController.viewControllers indexOfObject:self];
    if( myIndex !=0 && myIndex != NSNotFound) {
        return [self.navigationController.viewControllers objectAtIndex:myIndex-1];
    }else{
        return nil;
    }
}


- (NSString *)encryptAESDataKey:(NSString *)key{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * aes = [user objectForKey:@"AES"];
    NSString * const kInitVector = @"16-Bytes--String";
    NSString * aes2 = [FSAES128 encryptAES:key key:aes andKInItVector:kInitVector];
    return aes2;
}


- (NSString *)getDeviceName {
    // 需要
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    return deviceString;
}



@end
