# CCEasyGui
This is a simple library for ComputerCraft that allows you to make buttons and gui elements with ease. This is a simple library for simple programs e.g. controlling redstone with a button.

---
# Features
- You can create buttons and elements using the ```RegisterElement()``` function. 
- Buttons and their text will change color when pressed.
- Buttons will only execute if you let go over the button, just like a pc.
- Text for buttons and elements are word wrapped. Just make sure everything has enough room to fit.

---
# Usage
## Installation
Download the 'EasyGui.lua' file and upload it to the computer. You can simply drag n' drop from your pc in modern version of CC, in older versions you'll have to use pastebin. And if http is disable on the server 🤷

## Usage
Load the library using
```os.loadAPI("EasyGUI.lua")```

Once loaded create a *one* object using
```gui = EasyGUI.GUI(*terminal or monitor*, *background color*)```

Use ```RegisterElement()``` to create your buttons and elements.
It takes 11 arguments; here's how you would make a button
```
RegisterElement("element text/name", function() *what ever you want it to do* end, *background color*, *background when pressed*, *text color*, *text color when pressed*, *style*, *originX*, *originY*, *width*, *height*)
```
To create an element it would look something like this
```
RegisterElement("element text/name", nil, *background color*, nil, *text color*, nil, *style*, *originX*, *originY*, *width*, *height*)
```

Use ```Run()``` to start rendering the gui. This will loop forever checking for button presses.

### Styles
There are three element styles right now and you pass them to ```RegisterElement()``` by their string.
- "box"
- "minimal"
- "border"

### Notes
- The height and width specify the visual borders of the element and the hitboxes of buttons; even if you use the minimal style it will still register clicks within its bounds.
- Colors are specified using the builtin ```colors``` class e.g. ```colors.blue```
- If you specify a function it will behave as a button, if it is nill, it will behave as a static element and cannot be pressed.
- Be careful not to overlap buttons, they'll behave unexpectedly.

## Example
```
os.loadAPI("EasyGUI.lua")

gui = EasyGUI.GUI(term.current(), colors.black)

gui:RegisterElement("Box Button", function () end, colors.green, colors.blue, colors.red, colors.white, "box", 2, 2, 13, 2)
gui:RegisterElement("Minimal Button", function () end, colors.red, colors.white, colors.white, colors.red, "minimal", 17, 2, 14, 0)
gui:RegisterElement("Bordered Button", function () end, colors.blue, colors.gray, colors.white, colors.lightGray, "border", 2, 6, 17, 2)
gui:RegisterElement("This element meant to be a long text and should be automatically wrapped", nil, colors.blue, nil, colors.white, nil, "border", 21, 6, 17, 7)

gui:Run()
```
This script will register three buttons and one element with word wrapping.

![image](https://github.com/memesanddremes/CCEasyGui/assets/47585547/a65d4b7a-f0a0-49cb-af6b-8864ffdc3c20)
