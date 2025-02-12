# TSAlertController

<div align="left">

<a href="https://cocoapods.org/pods/TSAlertController">
    <img src="https://img.shields.io/cocoapods/v/TSAlertController.svg?style=flat" alt="Version">
</a>
<a href="https://cocoapods.org/pods/TSAlertController">
    <img src="https://img.shields.io/cocoapods/l/TSAlertController.svg?style=flat" alt="License">
</a>
<a href="https://cocoapods.org/pods/TSAlertController">
    <img src="https://img.shields.io/cocoapods/p/TSAlertController.svg?style=flat" alt="Platform">
</a>

</div>

<br>

```
⚠️ This open-source project has not been released yet!
```

![Image1]()

## Usage

To display a simple alert:

```swift
let alert = TSAlertController(
    title: "The title of the alert.",
    message: "Descriptive text that provides more details about the reason for the alert.",
    preferredStyle: .alert
)

let okAction = TSAlertAction(title: "OK")
alert.addAction(okAction)

present(alert, animated: true)
```

<details>
  <summary>Preview</summary>

<img src="" width="250px">

</details>

TSAlertController mimics the interface of UIAlertController to minimize the learning curve.


And like UIAlertController, you can also add a UITextField to the alert:

```swift
let alert = TSAlertController(title: "Sign In",
                              message: "Please enter your username and password to access your account.",
                              options: [.dismissOnTapOutside],
                              preferredStyle: .alert)

let okAction = TSAlertAction(title: "Sign In")
alert.addAction(okAction)
alert.preferredAction = okAction

let cancelAction = TSAlertAction(title: "Cancel", style: .cancel)
cancelAction.configuration.backgroundColor = .systemBlue
alert.addAction(cancelAction)

alert.addTextField { textfield in
    textfield.placeholder = "Username"
}
alert.addTextField { textfield in
    textfield.placeholder = "Password"
}

present(alert, animated: true)
```

<details>
  <summary>Preview</summary>

<img src="" width="250px">

</details>


### Customizing Appearance

To customize font attributes, use `TSAlertController.ViewConfiguration`:

```swift
let alert = TSAlertController(
    title: "Current Location Not Available",
    message: "Your current location can't be determined at this time.",
    preferredStyle: .alert
)
alert.viewConfiguration.titleAttributes = [.font: .boldSystemFont(ofSize: 24)]

// Same setup as the previous example...
```

<details>
  <summary>Preview</summary>

<img src="" width="250px">

</details>

With `TSAlertController.ViewConfiguration`, you can modify attributes such as title and message fonts, background color, border radius, button alignment (axis), and more.
For more details, refer to the [ViewConfiguration]() section.


### Interactive Features

TSAlertController also supports interactive user actions:

```swift
let actionSheet = TSAlertController(
    title: "Choose an Option",
    message: "Select an action from the list below.",
    options: [.interactiveScaleAndDrag, .dismissOnSwipeDown, .dismissOnTapOutside],
    preferredStyle: .actionSheet
)
actionSheet.viewConfiguration.buttonGroupAxis = .vertical

let okAction = TSAlertAction(title: "OK")
actionSheet.addAction(okAction)

let cancelAction = TSAlertAction(title: "Cancel", style: .cancel)
actionSheet.addAction(cancelAction)

present(actionSheet, animated: true)
```

<details>
  <summary>Preview</summary>

<img src="" width="250px">

</details>


### Alert With Custom View

You can add a custom-designed view as the header of the alert:

```swift
let marketCap = MarketCapView()
let actionSheet = TSAlertController(
    marketCap,
    options: [.dismissOnSwipeDown, .interactiveScaleAndDrag],
    preferredStyle: .actionSheet
)

let okAction = TSAlertAction(title: "Confirm")
okAction.configuration.backgroundColor = .systemBlue
actionSheet.addAction(okAction)

present(actionSheet, animated: true)
```

<details>
  <summary>Preview</summary>

<img src="" width="250px">

</details>



### Configuration options

The `TSAlertController.Configuration` struct defines various behaviors for the alert, including animations and UI preferences.

| Name                   | Description                                                 | Type                                              | Default |
|------------------------|-------------------------------------------------------------|---------------------------------------------------|---------|
| `enteringTransition`   | The transition animation type when the alert appears. For `.actionSheet`, it defaults to `.slideUp`. For `.alert`, it defaults to `.fadeInAndScaleDown`. | `TSAlertController.EnteringTransitionType?`      | `nil`   |
| `exitingTransition`    | The transition animation type when the alert disappears. For `.actionSheet`, it defaults to `.slideDown`. For `.alert`, it defaults to `.fadeOut`. | `TSAlertController.ExitingTransitionType?`       | `nil`   |
| `headerAnimation`      | The animation type for the alert’s header when presented.  | `TSAlertController.AnimationType?`               | `nil`   |
| `buttonGroupAnimation` | The animation type for the button group when presented.    | `TSAlertController.AnimationType?`               | `nil`   |
| `prefersGrabberVisible` | A Boolean value indicating whether a grabber (handle) should be visible. | `Bool` | `true` |


### ViewConfiguration options

The `TSAlertController.ViewConfiguration` struct defines various visual and layout configurations for the alert.

| Name                              |                                    Description                                           | Type                                         | Default |
|-----------------------------------|------------------------------------------------------------------------------------------|----------------------------------------------|---------|
| `titleHeight`                     | The fixed height of the title area. If `nil`, the height adjusts dynamically.            | `CGFloat?`                                  | `nil`   |
| `messageHeight`                   | The fixed height of the message area. If `nil`, the height adjusts dynamically.          | `CGFloat?`                                  | `nil`   |
| `buttonHeight`                    | The height of each button in the button group.                                          | `CGFloat`                                   | `45`    |
| `grabberColor`                    | The color of the grabber (handle) used for dragging.                                    | `UIColor?`                                  | `.systemGray5` |
| `titleTextAttributes`             | Text attributes for styling the title.                                                  | `[NSAttributedString.Key: Any]?`            | `Headline font with default color` |
| `titleTextAlignment`              | The text alignment of the title.                                                        | `NSTextAlignment`                           | `.left` |
| `titleNumberOfLines`              | The number of lines for the title. If `0`, the title expands dynamically.               | `Int`                                       | `0`     |
| `messageTextAttributes`           | Text attributes for styling the message.                                                | `[NSAttributedString.Key: Any]?`            | `Subheadline font` |
| `messageTextAlignment`            | The text alignment of the message.                                                      | `NSTextAlignment`                           | `.left` |
| `messageNumberOfLines`            | The number of lines for the message. If `0`, the message expands dynamically.           | `Int`                                       | `0`     |
| `textFieldContainerBorderColor`   | The border color of the container wrapping the text field.                              | `CGColor?`                                  | `.lightGray` |
| `textFieldContainerBorderWidth`   | The border width of the container wrapping the text field.                              | `CGFloat`                                   | `0.75`  |
| `backgroundColor`                 | The background style of the alert.                                                      | `Background`                                | `.systemBackground` |
| `backgroundBorderColor`           | The border color of the alert’s background.                                             | `CGColor?`                                  | `nil`   |
| `backgroundBorderWidth`           | The border width of the alert’s background.                                             | `CGFloat`                                   | `0`     |
| `shadow`                          | The shadow configuration for the alert view.                                            | `Shadow?`                                   | `nil`   |
| `cornerRadius`                    | The corner radius of the alert view.                                                    | `CGFloat`                                   | `20`    |
| `dimmedBackgroundViewColor`       | The background color of the dimmed overlay behind the alert.                            | `Background?`                               | `.black with 0.75 opacity` |
| `margin`                          | The margins applied around the alert view.                                              | `LayoutMargin`                              | `.init()` |
| `spacing`                         | The spacing settings applied within the alert layout.                                   | `LayoutSpacing`                             | `.init()` |
| `size`                            | The size configuration of the alert.                                                    | `LayoutSize`                                | `.init()` |
| `buttonGroupAxis`                 | The axis layout of the button group (horizontal or vertical).                           | `ButtonGroupAxis`                           | `.automatic` |

---

#### Background Options

The `TSAlertController.ViewConfiguration.Background` enum defines different background styles for the alert.

| Name       | Description |
|------------|------------|
| `.blur(UIBlurEffect.Style)` | Uses a blurred background with the specified `UIBlurEffect.Style`. |
| `.color(UIColor, alpha: CGFloat)` | Uses a solid color background with an optional alpha value (opacity). |
| `.gradient([CGColor], startPoint: CGPoint, endPoint: CGPoint, locations: [NSNumber]?)` | Uses a gradient background with customizable colors, direction, and location stops. |

---

#### LayoutMargin Options

The `TSAlertController.ViewConfiguration.LayoutMargin` struct defines margin settings for content and buttons.

| Name            | Description                               | Type     | Default |
|----------------|-------------------------------------------|---------|---------|
| `contentTop`   | The top margin for the content area.      | `CGFloat` | `22.5`  |
| `contentLeft`  | The left margin for the content area.     | `CGFloat` | `17.5`  |
| `contentRight` | The right margin for the content area.    | `CGFloat` | `17.5`  |
| `buttonLeft`   | The left margin for the button area.      | `CGFloat` | `17.5`  |
| `buttonRight`  | The right margin for the button area.     | `CGFloat` | `17.5`  |
| `buttonBottom` | The bottom margin for the button area.    | `CGFloat` | `17.5`  |

---

#### LayoutSpacing Options

The `TSAlertController.ViewConfiguration.LayoutSpacing` struct defines spacing settings within the alert layout.

| Name                      | Description                                           | Type     | Default |
|---------------------------|-------------------------------------------------------|---------|---------|
| `titleMessageSpacing`     | Spacing between the title and the message.           | `CGFloat` | `12.5`  |
| `messageTextfieldSpacing` | Spacing between the message and the text field.      | `CGFloat` | `12.5`  |
| `textfieldButtonSpacing`  | Spacing between the text field and the button.       | `CGFloat` | `16.5`  |
| `buttonSpacing`           | Spacing between buttons in the button group.        | `CGFloat` | `7.5`   |
| `keyboardSpacing`         | Spacing between the alert bottom and the keyboard.  | `CGFloat` | `100`   |

---

#### LayoutSize Options

The `TSAlertController.ViewConfiguration.LayoutSize` struct defines the width and height constraints of the alert.

| Name    | Description                         | Type                         | Default |
|---------|-------------------------------------|------------------------------|---------|
| `width` | Width constraint for the alert.    | `LayoutSize.Constraint`      | `.proportional()` |
| `height` | Height constraint for the alert.  | `LayoutSize.Constraint`      | `.proportional()` |

---

#### LayoutSize.Constraint Options

The `TSAlertController.ViewConfiguration.LayoutSize.Constraint` enum defines different constraints for width and height.

| Name | Description |
|------|------------|
| `.fixed(CGFloat)` | Sets a fixed size for the alert. |
| `.flexible(minimum: CGFloat, maximum: CGFloat)` | Sets a flexible size with minimum and maximum values. |
| `.proportional(minimumRatio: CGFloat, maximumRatio: CGFloat)` | Sets a size relative to the screen size. |

---

#### ButtonGroupAxis Options

The `TSAlertController.ViewConfiguration.ButtonGroupAxis` enum defines the layout direction of buttons in the alert.

| Name          | Description |
|--------------|------------|
| `.automatic` | Uses a horizontal layout if there are two or fewer buttons; otherwise, uses a vertical layout. |
| `.vertical`  | Forces a vertical button layout. |
| `.horizontal` | Forces a horizontal button layout. |

 
## Examples

You can find the example files [here]().

 
 
## Installation

### Swift Package Manager

You can use The Swift Package Manager to install Toast-Swift by adding the description to your Package.swift file:

```swift
dependencies: [
    .package(url: "", from: "0.1.0")
]
```

### CocoaPods

```ruby
pod ""
```

## Roadmap

You can check the upcoming changes for TSAlertController [here]().


## Contribution

All types of contributions are welcome, from minor typo fixes and comment improvements to adding new features! Bug reports and feature requests are also highly appreciated, and I will actively review them.  

TSAlertController is continuously updated with the goal of providing an easy-to-use, modern, and elegant alert system for everyone. I truly appreciate your support! 😃   

<div align="left">

<!-- Replace with actual contributor images -->
<a href="#"><img src="https://via.placeholder.com/80" width="80" height="80" style="border-radius: 50%; margin: 5px;"></a>
<a href="#"><img src="https://via.placeholder.com/80" width="80" height="80" style="border-radius: 50%; margin: 5px;"></a>
<a href="#"><img src="https://via.placeholder.com/80" width="80" height="80" style="border-radius: 50%; margin: 5px;"></a>
<a href="#"><img src="https://via.placeholder.com/80" width="80" height="80" style="border-radius: 50%; margin: 5px;"></a>
<a href="#"><img src="https://via.placeholder.com/80" width="80" height="80" style="border-radius: 50%; margin: 5px;"></a>

</div>

## License

TSAlertController is available under the MIT license. See the LICENSE file for more info.
