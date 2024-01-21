//
//  AppIntent.swift
//  Dots 365 Widget
//
//  Created by Ray on 1/20/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "365 DOts"
    static var description = IntentDescription("Year Progress Widget")

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "😃")
    var favoriteEmoji: String
    
//    @Parameter(title: "Theme Color", default: "😃")
//    var themeColor: ShortcutTileColor
}
