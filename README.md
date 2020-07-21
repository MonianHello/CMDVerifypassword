# CMDVerifypassword

MonianHello 

花里胡哨的在批处理中验证密码
唯一的好处是避免了批处理中出现明文密码
~~这个代码的简便写法:（大雾）
    `if %password% == 114514`~~

大致思路：

 1. 输入
 2. 计算`MD5`(会在`C:`下创建`MonianHelloVerifypassword`文件夹)
 3. 对计算出的`MD5`进行`base64`
 4. 与存储在代码中的`base64`进行比对


默认密码为`114514`
## Todo:
改变29行中对MD5的处理方式

## Bug:
使用`MD5`后首位是**C**的密码会出现错误
