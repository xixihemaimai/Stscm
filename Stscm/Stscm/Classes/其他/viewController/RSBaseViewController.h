//
//  RSBaseViewController.h
//  OAManage
//
//  Created by mac on 2018/11/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sys/utsname.h"

typedef enum InputEnum {
    phoneType = 0,
    passwordType = 1,
}inputEnum;

typedef void(^CustomBlock)(NSInteger pageNum);

@interface RSBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate>

/**uicollectionview*/
@property (nonatomic,strong)UICollectionView * collectionview;
/**UItableview*/
@property (nonatomic,strong)UITableView * tableview;
/**没有数据显示的界面*/
@property (nonatomic,strong)ZZQEmptyView * emptyView;
/**刷新片数*/
@property (nonatomic,assign)NSInteger pageNum;
/**上拉和下拉进行的返回pageNum*/
@property (nonatomic,strong)CustomBlock customBlock;

/**地址*/
@property (nonatomic,strong)NSString * placeMark;

/**去掉空格*/
- (NSString *)delSpaceAndNewline:(NSString *)string;

-(BOOL)istext:(UITextField *)textf;

-(BOOL)isnstring:(NSString *)textf;
/**密码验证*/
- (BOOL)isValidPassword:(NSString *)pwd;
/**手机号验证*/
-(BOOL)isTrueMobile:(NSString *)mobile;
/**6位数字密码*/
- (BOOL)isPureNumandCharacters:(NSString *)string;
/**数字验证*/
- (BOOL) deptNumInputShouldNumber:(NSString *)str;
/**判断中文*/
- (BOOL)isContrainChineseStr:(NSString *)company;
/**昵称*/
- (BOOL) validateNickname:(NSString *)nickname;
/**用户名验证*/
- (BOOL) validateUserName:(NSString *)name;
/**用户名验证 失效*/
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal string:(NSString *)str;
/**根据金额内容进行判断，如果是只有整数位，就显示整数金额，如果是有小数位，就取小数位后两位，小数点后若为0则去掉不显示*/
-(NSString *)cutStr:(double)pNum;
/**密码设置成有字母和数字*/
- (BOOL) validatePassword:(NSString *)passWord;
/**
 *  判断名称是否合法
 *  @param name 名称
 *  @return yes / no
 */
-(BOOL)isNameValid:(NSString *)name;
/*
 * 身份证
 */
-(BOOL)checkUserID:(NSString *)userID;
/*车牌号验证 MODIFIED BY HELENSONG*/
- (BOOL) validateCarNo:(NSString*) carNo;
/**
 只能是中文和英文
 */
- (BOOL)isEnglishAndChinese:(NSString *)textf;
/**获取当前系统时间的时间戳*/
#pragma mark - 获取当前时间的 时间戳
-(NSInteger)getNowTimestamp;
/**将某个时间转化成 时间戳*/
#pragma mark - 将某个时间转化成 时间戳
-(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
/**获取文件的大小*/
-(float)sizeOfDirectory:(NSString *)dir;
/**根据路径删除文件*/
-(BOOL)deleteFileByPath:(NSString *)path;
/**对数组进行拆分的方法*/
- (NSArray *)splitArray: (NSArray *)array withSubSize : (int)subSize;
/**将不同的部门的数组进行数组的重组*/
//- (NSMutableArray *)changeArrayRule:(NSArray *)contentarray;

//- (NSMutableArray *)changeNewArrayRule:(NSArray *)contentarray;
/**根据时间来获取星期几*/
- (NSString*)weekDayStr:(NSString*)format;
/**图片转字符串*/
-(NSString *)UIImageToBase64Str:(UIImage *) image;
/**二进制转字符串*/
- (NSString *)fileToToBase64Data:(NSData *)data;
/**获取图片的格式*/
- (NSString *)typeForImageData:(NSData *)data;
/**判断文件是否已经在沙盒中存在*/
-(BOOL) isFileExist:(NSString *)fileName;
/**时间date转字符串*/
- (NSString *)dataChangString;
/**获取起始时间为每个月的1号，第二个为结束时间*/
- (void)showDisplayTheTimeToSelectTime:(UIButton *)firstTimeBtn andSecondTime:(UIButton *)secondTimeBtn;
/**获取时间*/
-(NSDate *)nsstringConversionNSDate:(NSString *)dateStr;
/**注册和登录需要的界面*/
- (void)setRegisterUIView:(UIView *)superview andTitle:(NSString *)title;
/**自适应字体*/
-(CGSize)sizeWithString:(NSString*)string font:(UIFont*)font width:(float)width;
/**短信按键*/
- (void)messageTimeUbutton:(UIButton *)sender;
/**获取当前导航控制器下前一个控制器*/
- (UIViewController*)backViewController;
/**获取设备型号*/
- (NSString *)getDeviceName;
/**这边是对网络请求参数进行加密的步骤*/
- (NSString *)encryptAESDataKey:(NSString *)key;

//通过64Base转换成图片
- (UIImage *)baseWith64EncodedString:(NSString *)baseEncode;
@end


