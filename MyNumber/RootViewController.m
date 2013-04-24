//
//  RootViewController.m
//  MyNumber
//
//  Created by XmL on 13-4-24.
//  Copyright (c) 2013年 XmL. All rights reserved.
//

#import "RootViewController.h"
#import "ASIHTTPRequest.h"
#define CURRENTVERSION  @"1.1"


@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
int my_strcmp(const char *s1,const char *s2){
    while((*s2 == *s1)&& *s2)
    {
        s1++;
        s2++;
    }
    return *s1-*s2;
    
}
char* getoutpoint(char* s)
{
    int i, j,len = strlen(s);
    char* out =malloc(len);
    for(i=0,j=0; i<len;i++)
    {
        if(*(s+i)!='.')
        {
            out[j]= *(s+i);
            
            j++;
            
        }
    }
    out[j] = '\0';
    return out;
}
char* getlf(char* s)
{
    int i, j,len = strlen(s);
    char* out =malloc(len);
    for(i=0,j=0; i<len;i++)
    {
        if(*(s+i)!='\n')
        {
            out[j]= *(s+i);
            
            j++;
            
        }
    }
    out[j] = '\0';
    return out;
}


-(void)requestFinished:(ASIHTTPRequest *)request
{
   NSLog(@"%@",[request responseString]);
    
    [self parseNewStringJson:[request responseString]];
    

}

-(void)requestFailed:(ASIHTTPRequest *)request
{

    NSLog(@"error");
}


-(void)httpNext:(UIButton * )btn
{

    NSLog(@"httpNext");
    
    //http://itunes.apple.com/lookup?id=599247522&country=cn
    
    NSString * sUrl  = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=639989010&country=cn"];
    NSURL *  url = [NSURL URLWithString:sUrl];
    
    ASIHTTPRequest * rquest = [ASIHTTPRequest requestWithURL:url];
    [rquest setTag:1000];
    rquest.delegate = self;
    [rquest startAsynchronous];


}

-(void)parseNewStringJson:(NSString*)res
{
    char* responschar = (char*)[res UTF8String];
    char*nlf = getlf(responschar);
    char* point1 = getoutpoint(responschar);
    char* lf = getlf(point1);
    char *aaa = (char*)[CURRENTVERSION UTF8String];
    char* point2 = getoutpoint(aaa);
    
    res = [NSString stringWithFormat:@"%s",nlf];
    int returnJudge = my_strcmp(lf,point2);
    NSLog(@"%d",returnJudge);
    NSLog(@"%@",res);
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(120, 200, 80, 40);
    [button setTitle:@"下载" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(httpNext:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
