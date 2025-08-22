#!/usr/bin/env python3

import subprocess
import time
import os

def is_kitty_fullscreen():
    """Check if Kitty is in fullscreen mode using AppleScript"""
    script = '''
    tell application "System Events"
        tell process "kitty"
            get value of attribute "AXFullScreen" of front window
        end tell
    end tell
    '''
    try:
        result = subprocess.run(['osascript', '-e', script], 
                              capture_output=True, text=True, check=False)
        return result.stdout.strip() == 'true'
    except:
        return False

def set_kitty_padding(padding):
    """Set kitty padding using remote control"""
    try:
        subprocess.run(['kitty', '@', 'set-spacing', f'padding={padding}'], 
                      check=False, capture_output=True)
    except:
        pass

def main():
    """Monitor fullscreen state and adjust padding accordingly"""
    last_state = None
    
    while True:
        try:
            is_fullscreen = is_kitty_fullscreen()
            
            if is_fullscreen != last_state:
                if is_fullscreen:
                    set_kitty_padding(0)
                    print("Fullscreen detected - padding set to 0")
                else:
                    set_kitty_padding(20)
                    print("Windowed mode - padding set to 20")
                
                last_state = is_fullscreen
            
        except KeyboardInterrupt:
            break
        except Exception as e:
            print(f"Error: {e}")
        
        time.sleep(0.5)  # Check every 500ms

if __name__ == "__main__":
    main()