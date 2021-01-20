# SSUI
SSUI is an UI wrapper library that is 99% pure SwiftUI to simplify the UI setup further.<br/>

The idea behind SSUI is to abstract away the details of how you customize a view's look on the coding level. As a user of SSUI, you only need to focus the declarative view's appearance config. The configs that SSUI consumes can be injected as a Decoable (so you can use json or even fetch the config from remote server) or programmatically, it's your choice.<br/>

SSUI has 2 main feature: configuring a single view's appearance and other "compound" views: alert, page slider, etc. It also provides a few common used shapes.

### Single view's configuration
To customize the look of a single view, we use `SSUIViewConfig`:
``` Swift
struct OkeeButton {
    
    static let primary: SSUIViewConfig = createButtonConfig(withColor: OkeeColor.primary)
    static let secondary: SSUIViewConfig = createButtonConfig(withColor: OkeeColor.secondary)
    static let dismissive: SSUIViewConfig = createButtonConfig(withColor: OkeeColor.dismissive)
    static let cautious: SSUIViewConfig = createButtonConfig(withColor: OkeeColor.cautious)
    
    private static func createButtonConfig(withColor color: SSUIColor, maxWidth: Bool = false) -> SSUIViewConfig {
        let backgroundColor = color
        let foregroundColor = SSUIColor.color(light: .white)
        let corner = SSUICorners(topLeft: 20, topRight: 20, bottomRight: 20, bottomLeft: 20)
        let font = SSUIFont(systemFont: .body,  properties: [.bold])
        let frame = SSUIFrame(expandHorizontally: maxWidth, verticalPadding: 10, horizontalPadding: 20)
        return SSUIViewConfig(backgroundColor: backgroundColor, foregroundColor: foregroundColor,
                              corners: corner, font: font, frame: frame)
    }
}

struct Buttons: View {
    var body: some View {
        VStack {
            Button("Primary") {}.applySSUIConfig(OkeeButton.primary)
            Button("Secondary") {}.applySSUIConfig(OkeeButton.secondary)
            Button("Dismissive") {}.applySSUIConfig(OkeeButton.dismissive)
            Button("Cautious") {}.applySSUIConfig(OkeeButton.cautious)
        }
    }
}
```
The piece of code above will produce this: <br/>
![image](./Images/sample_button.png)
