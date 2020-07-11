# -*- coding: utf-8 -*-
import voice_changer
import os
import subprocess
import sched, time

file = "pattern_out.txt"
s = sched.scheduler(time.time, time.sleep)



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
    f = open(file)
    pattern = f.read()
    pattern = pattern.replace('\n','')
    print("pattern:" + pattern)

    if (pattern == "recode"):
        voice_changer.doing_all()


def do_something(sc):
    print "Doing stuff..."
    pattern_loop()
    s.enter(3, 1, do_something, (sc,))

# voice_changer.doing_all()
# voice_changer.play(output_file)

def main():

    s.enter(3, 1, do_something, (s,))
    s.run()







if __name__ == '__main__':
    main()
