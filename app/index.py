# -*- coding: utf-8 -*-
import voice_changer
import os
import subprocess
import time

file = "pattern_out.txt"



#processing起動用コード
def processing_exe():

    #ボイスチェンジャーのアウトプットデータ
    output_file = "./dist/vc_out/output.raw"

    #絶対パスを取得しコマンドを配列に格納
    abs_path = os.path.abspath("")
    command = ["processing-java", "--sketch=" + abs_path, "--run"]

    #配列に格納されたprocessing実行コマンドを実行（エラー処理付き）
    try:
        res = subprocess.check_call(command)
    except:
        print("Error")


def pattern_loop():
    while True:
        f = open(file, "r", encoding="utf_8")
        pattern = f.read()
        print("processing...")
        print("pattern:" + pattern)
        print(pattern == "nomal")
        if (pattern == "recode"):
            break


# voice_changer.doing_all()
# voice_changer.play(output_file)

def main():

    pattern_loop()
    voice_changer.doing_all()




if __name__ == '__main__':
    main()
