#!/usr/bin/env bash

if [ ! -d log ]
then
    mkdir log
fi

persist_log_data() {
    local ten_main_system_process=$(ps -e -o pid --sort -size | head -n 11 | grep [0-9])
    
    for process in $ten_main_system_process
    do
        local process_name=$(ps -p $process -o comm=)
        echo -n $(date +%F,%H:%M:%S) >> log/$process_name.log
        local kbytes=$(ps -p $process -o size | grep [0-9])
        echo " - Consumo de: $(bc <<< "scale=2;$kbytes/1024") MB" >> log/$process_name.log
    done
}

persist_log_data 2>log/script-erro.txt
if [ $? -eq 0 ]
then
    echo "Consumo de memória logado com sucesso."
else
    echo "Houve um problema no processo de log."
fi