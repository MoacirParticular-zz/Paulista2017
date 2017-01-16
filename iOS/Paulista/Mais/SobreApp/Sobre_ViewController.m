//
//  sobreApp_ViewController.m
//
//  Created by Moacir Ezequiel Lamego on 27/10/12.
//  Copyright (c) 2012 br.com.mobilesapp. All rights reserved.
//

#import "sobre_ViewController.h"

@interface sobre_ViewController ()

@end

@implementation sobre_ViewController
@synthesize meuWebView, conteudo;


- (IBAction) Iniciar: (id)sender _pathForResource:(NSString*) _pathForResource _ofType:(NSString*) _ofType {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:_pathForResource ofType:_ofType];
    conteudo = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSMutableURLRequest* teste = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.mobilesapp.com.br/"]];
    
    if ([request.URL isEqual:teste.URL]) {
        NSString* launchUrl = @"http://www.mobilesapp.com.br/";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: launchUrl]];
        return NO;
    }
    return YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [meuWebView loadHTMLString:conteudo baseURL:nil];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) voltar:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
