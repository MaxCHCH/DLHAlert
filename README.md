
# DLHAlert
自定义alert 模仿微信弹框
使用方法
下载项目 DLHAlert 到项目中 引入头文件#import "DLHAlert.h"

在需要弹框的地方 输入代码

DLHAlert *alert =  [[DLHAlert alloc] initWithTitle:@"开启定位设置" leftBtnString:@"设置" contentString:@"未开启GPS,无法为您正常派单，请将GPS开启" rightBtnString:nil handler:^(DLHAlert *alert, NSInteger index) {
NSLog(@"%ld",index);
}];

[alert show];

非常简单 容易修改 自定义

![image](https://github.com/duanlihang/DLHAlert/blob/master/81750CDE-C6FF-456C-85D2-9335B25B8118.png)
![image](https://github.com/duanlihang/DLHAlert/blob/master/BA046E60-994D-40D3-8533-1854E3CB50DD.png)
