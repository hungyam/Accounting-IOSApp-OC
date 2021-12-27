//
//  ModifyMes.m
//  finalhw
//
//  Created by hungyam on 2021/12/6.
//

#import "ModifyMes.h"
#import "PersonalVC.h"
#define BackColor [UIColor colorWithRed:242/255.0 green:242/255.0 blue:247/255.0 alpha:1]
#define MainColor [UIColor colorWithRed:244/255.0 green:92/255.0 blue:99/255.0 alpha:1]
#define Wper *self.view.bounds.size.width/100
#define Hper *self.view.bounds.size.height/100

@interface ModifyMes (){
    NSString *nickname;
    UIImage *userImg;
    NSString *username;
    NSString *phone;
}

@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UITextView *nicknameText;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UITextView *usernameText;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UITextView *phoneText;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIButton *addpicButton;

@end

@implementation ModifyMes


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUserMes];
    self.view.backgroundColor = BackColor;
    self.navigationController.navigationBar.tintColor = MainColor;
    [self.view addSubview: self.addpicButton];
    [self.view addSubview: self.nicknameText];
    [self.view addSubview: self.usernameText];
    [self.view addSubview: self.phoneText];
}

- (void)loadUserMes {
    PersonalMes *mes = [DataManage getPersonalMes];
    nickname = mes.nickname;
    userImg = mes.userImg;
    username = mes.username;
    phone=mes.phone;
}

- (UIButton *)addpicButton {
    if (_addpicButton == nil) {
        _addpicButton = [[UIButton alloc] initWithFrame:CGRectMake(36 Wper, 20 Hper, 28 Wper, 28 Wper)];
        _addpicButton.layer.cornerRadius = 14 Wper;
        _addpicButton.layer.masksToBounds = YES;
        _addpicButton.backgroundColor = [UIColor orangeColor];
        [_addpicButton setImage:userImg forState:UIControlStateNormal];
        [_addpicButton addTarget:self action:@selector(get_pic:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addpicButton;
}

-(void)get_pic:(UIButton *) sender{
    UIImagePickerController *pickerCtr = [[UIImagePickerController alloc] init];
        pickerCtr.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerCtr.delegate = self;
    [self presentViewController: pickerCtr animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    userImg=img;
    [_addpicButton setImage:userImg forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (UILabel *)nicknameLabel {
    if (_nicknameLabel == nil) {
        _nicknameLabel = [[UILabel alloc]initWithFrame:CGRectMake(8 Wper, 35 Hper, 150, 30)];
        _nicknameLabel.text = @"昵称";
        _nicknameLabel.textColor = MainColor;
    }
    return _nicknameLabel;
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
        _nicknameText.text=nickname;
    }
    return _nicknameText;
}

- (UILabel *)usernameLabel {
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(8 Wper, 43 Hper, 150, 30)];
        _usernameLabel.text = @"用户名";
        _usernameLabel.textColor = MainColor;
    }
    return _usernameLabel;
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
        _usernameText.text=username;
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
        _phoneText.text=phone;
    }
    return _phoneText;
}

- (UIButton *)submitButton {
    if (_submitButton == nil) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(10 Wper, 80 Hper, 80 Wper, 55)];
        _submitButton.backgroundColor = MainColor;
        _submitButton.layer.cornerRadius = 10;
        [_submitButton setTitle:@"注册" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchDown];
    }
    return _submitButton;
}
-(void)submitAction {
    [self reset];
}
-(void)reset{
    [_addpicButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    self.nicknameText.text=@"";
    self.usernameText.text=@"";
    //self.phoneText.text=@"";
}
@end
