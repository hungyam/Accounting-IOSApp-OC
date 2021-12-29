//
//  ModifyMes.m
//  finalhw
//
//  Created by hungyam on 2021/12/6.
//

#import "ModifyMes.h"
#import "SettingVC.h"
#define BackColor [UIColor colorWithRed:242/255.0 green:242/255.0 blue:247/255.0 alpha:1]
#define MainColor [UIColor colorWithRed:244/255.0 green:92/255.0 blue:99/255.0 alpha:1]
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100

@interface ModifyMes (){
    NSString *nickname;
    UIImage *userImg;
    NSString *username;
    NSString *phone;
    NSInteger points;
    NSString *password;
    
}

@property (nonatomic, strong) UITextView *nicknameText;
@property (nonatomic, strong) UITextView *usernameText;
@property (nonatomic, strong) UITextView *phoneText;
@property (nonatomic, strong) UIButton *addpicButton;

@end

@implementation ModifyMes


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserMes];
    [self reset];
    self.view.backgroundColor = BackColor;
    self.navigationController.navigationBar.tintColor = MainColor;
    [self.view addSubview: self.addpicButton];
    [self.view addSubview: self.nicknameText];
    [self.view addSubview: self.usernameText];
    [self.view addSubview: self.phoneText];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"完成" forState:UIControlStateNormal];
    [btn setTitleColor:MainColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItems = @[item];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadUserMes];
    [self reset];
}

- (void)loadUserMes {
    PersonalMes *mes = [DataManage getPersonalMes];
    nickname = mes.nickname;
    userImg = mes.userImg;
    username = mes.username;
    points = mes.points;
    phone=mes.phone;
    password=mes.password;
}

-(void)reset{
    
    self.phoneText.text=phone;
    [self.addpicButton setImage:userImg forState:UIControlStateNormal];
    self.nicknameText.text=nickname;
    self.usernameText.text=username;
    [self.addpicButton setImage:userImg forState:UIControlStateNormal];
    self.phoneText.text=phone;
    self.nicknameText.text=nickname;
    self.usernameText.text=username;
    [self.addpicButton setImage:userImg forState:UIControlStateNormal];
    self.phoneText.text=phone;
    self.nicknameText.text=nickname;
    self.usernameText.text=username;
}

- (UIButton *)addpicButton {
    if (_addpicButton == nil) {
        _addpicButton = [[UIButton alloc] initWithFrame:CGRectMake(36 Wper, 20 Hper, 28 Wper, 28 Wper)];
        _addpicButton.layer.cornerRadius = 14 Wper;
        _addpicButton.layer.masksToBounds = YES;
        _addpicButton.backgroundColor = [UIColor orangeColor];
        [_addpicButton addTarget:self action:@selector(getPic:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addpicButton;
}
-(void)getPic:(UIButton *) sender{
    UIImagePickerController *pickerCtr = [[UIImagePickerController alloc] init];
    pickerCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerCtr.delegate = self;
    [self presentViewController: pickerCtr animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    userImg=[info objectForKey:UIImagePickerControllerOriginalImage];
    [_addpicButton setImage:userImg forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (UITextView *)nicknameText {
    if (_nicknameText == nil) {
        _nicknameText = [[UITextView alloc]initWithFrame:CGRectMake(10 Wper, 40 Hper - 15, 80 Wper, 40)];
        _nicknameText.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];
        _nicknameText.backgroundColor = [UIColor whiteColor];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _nicknameText.frame.size.height - 1, _nicknameText.frame.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _nicknameText.backgroundColor = [UIColor clearColor];
        [_nicknameText.layer addSublayer:layer];
        [_nicknameText setScrollEnabled:NO];
    }
    return _nicknameText;
}



- (UITextView *)usernameText {
    if (_usernameText == nil) {
        _usernameText = [[UITextView alloc]initWithFrame:CGRectMake(10 Wper, 48 Hper - 15, 80 Wper, 40)];
        _usernameText.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];

        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _usernameText.frame.size.height - 1, _usernameText.frame.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _usernameText.backgroundColor = [UIColor clearColor];
        [_usernameText.layer addSublayer:layer];
        [_usernameText setScrollEnabled:NO];
    }
    return _usernameText;
}



- (UITextView *)phoneText {
    if (_phoneText == nil) {
        _phoneText = [[UITextView alloc]initWithFrame:CGRectMake(10 Wper, 56 Hper - 15, 80 Wper, 40)];
        _phoneText.font = [UIFont systemFontOfSize:23 weight:UIFontWeightMedium];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, _usernameText.frame.size.height - 1, _usernameText.frame.size.width, 1);
        layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1].CGColor;
        _phoneText.backgroundColor = [UIColor clearColor];
        [_phoneText.layer addSublayer:layer];
        [_phoneText setScrollEnabled:NO];
    }
    return _phoneText;
}

-(void)submitAction {
    PersonalMes *modifyMes = [[PersonalMes alloc]initWithNickname:self.nicknameText.text userImg:userImg username:self.usernameText.text points:points password:password phone:self.phoneText.text];
    Boolean suc=[DataManage modifyPersonalMes:modifyMes];
    if(suc){
        [(SettingVC *)self.parentViewController resetpre];
        [(SettingVC *)self.parentViewController poptosettingview];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"修改失败-用户名已被使用" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
