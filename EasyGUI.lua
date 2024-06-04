function GUI(terminal, backgroundColor)
    screen = terminal
    screenW, screenH = screen.getSize()
    styleLookup = {
        box = 0,
        minimal = 1,
        border = 2
    }

    return {
        backgroundColor = backgroundColor,
        screen = screen,
        screenW = screenW,
        screenH = screenH,
        buttonList = {},
        elementList = {},

        RegisterElement = function (self, name, func, color, pressColor, textColor, textPressedColor, style, originX, originY, sizeX, sizeY)
            local Rbound = originX+sizeX
            local BBound = originY+sizeY
            -- make sure we're getting a valid style
            if styleLookup[style] == nil then
                error(tostring(style).." is an invalid style. Double check the spelling.")
            end

            -- if the function is nil then it is a ui element, if not, it is a button
            if func == nil then
                self.elementList[name] = {
                    name = name,
                    func = func,
                    LBound = originX,
                    RBound = Rbound,
                    TBound = originY,
                    BBound = BBound,
                    sizeX = sizeX,
                    sizeY = sizeY,
                    color = color,
                    textColor = textColor,
                    style = styleLookup[style]
                }
            else
                self.buttonList[name] =  {
                    name = name,
                    func = func,
                    LBound = originX,
                    RBound = Rbound,
                    TBound = originY,
                    BBound = BBound,
                    sizeX = sizeX,
                    sizeY = sizeY,
                    color = color,
                    pressColor = pressColor,
                    textColor = textColor,
                    textPressedColor = textPressedColor,
                    style = styleLookup[style], 
                    pressed = false
                }
            end
        end,

        SplitLines = function (self, text, width)
            local words = {}
            for word in string.gmatch(text, "%S+") do
                table.insert(words, word)
            end

            local lines = {}
            local currentLine = ""
            for _, word in ipairs(words) do
                if #currentLine + #word < width then
                    if currentLine == "" then currentLine = word
                    else currentLine = currentLine..' '..word end
                else
                    table.insert(lines, currentLine)
                    currentLine = word
                end
            end
            if currentLine ~= "" then table.insert(lines, currentLine) end

            return lines
        end,

        DrawText = function (self, x, y, text, width)
            for i, line in ipairs(self:SplitLines(text, width-1)) do
                screen.setCursorPos(x, y+i-1)
                screen.write(line)
            end
        end,

        DrawButton = function (self, button)
            if button.style == 0 then
                if not button.pressed then
                    paintutils.drawFilledBox(button.LBound, button.TBound, button.RBound, button.BBound, button.color)
                    screen.setTextColor(button.textColor)
                else
                    paintutils.drawFilledBox(button.LBound, button.TBound, button.RBound, button.BBound, button.pressColor)
                    screen.setTextColor(button.textPressedColor)
                end
                self:DrawText(button.LBound+1, button.TBound+1, button.name, button.sizeX)
            elseif button.style == 1 then
                if not button.pressed then
                    screen.setBackgroundColor(button.color)
                    screen.setTextColor(button.textColor)
                else
                    screen.setBackgroundColor(button.pressColor)
                    term.setTextColor(button.textPressedColor)
                end
                self:DrawText(button.LBound, button.TBound, button.name, button.sizeX+2)
            elseif button.style == 2 then
                -- adding the border
                if not button.pressed then
                    screen.setBackgroundColor(self.backgroundColor)
                    screen.setTextColor(button.color)
                else
                    screen.setBackgroundColor(self.backgroundColor)
                    screen.setTextColor(button.pressColor)
                end  

                for i = 1, button.BBound-button.TBound-1, 1 do -- left side
                    screen.setCursorPos(button.LBound,button.TBound+i)
                    screen.write("\x95")
                end

                for i = 1, button.BBound-button.TBound-1, 1 do -- right side
                    screen.setCursorPos(button.RBound,button.TBound+i)
                    screen.write("\x95")
                end

                screen.setCursorPos(button.LBound,button.BBound)-- bottom part
                screen.write("\x8d")
                for i = 1, button.RBound-button.LBound-1, 1 do
                    screen.write("\x8c")
                end
                screen.write("\x85")
        
                screen.setCursorPos(button.LBound,button.TBound)-- top part
                screen.write("\x9c")
                for i = 1, button.RBound-button.LBound-1, 1 do
                    screen.write("\x8c")
                end
                screen.write("\x94")

                -- writing text
                if not button.pressed then
                    screen.setTextColor(button.textColor)
                else
                    screen.setTextColor(button.textPressedColor)
                end
                self:DrawText(button.LBound+1, button.TBound+1, button.name, button.sizeX)
            end
        end,

        DrawElement = function (self, element)
            if element.style == 0 then
                paintutils.drawFilledBox(element.LBound, element.TBound, element.RBound, element.BBound, element.color)
                screen.setTextColor(element.textColor)
                self:DrawText(element.LBound+1, element.TBound+1, element.name, element.sizeX)
            elseif element.style == 1 then
                screen.setBackgroundColor(element.color)
                screen.setTextColor(element.textColor)
                self:DrawText(element.LBound, element.TBound, element.name, element.sizeX+2)
            elseif element.style == 2 then
                -- adding the border
                screen.setBackgroundColor(self.backgroundColor)
                screen.setTextColor(element.color)

                for i = 1, element.BBound-element.TBound-1, 1 do -- left side
                    screen.setCursorPos(element.LBound,element.TBound+i)
                    screen.write("\x95")
                end

                for i = 1, element.BBound-element.TBound-1, 1 do -- right side
                    screen.setCursorPos(element.RBound,element.TBound+i)
                    screen.write("\x95")
                end

                screen.setCursorPos(element.LBound,element.BBound)-- bottom part
                screen.write("\x8d")
                for i = 1, element.RBound-element.LBound-1, 1 do
                    screen.write("\x8c")
                end
                screen.write("\x85")
        
                screen.setCursorPos(element.LBound,element.TBound)-- top part
                screen.write("\x9c")
                for i = 1, element.RBound-element.LBound-1, 1 do
                    screen.write("\x8c")
                end
                screen.write("\x94")

                -- writing text
                screen.setTextColor(element.textColor)
                self:DrawText(element.LBound+1, element.TBound+1, element.name, element.sizeX)
            end
        end,

        Update = function (self) 
            local event,lr,x,y = os.pullEvent()
            if event == "mouse_click" then 
                for _,button in pairs(self.buttonList) do
                    if x >= button.LBound and x <= button.RBound and y >= button.TBound and y <= button.BBound then
                        button.pressed = true
                        self:DrawButton(button)
                        break
                    end
                end
            elseif event == "mouse_up" then 
                local run = true
                for _,button in pairs(self.buttonList) do
                    if run and x >= button.LBound and x <= button.RBound and y >= button.TBound and y <= button.BBound and button.pressed == true then
                        button.func()
                        run = false
                    end
                    button.pressed = false
                    self:DrawButton(button)
                end
            end
        end,

        DrawScreen = function (self)
            -- draws all the outlines and static elements, only needs to be used at frame one as well as when a change overwrites the background
            screen.setBackgroundColor(backgroundColor)
            screen.clear()
            
            for i,element in pairs(self.elementList) do -- draw all buttons
                self:DrawElement(element)
            end

            for i,button in pairs(self.buttonList) do -- draw all buttons
                self:DrawButton(button)
            end
        end,

        Run = function (self)
            self:DrawScreen()
            while true do
                self:Update()
            end
        end
    }
end