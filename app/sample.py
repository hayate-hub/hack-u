import voice_changer
import os
import subprocess
import time


for i in range(100):
        time.sleep(3)
        f = open("pattern_out.txt")
        pattern = f.read()
        print("processing...")
        print("pattern:" + pattern)
        if int(pattern) == 1 :
            break

voice_changer.doing_all()
