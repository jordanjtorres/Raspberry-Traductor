echo "Grabando... (Presiona Ctrl+C al terminar de hablar)"
arecord -D plughw:0,0 -q -f cd -t wav -d 0 -r 16000 | flac - -f --best --sample-rate 16000 -s -o daveconroy.flac;
 
echo "Convirtiendo audio a texto..."
wget -q -U "Mozilla/5.0" --post-file daveconroy.flac --header "Content-Type: audio/x-flac; rate=16000" -O - "http://www.google.com/speech-api/v1/recognize?lang=es-es&client=chromium" | cut -d\" -f12  > stt.txt
 
echo "Dijiste:"
value=`cat stt.txt`
echo "$value"

python PiTranslate.py -o es -d en -t "$value"
