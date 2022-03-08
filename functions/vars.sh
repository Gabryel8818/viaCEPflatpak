#!/usr/bin/env bash


function validateCep(){

  if [[ -z $CEP ]]
  then
    zenity --info --text="Error invalid CEP"; exit
  fi
}

function buscaCep(){
  local json_file="cep.json"
  CEP=$(zenity --entry        \
               --text="Digite seu CEP" \
               --entry-text=""
        )

  validateCep

  CEP=$(echo ${CEP%|})
  curl -s "https://viacep.com.br/ws/$CEP/json/" > "$json_file"
  RUA=$(grep -Po '"'"logradouro"'"\s*:\s*"\K([^"]*)' "$json_file")
  UF=$(echo $CURL  | grep -Po '"'"uf"'"\s*:\s*"\K([^"]*)' "$json_file")
}


function form(){
  FORM=$(zenity --list \
                --title="Test Entry Box" \
                --text=""                \
                --column="Nome"          \
                --column="Descrição"     \
                "CEP" "$CEP"             \
                "RUA" "$RUA"             \
                "UF" "$UF"
        )
}




