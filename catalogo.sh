#!/usr/bin/env bash

function buscaCep(){
  local json_file="cep.json"
  CEP=$(zenity --entry        \
            --text="Digite seu CEP" \
            --entry-text="")
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
                "UF" "$UF")
}


#Chama a função que de fato busca os ceps e cria as variaveis
buscaCep

#chama a função que cria o formulário preenchido
form
