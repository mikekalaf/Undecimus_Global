//
//  diagnostics.c
//  Undecimus
//
//  Created by Pwn20wnd on 5/3/19.
//  Copyright © 2019 Pwn20wnd. All rights reserved.
//

#include "diagnostics.h"
#include <common.h>
#include <sys/utsname.h>
#include <sys/sysctl.h>
#include "utils.h"
#include "prefs.h"

#if 0
Credits:
- https://github.com/lechium/nitoTV/blob/53cca06514e79279fa89639ad05b562f7d730079/Classes/packageManagement.m#L1138
- https://github.com/lechium/nitoTV/blob/53cca06514e79279fa89639ad05b562f7d730079/Classes/packageManagement.m#L1163
- https://github.com/lechium/nitoTV/blob/53cca06514e79279fa89639ad05b562f7d730079/Classes/packageManagement.m#L854
- https://github.com/lechium/nitoTV/blob/53cca06514e79279fa89639ad05b562f7d730079/Classes/packageManagement.m#L869
#endif

NSArray *dependencyArrayFromString(NSString *depends) {
    NSMutableArray *cleanArray = [NSMutableArray new];
    NSArray *dependsArray = [depends componentsSeparatedByString:@","];
    for (NSString *depend in dependsArray) {
        NSArray *spaceDelimitedArray = [depend componentsSeparatedByString:@" "];
        NSString *isolatedDependency = [[spaceDelimitedArray objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([isolatedDependency length] == 0) {
            isolatedDependency = [[spaceDelimitedArray objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        }
        [cleanArray addObject:isolatedDependency];
    }
    return cleanArray;
}

NSArray *parsedPackageArray() {
    NSString *packageString = [NSString stringWithContentsOfFile:STATUS_FILE encoding:NSUTF8StringEncoding error:nil];
    NSArray *lineArray = [packageString componentsSeparatedByString:@"\n\n"];
    NSMutableArray *mutableList = [[NSMutableArray alloc] init];
    for (NSString *currentItem in lineArray) {
        NSArray *packageArray = [currentItem componentsSeparatedByString:NSLocalizedString(@"\n", nil)];
        NSMutableDictionary *currentPackage = [[NSMutableDictionary alloc] init];
        for (NSString *currentLine in packageArray) {
            NSArray *itemArray = [currentLine componentsSeparatedByString:@": "];
            if ([itemArray count] >= 2) {
                NSString *key = [itemArray objectAtIndex:0];
                NSString *object = [itemArray objectAtIndex:1];
                if ([key isEqualToString:NSLocalizedString(@"Depends", nil)]) {
                    NSArray *dependsObject = dependencyArrayFromString(object);
                    [currentPackage setObject:dependsObject forKey:key];
                } else {
                    [currentPackage setObject:object forKey:key];
                }
            }
        }
        if ([[currentPackage allKeys] count] > 4) {
            [mutableList addObject:currentPackage];
        }
        currentPackage = nil;
    }
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:NSLocalizedString(@"Name", nil) ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSSortDescriptor *packageDescriptor = [[NSSortDescriptor alloc] initWithKey:NSLocalizedString(@"Package", nil) ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:nameDescriptor, packageDescriptor, nil];
    NSArray *sortedArray = [mutableList sortedArrayUsingDescriptors:descriptors];
    mutableList = nil;
    return sortedArray;
}

NSString *domainFromRepoObject(NSString *repoObject) {
    if ([repoObject length] == 0) return nil;
    NSArray *sourceObjectArray = [repoObject componentsSeparatedByString:@" "];
    NSString *url = [sourceObjectArray objectAtIndex:1];
    if ([url length] > 7) {
        NSString *urlClean = [url substringFromIndex:7];
        NSArray *secondArray = [urlClean componentsSeparatedByString:@"/"];
        return [secondArray objectAtIndex:0];
    }
    return nil;
}

NSArray *sourcesFromFile(NSString *theSourceFile) {
    NSMutableArray *finalArray = [NSMutableArray new];
    NSString *sourceString = [[NSString stringWithContentsOfFile:theSourceFile encoding:NSASCIIStringEncoding error:nil] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray *sourceFullArray =  [sourceString componentsSeparatedByString:NSLocalizedString(@"\n", nil)];
    NSEnumerator *sourceEnum = [sourceFullArray objectEnumerator];
    NSString *currentSource = nil;
    while (currentSource = [sourceEnum nextObject]) {
        NSString *theObject = domainFromRepoObject(currentSource);
        if (theObject != nil) {
            if (![finalArray containsObject:theObject])
                [finalArray addObject:theObject];
        }
    }
    return finalArray;
}

NSDictionary *getDiagnostics() {
    NSMutableDictionary *diagnostics = [NSMutableDictionary new];
    char *OSVersion = getOSVersion();
    assert(OSVersion != NULL);
    char *OSProductVersion = getOSProductVersion();
    assert(OSProductVersion != NULL);
    char *kernelVersion = getKernelVersion();
    assert(kernelVersion != NULL);
    char *machineName = getMachineName();
    assert(machineName != NULL);
    prefs_t *prefs = copy_prefs();
    diagnostics[NSLocalizedString(@"OSVersion", nil)] = [NSString stringWithUTF8String:OSVersion];
    diagnostics[NSLocalizedString(@"OSProductVersion", nil)] = [NSString stringWithUTF8String:OSProductVersion];
    diagnostics[NSLocalizedString(@"KernelVersion", nil)] = [NSString stringWithUTF8String:kernelVersion];
    diagnostics[NSLocalizedString(@"MachineName", nil)] = [NSString stringWithUTF8String:machineName];
    diagnostics[NSLocalizedString(@"Preferences", nil)] = [NSMutableDictionary new];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_TWEAK_INJECTION] = [NSNumber numberWithBool:(BOOL)prefs->load_tweaks];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_LOAD_DAEMONS] = [NSNumber numberWithBool:(BOOL)prefs->load_daemons];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_DUMP_APTICKET] = [NSNumber numberWithBool:(BOOL)prefs->dump_apticket];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_REFRESH_ICON_CACHE] = [NSNumber numberWithBool:(BOOL)prefs->run_uicache];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_BOOT_NONCE] = [NSString stringWithUTF8String:(const char *)prefs->boot_nonce];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_DISABLE_AUTO_UPDATES] = [NSNumber numberWithBool:(BOOL)prefs->disable_auto_updates];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_DISABLE_APP_REVOKES] = [NSNumber numberWithBool:(BOOL)prefs->disable_app_revokes];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_OVERWRITE_BOOT_NONCE] = [NSNumber numberWithBool:(BOOL)prefs->overwrite_boot_nonce];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_EXPORT_KERNEL_TASK_PORT] = [NSNumber numberWithBool:(BOOL)prefs->export_kernel_task_port];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_RESTORE_ROOTFS] = [NSNumber numberWithBool:(BOOL)prefs->restore_rootfs];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_INCREASE_MEMORY_LIMIT] = [NSNumber numberWithBool:(BOOL)prefs->increase_memory_limit];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_ECID] = [NSString stringWithUTF8String:(const char *)prefs->ecid];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_INSTALL_CYDIA] = [NSNumber numberWithBool:(BOOL)prefs->install_cydia];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_INSTALL_OPENSSH] = [NSNumber numberWithBool:(BOOL)prefs->install_openssh];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_RELOAD_SYSTEM_DAEMONS] = [NSNumber numberWithBool:(BOOL)prefs->reload_system_daemons];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_RESET_CYDIA_CACHE] = [NSNumber numberWithBool:(BOOL)prefs->reset_cydia_cache];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_SSH_ONLY] = [NSNumber numberWithBool:(BOOL)prefs->ssh_only];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_ENABLE_GET_TASK_ALLOW] = [NSNumber numberWithBool:(BOOL)prefs->enable_get_task_allow];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_SET_CS_DEBUGGED] = [NSNumber numberWithBool:(BOOL)prefs->set_cs_debugged];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_HIDE_LOG_WINDOW] = [NSNumber numberWithBool:(BOOL)prefs->hide_log_window];
    diagnostics[NSLocalizedString(@"Preferences", nil)][@K_EXPLOIT] = [NSNumber numberWithInt:(int)prefs->exploit];
    diagnostics[NSLocalizedString(@"AppVersion", nil)] = [NSString stringWithString:appVersion()];
    diagnostics[NSLocalizedString(@"LogFile", nil)] = [NSString stringWithContentsOfFile:getLogFile() encoding:NSUTF8StringEncoding error:nil];
    diagnostics[NSLocalizedString(@"Sources", nil)] = [NSArray arrayWithArray:sourcesFromFile(CYDIA_LIST)];
    diagnostics[NSLocalizedString(@"Packages", nil)] = [NSArray arrayWithArray:parsedPackageArray()];
    diagnostics[NSLocalizedString(@"Uptime", nil)] = [NSNumber numberWithDouble:getUptime()];
    SafeFreeNULL(OSVersion);
    SafeFreeNULL(OSProductVersion);
    SafeFreeNULL(kernelVersion);
    SafeFreeNULL(machineName);
    release_prefs(&prefs);
    return diagnostics;
}
