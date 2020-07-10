# -*- coding: utf-8 -*-
import voice_changer
import os
import subprocess

#ボイスチェンジャーのアウトプットデータ
output_file = "./dist/vc_out/output.raw"

#絶対パスを取得しコマンドを配列に格納
abs_path = os.path.abspath("")
command = ["processing-java", "--sketch=" + abs_path, "--run"]

#配列に格納されたprocessing実行コマンドを実行（エラー処理付き）
try:
    res = subprocess.check_call(command)
except:
    print "Error."


#voice_changer.doing_all()
#voice_changer.play(output_file)
