extension DS.Theme {
    public static let standard = DS.Theme(
        id: "standard",
        semanticTokens: SemanticTokens(
            colors: SemanticTokens.Colors(
                background: SemanticTokens.Colors.Background(
                    page: AdaptiveColor(light: .gray100, dark: .gray11),
                    surface: AdaptiveColor(light: .slate97, dark: .slate17),
                    surfaceRaised: AdaptiveColor(light: .slate93, dark: .slate22),
                    brand: AdaptiveColor(.accent),
                    brandSubtle: AdaptiveColor(
                        light: AdaptiveColor.Alias(.accent, opacity: .opacity15),
                        dark: AdaptiveColor.Alias(.accent, opacity: .opacity20),
                        increasedLight: AdaptiveColor.Alias(.accent, opacity: .opacity20),
                        increasedDark: AdaptiveColor.Alias(.accent, opacity: .opacity30)
                    ),
                    neutral: AdaptiveColor(light: .slate47, dark: .slate42, increasedLight: .slate37, increasedDark: .slate37),
                    neutralSubtle: AdaptiveColor(light: .slate94, dark: .slate19),
                    info: AdaptiveColor(.blue43, increased: .blue35),
                    infoSubtle: AdaptiveColor(light: .blue94, dark: .blue16),
                    success: AdaptiveColor(.green45, increased: .green37),
                    successSubtle: AdaptiveColor(light: .green95, dark: .green17),
                    warning: AdaptiveColor(.orange74, increased: .orange83),
                    warningSubtle: AdaptiveColor(light: .orange96, dark: .orange16),
                    critical: AdaptiveColor(.red44, increased: .red35),
                    criticalSubtle: AdaptiveColor(light: .red94, dark: .red13)
                ),
                onBackground: SemanticTokens.Colors.OnBackground(
                    brand: AdaptiveColor(.gray100),
                    brandSubtle: AdaptiveColor(light: .slate11, dark: .slate97),
                    neutral: AdaptiveColor(.gray100),
                    neutralSubtle: AdaptiveColor(light: .slate25, dark: .slate84, increasedLight: .slate11, increasedDark: .slate97),
                    info: AdaptiveColor(.gray100),
                    infoSubtle: AdaptiveColor(light: .blue35, dark: .blue76, increasedLight: .blue16, increasedDark: .blue94),
                    success: AdaptiveColor(.gray100),
                    successSubtle: AdaptiveColor(light: .green37, dark: .green80, increasedLight: .green17, increasedDark: .green95),
                    warning: AdaptiveColor(.slate11),
                    warningSubtle: AdaptiveColor(light: .orange36, dark: .orange83, increasedLight: .orange16, increasedDark: .orange96),
                    critical: AdaptiveColor(.gray100),
                    criticalSubtle: AdaptiveColor(light: .red35, dark: .red75, increasedLight: .red13, increasedDark: .red94)
                ),
                foreground: SemanticTokens.Colors.Foreground(
                    primary: AdaptiveColor(light: .slate11, dark: .slate97, increasedLight: .slate11, increasedDark: .gray100),
                    secondary: AdaptiveColor(light: .slate37, dark: .slate73, increasedLight: .slate25, increasedDark: .slate84),
                    tertiary: AdaptiveColor(light: .slate43, dark: .slate66, increasedLight: .slate37, increasedDark: .slate73),
                    disabled: AdaptiveColor(light: .slate66, dark: .slate47, increasedLight: .slate53, increasedDark: .slate58),
                    brand: AdaptiveColor(.accent),
                    info: AdaptiveColor(light: .blue40, dark: .blue69, increasedLight: .blue35, increasedDark: .blue76),
                    success: AdaptiveColor(light: .green43, dark: .green74, increasedLight: .green37, increasedDark: .green80),
                    warning: AdaptiveColor(light: .orange43, dark: .orange78, increasedLight: .orange36, increasedDark: .orange83),
                    critical: AdaptiveColor(light: .red42, dark: .red68, increasedLight: .red35, increasedDark: .red75)
                ),
                border: SemanticTokens.Colors.Border(
                    subtle: AdaptiveColor(light: .slate84, dark: .slate25, increasedLight: .slate53, increasedDark: .slate58),
                    strong: AdaptiveColor(light: .slate53, dark: .slate58, increasedLight: .slate37, increasedDark: .slate73),
                    brand: AdaptiveColor(.accent),
                    info: AdaptiveColor(
                        light: AdaptiveColor.Alias(.blue40, opacity: .opacity30),
                        dark: AdaptiveColor.Alias(.blue69, opacity: .opacity30),
                        increasedLight: AdaptiveColor.Alias(.blue40),
                        increasedDark: AdaptiveColor.Alias(.blue69)
                    ),
                    success: AdaptiveColor(
                        light: AdaptiveColor.Alias(.green43, opacity: .opacity30),
                        dark: AdaptiveColor.Alias(.green74, opacity: .opacity30),
                        increasedLight: AdaptiveColor.Alias(.green43),
                        increasedDark: AdaptiveColor.Alias(.green74)
                    ),
                    warning: AdaptiveColor(
                        light: AdaptiveColor.Alias(.orange43, opacity: .opacity30),
                        dark: AdaptiveColor.Alias(.orange78, opacity: .opacity30),
                        increasedLight: AdaptiveColor.Alias(.orange43),
                        increasedDark: AdaptiveColor.Alias(.orange78)
                    ),
                    critical: AdaptiveColor(light: .red42, dark: .red68, increasedLight: .red35, increasedDark: .red75),
                    criticalSubtle: AdaptiveColor(
                        light: AdaptiveColor.Alias(.red42, opacity: .opacity30),
                        dark: AdaptiveColor.Alias(.red68, opacity: .opacity30),
                        increasedLight: AdaptiveColor.Alias(.red42),
                        increasedDark: AdaptiveColor.Alias(.red68)
                    )
                ),
                focus: SemanticTokens.Colors.Focus(
                    ring: AdaptiveColor(AdaptiveColor.Alias(.accent, opacity: .opacity30), increased: AdaptiveColor.Alias(.accent))
                )
            ),
            spacing: SemanticTokens.Spacing(
                xxSmall: SemanticTokens.Spacing.Value(.space2),
                xSmall: SemanticTokens.Spacing.Value(.space4),
                small: SemanticTokens.Spacing.Value(.space8),
                medium: SemanticTokens.Spacing.Value(.space16),
                large: SemanticTokens.Spacing.Value(.space24),
                xLarge: SemanticTokens.Spacing.Value(.space32),
                xxLarge: SemanticTokens.Spacing.Value(.space48)
            ),
            typography: SemanticTokens.Typography(
                design: .default,
                largeTitle: .fontSize26,
                title: .fontSize22,
                title2: .fontSize17,
                title3: .fontSize15,
                headline: .fontSize13,
                subheadline: .fontSize11,
                body: .fontSize13,
                callout: .fontSize12,
                footnote: .fontSize10,
                caption: .fontSize10,
                caption2: .fontSize10
            ),
            radius: SemanticTokens.Radius(
                small: SemanticTokens.Radius.Value(.radius4),
                medium: SemanticTokens.Radius.Value(.radius8),
                large: SemanticTokens.Radius.Value(.radius12),
                xLarge: SemanticTokens.Radius.Value(.radius20)
            ),
            borderWidth: SemanticTokens.BorderWidth(
                thin: SemanticTokens.BorderWidth.Value(.stroke1),
                medium: SemanticTokens.BorderWidth.Value(.stroke2),
                thick: SemanticTokens.BorderWidth.Value(.stroke3)
            ),
            motion: SemanticTokens.Motion(
                quick: SemanticTokens.Motion.Value(.duration150),
                standard: SemanticTokens.Motion.Value(.duration250),
                slow: SemanticTokens.Motion.Value(.duration400)
            )
        ),
        components: Components(
            activityIndicator: Components.ActivityIndicator(
                largePlaceholderSize: Components.Size(.size48),
                extraLargePlaceholderSize: Components.Size(.size64)
            ),
            actionButton: Components.ActionButton(
                activityIndicatorDelay: Components.Delay(\.quick)
            ),
            statusIcon: Components.StatusColors(
                info: \.foreground.info,
                success: \.foreground.success,
                warning: \.foreground.warning,
                error: \.foreground.critical
            ),
            inlineAlert: Components.InlineAlert(
                background: Components.StatusColors(
                    info: \.background.infoSubtle,
                    success: \.background.successSubtle,
                    warning: \.background.warningSubtle,
                    error: \.background.criticalSubtle
                ),
                border: Components.StatusColors(
                    info: \.border.info,
                    success: \.border.success,
                    warning: \.border.warning,
                    error: \.border.criticalSubtle
                ),
                borderWidth: Components.BorderWidth(\.thin),
                radius: Components.Radius(\.medium),
                padding: Components.Spacing(\.medium),
                iconSize: Components.Size(.size16),
                iconSpacing: Components.Spacing(\.small),
                noticeSpacing: Components.Spacing(\.small),
                titleSpacing: Components.Spacing(\.xxSmall)
            ),
            edgeCase: Components.EdgeCase(
                iconSize: Components.Size(.size64),
                imageRadius: Components.Radius(\.large)
            )
        )
    )
}
