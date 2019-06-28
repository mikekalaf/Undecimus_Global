//
//  CreditsTableViewController.m
//  Undecimus
//
//  Created by Pwn20wnd on 9/14/18.
//  Copyright © 2018 - 2019 Pwn20wnd. All rights reserved.
//

#import "CreditsTableViewController.h"

@interface CreditsTableViewController ()

@end

@implementation CreditsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(darkModeCreditsView:) name:NSLocalizedString(@"darkModeCredits", nil) object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lightModeCreditsView:) name:NSLocalizedString(@"lightModeCredits", nil) object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) darkModeCreditsView:(NSNotification *) notification  {
    
    [self.ianBeerButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.bazadButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.morpheusButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.xerubButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.psychoTeaButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.stekButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.ninjaPrawnButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.crypticButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.xerusDesignButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.appleDryButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.robButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.midnightChipButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.geoSn0wButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.swaggoButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.jailbreakbusterButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.jakeashacksButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.saurikButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.siguzaButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.externalistButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.realBrightiupButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.nitoTVButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.matchsticButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.umanghereButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.miscMistyButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.benButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.samGButton setTitleColor:[UIColor whiteColor] forState:normal];
    [self.dennisButton setTitleColor:[UIColor whiteColor] forState:normal];
}

-(void) lightModeCreditsView:(NSNotification *) notification  {
    
    [self.ianBeerButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.bazadButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.morpheusButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.xerubButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.psychoTeaButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.stekButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.ninjaPrawnButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.crypticButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.xerusDesignButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.appleDryButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.robButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.midnightChipButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.geoSn0wButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.swaggoButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.jailbreakbusterButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.jakeashacksButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.saurikButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.siguzaButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.externalistButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.realBrightiupButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.nitoTVButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.matchsticButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.umanghereButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.miscMistyButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.benButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.samGButton setTitleColor:[UIColor blackColor] forState:normal];
    [self.dennisButton setTitleColor:[UIColor blackColor] forState:normal];
}

+ (NSURL *)getURLForUserName:(NSString *)userName {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot://"]]) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"tweetbot:///user_profile/%@", userName]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific://"]]) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"twitterrific:///profile?screen_name=%@", userName]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings://"]]) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"tweetings:///user?screen_name=%@", userName]];
    } else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://"]]) {
        return [NSURL URLWithString:[NSString stringWithFormat:@"https://mobile.twitter.com/%@", userName]];
    } else {
        return [NSURL URLWithString:[NSString stringWithFormat:@"https://mobile.twitter.com/%@", userName]];
    }
}

-(IBAction)tappedOnIanBeer:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"i41nbeer", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnBazad:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"_bazad", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnMorpheus:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:@"Morpheus______"] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnXerub:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"xerub", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnPsychoTea:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"ibsparkes", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnStek:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"stek29", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnNinjaPrawn:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"theninjaprawn", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnCryptic:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"Cryptiiiic", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnXerusDesign:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"xerusdesign", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnAppleDry:(id)sender{
   [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"AppleDry05", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnRob:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"AyyItzRob", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnMidnightChip:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"MidnightChip", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnGeoSn0w:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"FCE365", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnSwaggo:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:@"Swag_iOS"] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnJailbreakbuster:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"jailbreakbuster", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnJakeashacks:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"Jakeashacks", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnSaurik:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"saurik", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnSiguza:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"s1guza", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnExternalist:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"Externalist", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnRealBrightiup:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"realBrightiup", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnNitoTV:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"nitoTV", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnMatchstic:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"_Matchstic", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnUmanghere:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"umanghere", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnMiscMisty:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"MiscMisty", nil)] options:@{} completionHandler:nil];
}

-(IBAction)tappedOnBen:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"benjweaverdev", nil)] options:@{} completionHandler:nil];
}

- (IBAction)tappedOnSamG:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://reddit.com/u/Samg_is_a_Ninja"] options:@{} completionHandler:nil];
}

- (IBAction)tappedOnDennis:(id)sender{
    [[UIApplication sharedApplication] openURL:[CreditsTableViewController getURLForUserName:NSLocalizedString(@"DennisBednarz", nil)] options:@{} completionHandler:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
