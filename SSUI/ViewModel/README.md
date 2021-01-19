#  SSUIViewModel

This class provides some basic features that you can subclass and use.
**Note:** SwiftUI has a known error of `@Published` properties in subclasses of ObservableObject doesn't work. To work around that, we need to update a dummy published properties in the superclass. Here is how it's done:
``` Swift
class YourViewModel: SSUIViewModel {
    @Published var yourProperty: YourType {
        didSet {
            didSetAPublishedProperty()
        }
    }
}
```

To make the features provided by this class work, your View struct needs to invoke them like so:<br/>
To learn more about `form`, `alert`, and `loading`, please go back to the main page, there should be a link to the guide for each one
``` Swfit
struct YourView: View {
    @ObservedObject var viewModel = YourViewModel()
    var body: some View {
        Text("Hello there")
            .form(isPresented: viewModel.isFormShownBinding, configs: OkeeForm.configs, form: viewModel.form)
            .alert(isPresented: viewModel.isAlertShownBinding, configs: OkeeAlert.configs, alert: viewModel.alert)
            .loading(isPresented: viewModel.isLoadingBinding, config: OkeeLoadingScreen.simple)
    }
}
```


