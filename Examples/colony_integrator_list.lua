---
--- Made for the Advanced Peripherals documentation
--- Created by Srendi - Created by Srendi - https://github.com/SirEndii
--- DateTime: 25.04.2021 20:44
--- Link: https://docs.srendi.de/peripherals/colony_integrator/
--- Edited by Nin for things and stuff?
 
 
colony = peripheral.find("colonyIntegrator")
mon = peripheral.find("monitor")
chat = peripheral.find("chatBox")
 
function centerText(text, line, txtback, txtcolor, pos)
    monX, monY = mon.getSize()
    mon.setBackgroundColor(txtback)
    mon.setTextColor(txtcolor)
    length = string.len(text)
    dif = math.floor(monX-length)
    x = math.floor(dif/2)
    
    if pos == "head" then
        mon.setCursorPos(x+1, line)
        mon.write(text)
    elseif pos == "left" then
        mon.setCursorPos(2, line)
        mon.write(text) 
    elseif pos == "right" then
        mon.setCursorPos(monX-length, line)
        mon.write(text)
    end
end
 
function prepareMonitor() 
    mon.clear()
    mon.setTextScale(.5)
    centerText("Citizens", 1, colors.black, colors.white, "head")
end
 
function printCitizens()
    row = 3
    useLeft = true
    for k, v in ipairs(colony.getCitizens()) do
        if row > 40 then
            useLeft = false
            row = 3
        end
        
        var_colour = ""
        if v.state == "Sick" then
            var_colour = colors.red
            chat.sendMessage(v.name.." is Sick!")
        elseif v.state == "Sleeping zZZ" then
            var_colour = colors.gray
        elseif v.state == "Hungry" then
            var_colour = colors.orange
        else
            var_colour = colors.white
        end
        
        if useLeft then
            centerText(v.name.. " - State: "..v.state, row, colors.black, var_colour, "left")        
        else
            centerText(v.name.. " - State: "..v.state, row, colors.black, var_colour, "right")
        end
        row = row+1
    end
end
 
prepareMonitor()
 
while true do
    mon.clear()
    prepareMonitor()
    printCitizens()
    sleep(10)
end
